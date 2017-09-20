#include <mips/regdef.h>
#include <sys/syscall.h>
#define ascii_A 65
#define ascii_Z 90
#define ascii_a 97
#define ascii_z 122
#define ascii_0 48
#define ascii_9 57
#define ascii_- 45
#define ascii__ 95
#define ascii_newline 10

.text
.abicalls
.align2

.globl palindrome
.ent palindrome

palindrome:							
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp
	
	sw a0, 48($fp)                      # guardamos el archivo de entrada en el stackframe
	sw a1, 52($fp)                      # guardamos el tamanio buffer entrada
    sw a2, 56($fp)                      # guardamos el archivo de salida en el stackframe
    sw a3, 60($fp)                      # guardamos el tamanio buffer salida

    move a0, a1                         #a0 = tamanio del buffer entrada

    la t9, crear_buffer
    jalr t9                           	#Crea el buffer de entrada
    beq v0, zero, error_primer_buffer	#Si devuelve 0 ocurrio un error
    sw v0, 24($fp)                      #Guardamos el buffer de entrada en el stackframe
    la t0, tam_buffer_entrada
    lw t1, 52($fp)
    sw t1, 0(t0)						#Actualizo el tamanio del buffer entrada

    lw a0, 60($fp)                      #a0 = tamanio del buffer de salida
    la t9, crear_buffer
    jalr t9                           	#Crea el buffer de salida
    beq v0, zero, error_segundo_buffer	#Si devuelve 0 ocurrio un error
    sw v0, 28($fp)                      #Guardamos el buffer de salida en el stackframe
    la t0, tam_buffer_salida
    lw t1, 60($fp)
    sw t1, 0(t0)						#Actualizo el tamanio del buffer salida
	
loop:
    lw a0, 48($fp)                      #Cargamos en a0 el archivo de entrada
	addu a1, $fp, 16                    #Cargamos en a1 el puntero a len
    lw a2, 24($fp)                      #Cargamos en a2 el buffer de entrada
	
	la t9, leer_palabra
	jalr t9                          	#Lee la proxima palabra

	sw v0, 20($fp)                      # Guardamos el puntero a la palabra
	beq v0, zero, error_inesperado      # No se pudo leer la palabra

	move a0, v0                         #a0 = puntero a palabra
    lw a1, 16 ($fp)                     #a1 = len(palabra)
	la t9, es_capicua
	jalr t9                          	#Llama a es_capicua      

	beq v0, zero, continuar_loop        #Si no es capicua continua el loop         
	
	lw a0, 56($fp)                      #a0 = archivo de salida
	lw a1, 20($fp)                      #a1 = puntero a la palabra
    lw a2, 28($fp)                      #a2 = buffer de salida
    la t9, escribir_palabra_archivo
    jalr t9                          	#Escribe la palabra en el archivo
    beq v0, zero, error_escritura		#Si devuelve 0 ocurrio un error

continuar_loop:
    
    lw a0, 20($fp)                      #a0 = puntero a palabra
    la t9, my_free
    jalr t9                           	#Llama a free(palabra)
    
    la t0, eof_leido
    lw t1, 0(t0)						#t1 = eof leido?
    beq t1, zero, loop					#si no fue leido sigue el loop
    la t0, eof_escrito
    addiu t1, zero, 1
    sw t1, 0(t0)						#actualizo eof_escrito = 1
    la t9, escribir_palabra_archivo
    jalr t9                          	#Escribe todo lo que queda en el buffer
    beq v0, zero, error_escritura		#Si devuelve 0 ocurrio un error

terminar:
	move v0, zero
free_segundo_buffer:
	lw a0, 28($fp)                      #Cargamos el buffer de salida 
	la t9,my_free
	jalr t9								#Liberamos el segundo buffer
free_primer_buffer:
	lw a0, 24($fp)                      #Cargamos el buffer de entrada 
	la t9,my_free
	jalr t9								#Liberamos el primer buffer

return:
	lw ra, 40($fp)
	lw gp, 36($fp)
	lw $fp, 32($fp)
	addiu sp, sp, 48
	jr ra

error_segundo_buffer:
	addiu v0, zero, 1					#Devuelve codigo de error 1
	b free_primer_buffer				#Libera el primer buffer
error_primer_buffer:
	addiu v0, zero, 1 					#Devuelve codigo de error 1
	b return							#No libera nada

error_escritura:
	lw a0, 20($fp)                      #a0 = puntero a la palabra
	la t9, my_free
	jalr t9								#Libera la palabra
error_inesperado:
	addiu v0, zero, 2 					#Devuelve codigo de error 2
	b free_segundo_buffer				#Libera ambos buffer
	
.end palindrome
.size palindrome,.-palindrome

#___________________________________________________________________________________________

.ent es_capicua

es_capicua:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
    sw s0, 24(sp)
    sw s1, 28(sp)
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp
	
	sw a0, 40($fp)                  # Guardamos el puntero a la palabra (primer argumento) en el stackframe
	sw a1, 44($fp)                  # Guardamos la longitud (segundo argumento) en el stackframe

	beq a1, zero, return_false      #Si len es 0 devuelve false
	
	addu s0, zero, zero             #Inicializamos la variable inicio
	subu s1, a1, 1                  #Inicializamos la variable final

loop:
	lw a0, 40($fp)          #Recuperamos el puntero a la palabra
    addu t0, a0, s0         #t0 = palabra + inicio
	lub a0, 0(t0)           # Leemos el  caracter palabra[inicio]
	la t9, my_tolower       
	jalr t9              	#Llamamos a tolower() con el caracter
	sw v0, 16($fp)          # Guardamos el primer caracter en minuscula
	lw a0, 40($fp)          #Recuperamos el puntero a la palabra
    addu t0, a0, s1         #t0 = palabra + final
	lub a0, 0(t0)	        # Leemos el  caracter palabra[final]
	la t9, my_tolower
	jalr t9              	#Llamamos a tolower() con el caracter
	sw v0, 20($fp)          # Guardamos el segundo caracter en minuscula
	move t0, v0             #t0 = segundo caracter
	lw t1, 16($fp)          #t1 = primer caracter
	bne t0, t1, return_false   #Si son distintos devuelve false

	addiu s0, s0, 1         #Suma uno (un byte) a inicio
	subu s1, s1, 1          #Resta uno (un byte) a final
	blt s0, s1, loop		#Si inicio < final vuelve al loop

return_true:
	addiu v0, zero, 1
	b return

return_false:
	addu v0, zero, zero

return:
	lw ra, 40($fp)
	lw gp, 36($fp)
    lw s1, 28($fp)
    lw s0, 24($fp)
	lw $fp, 32($fp)
	addiu sp, sp, 48
	jr ra

.end es_capicua
.size es_capicua,.-es_capicua 



#___________________________________________________________________________________________


.ent my_tolower

my_tolower:
	.frame $fp, 24, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 24
	sw $fp, 16(sp)
	.cprestore 20
	move $fp, sp

	sw a0, 24($fp)              #Guardamos el primer argumento (caracter) en el stackframe
	
	blt a0, ascii_A, return     # Salta si caracter es menor a A
	bgt a0, ascii_Z, return     # Salta si caracter es mayor a Z
	addiu a0, a0, 32            # 32 es la diferencia entre minusculas y mayusculas en ascii
	
return:
	move a0, v0                 #Pone el resultado en v0
	lw gp, 20($fp)
	lw $fp, 16($fp)
	addiu sp, sp, 24
	jr ra
	
.end my_tolower
.size my_tolower,.-my_tolower 


#___________________________________________________________________________________________



.ent leer_palabra

leer_palabra:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 40
    sw s0, 24(sp)
	sw $fp, 28(sp)
	.cprestore 32
	sw ra, 36(sp)
	move $fp, sp
	
	sw a0, 40($fp)          # Guardamos el primer argumento en el stackframe (puntero al archivo)
	sw a1, 44($fp)          # Guardamos el segundo argumento en el stackframe (puntero a longitud)
    sw a2, 48($fp)          # Guardamos el tercer argumento en el stackframe (puntero a buffer)
	
    la t0, TAM
	lw a0, 0(t0)            			#Carga TAM en a0     
	la t9, my_malloc
	jalr t9             				#Llama a malloc
	beq v0, zero, terminar_con_error	#Si malloc devuelve 0 ocurrio un error

	sw v0, 16($fp)          			#Guardamos el puntero a la palabra en el stackframe
	addu s0, zero, zero     			# Inicializamos la longitud de la palabra en cero


loop:
	lw a0, 40($fp)                      # Recuperamos el puntero al archivo
    lw a1, 48($fp)                      # Recuperamos el puntero al buffer
	la t9, leer_caracter_archivo
	jalr t9                          	#Leemos un caracter, queda en v0
	beq v0, -1, error					#Si devuelve -1 ocurrio un error


	beq v0, ascii_-, es_caracter        # Salta si es -
	beq v0, ascii__, es_caracter        # Salta si es _
	
	sgeu t0, v0, ascii_A                # Mayor que "A"
	sleu t1, v0, ascii_Z                # Menor que "Z"
	beq t0, t1, es_caracter             # Salta si es letra mayuscula

	sgeu t0, v0, ascii_a                # Mayor que "a"
	sleu t1, v0, ascii_z                # Menor que "z"
	beq t0, t1, es_caracter             # Salta si es letra minuscula

	sgeu t0, v0, ascii_0                # Mayor que "0"
	sleu t1, v0, ascii_9                # Menor que "9"
	beq t0, t1, es_caracter             #Salta si es un numero

no_es_caracter:
	lw a0, 16($fp)                      # Recuperamos puntero a palabra
	addu t0, s0, a0                     #t0 = palabra + len
	addiu t1, zero, ascii_newline
	sb t1, 0(t0)                      	#Guardamos el "\n"
	
	lw a1, 44($fp)	                    # Cargamos puntero a len
	sw s0, 0(a1)                        # Guardamos el len
	b terminar                          #Sale del loop

es_caracter:
	lw a0, 16($fp)                      # Recuperamos puntero a palabra
	addu t0, s0, a0                     #t0 = palabra + len
	sb v0, 0(t0)                        #Guardamos el caracter

	addiu s0, s0, 1                     #Incrementamos len

	la t0, TAM
	lw t1, 0(t0)                        #Carga TAM en t1  
	remu t2, s0, t1                     #t2 = len % tam

	bne t2, zero, loop                  #Continua al loop si el modulo no es 0
	
	lw a0, 16($fp)                      # Recuperamos puntero a palabra en a0
	move a1, s0							#a1 = len
	move a2, t1                    		# a2 = TAM

	la t9, my_realloc
	jalr t9                          	#Llama a realloc
	beq v0, zero, error					#Si realloc devuelve 0 ocurrio un error
	sw v0, 16($fp)          			#Guardamos el nuevo puntero en el stackframe

	b loop                              #Vuelve siempre al loop

terminar:
	lw v0, 16($fp)                      #Carga en v0 el puntero a la palabra
return:
    lw s0, 24($fp)
	lw ra, 36($fp)
	lw gp, 32($fp)
	lw $fp, 28($fp)
	addiu sp, sp, 40
	jr ra

error:
	lw a0, 16($fp)                      # Recuperamos puntero a palabra en a0
	la t9, my_free
	jalr t9								#Llama a free con la palabra
terminar_con_error:
	move v0, zero						#Devuelve 0 si ocurrio un error
	b return						
	
.end leer_palabra
.size leer_palabra,.-leer_palabra 


#___________________________________________________________________________________________

.ent crear_buffer

crear_buffer:
	.frame $fp, 32, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 32
	sw $fp, 16(sp)
	.cprestore 20
	sw ra, 24(sp)
	move $fp, sp
	
	sw a0, 32($fp)                      # Guardamos el tamanio del buffer en el stackframe

    la t9, my_malloc                    
    jalr t9                          	#Llama a malloc
    
    bne v0, zero, return         		#Salta si no ocurrio un error
    move v0, zero						#Devuelve 0 si ocurrio un error

return:
    lw ra, 24($fp)
	lw gp, 20($fp)
	lw $fp, 16($fp)
	addiu sp, sp, 32
	jr ra

.end crear_buffer
.size crear_buffer,.-crear_buffer


#___________________________________________________________________________________________


.ent leer_caracter_archivo

leer_caracter_archivo:

	.frame $fp, 32, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 40
	sw s0, 16(sp)
	sw s1, 20(sp)
	sw $fp, 24(sp)
	.cprestore 28
	sw ra, 32(sp)
	move $fp, sp
	
	sw a0, 32($fp)                      # Guardamos el archivo de entrada en el stackframe
	sw a1, 36($fp)                      # Guardamos el puntero al buffer en el stackframe
	
    la t0, pos_buffer_entrada
    lw s0, 0, (t0)                      #s0 = pos actual del buffer
    
    la t0, tam_buffer_entrada
    lw a2, 0, (t0)                      #a2 = tam actual del buffer

    bltu s0, a2, leer_caracter          #Salta si pos actual < tam buffer       

#Si no salta tengo que volver a leer del archivo y llenar el buffer

    li v0, SYS_read
    syscall
    bne a3, zero, error_inesperado		#Salta si hubo un error
    beq v0, zero, leyo_eof				#Si read devuelve 0 leyo EOF
    
    addu s0, zero, zero                 #Pos_actual = 0
    
    la t0, tam_buffer_entrada
    lw a2, 0, (t0)                      #a2 = tam actual del buffer
    blt v0,a2, leer_caracter			#Salta si read no leyo menos bytes de lo indicado
	
#Si leyo menos bytes 
leer_archivo:
	move s1,v0 							#s1 = cantidad bytes leidos
	lw a0, 32($fp)                      # a0 = archivo de entrada
	lw a1, 36($fp)                      
	addu a1, a1, s1						#a1 = puntero a buffer + cant bytes leidos
	la t0, tam_buffer_entrada
    lw a2, 0, (t0)                      
	subu a2, a2, s1						#a2 = tam actual del buffer - cant bytes leidos
	li v0, SYS_read
	syscall
	bne a3, zero, error_inesperado		#Salta si hubo un error
	beq v0, zero, eof_leido				#Si es cero leyo eof
	addu s1, s1, v0						#s1 = cant bytes leidos
	la t0, tam_buffer_entrada
    lw t1, 0, (t0)						#t1 = tam buffer entrada
    blt s1, t1, leer_archivo			#Si cant bytes leidos < tam vuelve a leer
    beq s1, t1, leer_caracter			#Si ya leyo todo salta a leer caracter
	
eof_leido:
	la t0, tam_buffer_entrada			#Si leyo menos bytes pero todavia hay cosas en el buffer
	sw s1, 0(t0)						#Actualizo el tamanio del buffer

leer_caracter:
    
    lw a1, 36($fp)                      #Cargo el puntero al buffer
    addu t2, s0, a1                     #t2 = buffer + pos
    lub v0, 0(t2)                       #v0 = caracter leido
    addiu s0, s0, 1                     #Incremento la posicion actual

    la t0, pos_buffer_entrada
    sw s0, 0, (t0)                      #Guardamos la pos actual del buffer

return:
	lw s0, 16($fp)
	lw s1, 20($fp)
    lw ra, 32($fp)
	lw gp, 28($fp)
	lw $fp, 24($fp)
	addiu sp, sp, 40
	jr ra

leyo_eof:
	la t0, eof_leido
	addiu t1,zero,1
	sw t1, 0(t0)						#Actualizo la variable EOF leido
	addiu v0, zero, zero				#Devuelvo 0
	b return

error_inesperado:
	addiu v0, zero, -1					#Devuelvo -1 
	b return

.end leer_caracter_archivo
.size leer_caracter_archivo,.-leer_caracter_archivo

#___________________________________________________________________________________________


.ent escribir_palabra_archivo

escribir_palabra_archivo:

	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
	sw s0, 16(sp)
	sw s1, 20(sp)
	sw s2, 24(sp)
	sw s3, 28(sp)
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp
	
	sw a0, 40($fp)                      # Guardamos el archivo de salida en el stackframe
	sw a1, 44($fp)                      # Guardamos el puntero a la palabra en el stackframe
    sw a2, 48($fp)                      # Guardamos el buffer en el stackframe

	move s3, zero						#s3 = cant bytes escritos = 0
    la t0, pos_buffer_salida
    lw s0, 0, (t0)                      #s0 = pos actual del buffer

    addu s1, zero, zero                 #Inicializamos el indice de la palabra en s1
    
    la t0, eof_escrito
    lw t1, 0, (t0)                      #t1 = eof debe ser escrito?
    beq t1,zero, loop					#Salta si eof no debe ser escrito
    
    la t0, tam_buffer_salida
    sw s0, 0, (t0)                      #Actualiza el tamanio del buffer a la posicion actual
    b escribir_todo
    

loop:
    lw a1, 44($fp)                      #Cargamos el puntero a la palabra
    addu t3, a1, s1                     #t3 = palabra + indice
    lub s2, 0(t3)                       #s2 = caracter a escribir

    lw a2, 48($fp)                      #Cargamos el puntero al buffer
    addu t5, a2, s0                     #t5 = buffer + pos_actual
    sb s2, 0(t5)                        #Guardamos el caracter

    addiu s0,s0,1                       #Incrementamos pos_actual
    la t0, tam_buffer_salida
    lw t1, 0(t0)                      	#Cargamos el tamanio del buffer
    bne s0, t1, continuar_loop          #Salta si pos_actual != tam_buffer

#Si no salta tengo que volver a escribir el archivo y vaciar el buffer

escribir_todo:
    lw a0, 40($fp)                      # Cargamos el archivo de salida 
    lw a1, 48($fp)                      # Cargamos el buffer 
    addu a1, a1, s3						#a1 = buffer + cant bytes escritos
    la t0, tam_buffer_salida
    lw a2, 0(t0)                        # Cargamos el tamanio total del buffer 
    subu a2, a2, s3						#a2 = tam - cant bytes escritos
    li v0, SYS_write
    syscall
    
    bne a3, zero, error_inesperado		#Salta si ocurrio un error
    addu s3, s3, v0						#s3 = cant bytes escritos
    la t0, tam_buffer_salida
    lw t1, 0(t0)                        # t1 = tamanio total del buffer 
    blt s3, t1, escribir_todo			#Si escribio menos bytes vuelve a escribir
    
    addu s0, zero, zero                 #Pos_actual = 0
    
    la t0, eof_escrito
    lw t1, 0, (t0)                      #t1 = eof_escrito
    bgt t1, zero, terminar				#Termina si EOF fue escrito

continuar_loop:
    addu s1, s1, 1                      #Incrementamos el indice de la palabra
    beq s2, ascii_newline, terminar     #Termina si es \n
    b loop                              #Vuelve al loop

terminar:
	addiu v0, zero, 1					#Devuelve 1 si no ocurrio un error
return:
    la t0, pos_buffer_salida
    sw s0, 0, (t0)                      
    lw s0, 16($fp)
    lw s1, 20($fp)
    lw s2, 24($fp)
    lw s3, 28($fp)
    lw ra, 40($fp)
	lw gp, 36($fp)
	lw $fp, 32($fp)
	addiu sp, sp, 48
	jr ra

error_inesperado:
	move v0, zero						#Devuelve 0 si ocurrio un error
	b return

.end escribir_palabra_archivo
.size escribir_palabra_archivo,.-escribir_palabra_archivo
    
#__________________________________________________

.data

pos_buffer_entrada: .word -1
tam_buffer_entrada: .word 0
pos_buffer_salida: .word 0
tam_buffer_salida: .word 0
eof_leido: .word 0
eof_escrito: .word 0
TAM: .word 10



