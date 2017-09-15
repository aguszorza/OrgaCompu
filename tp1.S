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

.text
.abicalls
.align2

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
    addu t0, a0, s0         #t0 = palabra + inicio
	lub a0, 0(t0)           # Leemos el  caracter palabra[inicio]
	la t9, my_tolower       
	jal ra, t9              #Llamamos a tolower() con el caracter
	sw v0, 16($fp)          # Guardamos el primer caracter en minuscula
	lw a0, 40(sp)           #Recuperamos el puntero a la palabra
    addu t0, a0, s1         #t0 = palabra + final
	lub a0, 0(t0)	        # Leemos el  caracter palabra[final]
	la t9, my_tolower
	jal ra, t9              #Llamamos a tolower() con el caracter
	sw v0, 20($fp)          # Guardamos el segundo caracter en minuscula
	move t0, v0             #t0 = segundo caracter
	lw t1, 16($fp)          #t1 = primer caracter
	bne t0, t1, return_false   #Si son distintos devuelve false

	addiu s0, s0, 1         #Suma uno (un byte) a inicio
	subu s1, s1, 1          #Resta uno (un byte) a final
	bge s0, s1, return_true #Si inicio > final devuelve true
	j loop                  #Vuelve al loop

return_true:
	addiu v0, zero, 1
	j return

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
	bgt a0, ascii_z, return     # Salta si caracter es mayor a Z
	addiu a0, a0, 32            # 32 es la diferencia entre minusculas y mayusculas
	
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
    sw a3, 52($fp)          # Guardamos el cuarto argumento en el stackframe (tamanio del buffer)
	
    la t0, TAM
	lw a0, 0(t0)            #Carga TAM en a0     
	la t9, my_malloc
	jal ra, t9              #Llama a malloc

	sw v0, 16($fp)          #Guardamos el puntero a la palabra en el stackframe
	addu s0, zero, zero     # Inicializamos la longitud de la palabra en cero


loop:
	lw a0, 40($fp)                      # Recuperamos el puntero al archivo
    lw a1, 48($fp)                      # Recuperamos el puntero al buffer
    lw a2, 52($fp)                      # Recuperamos el tamanio del buffer
	la t9, leer_caracter_archivo
	jal ra, t9                          #Leemos un caracter, queda en v0


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
	sb zero, 0(t0)                      #Guardamos el "\0"
	
	lw a1, 44($fp)	                    # Cargamos puntero a len
	sw s0, 0(a1)                        # Guardamos el len
	j return                            #Sale del loop

es_caracter:
	lw a0, 16($fp)                      # Recuperamos puntero a palabra
	addu t0, s0, a0                     #t0 = palabra + len
	sb v0, 0(t0)                        #Guardamos el caracter

	addiu s0, s0, 1                     #Incrementamos len

	la t0, TAM
	lw t1, 0(t0)                        #Carga TAM en t1  
	remu t2, s0, t1                     #t2 = len % tam

	bne t2, zero, loop                  #Continua al loon si el modulo no es 0
	
	lw a0, 16($fp)                      # Recuperamos puntero a palabra en a0
	addu a1, s0, t1                     # a1 = len + TAM

	la t9, my_realloc
	jal ra,t9                           #Llama a realloc

	j loop                              #Vuelve siempre al loop

return:
	lw v0, 16($fp)                      #Carga en v0 el puntero a la palabra
	
    lw s0, 24($fp)
	lw ra, 36($fp)
	lw gp, 32($fp)
	lw $fp, 28($fp)
	addiu sp, sp, 40
	jr ra

.end leer_palabra
.size leer_palabra,.-leer_palabra 


#___________________________________________________________________________________________


.ent leer_archivo

leer_archivo:
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
	sw a1, 52($fp)                      # guardamos el archivo de salida en el stackframe
    sw a2, 56($fp)                      # guardamos el tamanio del buffer en el stackframe

    move a0, a2                         #a0 = tamanio del buffer

    la t9, crear_buffer
    jal ra,t9                           #Crea el buffer de entrada
    sw v0, 24($fp)                      #Guardamos el buffer de entrada en el stackframe

    lw a0, 56($fp)                      #a0 = tamanio del buffer
    la t9, crear_buffer
    jal ra,t9                           #Crea el buffer de salida
    sw v0, 28($fp)                      #Guardamos el buffer de salida en el stackframe
	
loop:
    lw a0, 48($fp)                      #Recuperamos el archivo de entrada
	#Verificar  eof del archivo
	beq v0, zero, return                # Termina si se acaba el archivo
	
    lw a0, 48($fp)                      #Guardamos en a0 el archivo de entrada
	addu a1, $fp, 16                    #Guardamos en a1 el puntero a len
    lw a2, 28($fp)                      #Guardamos en a2 el buffer de entrada
    lw a3, 56($fp)                      #Guardamos en a3 el tamanio del buffer de entrada
	
	la t9, leer_palabra
	jal ra, t9                          #Lee la proxima palabra

	sw v0, 20($fp)                      # Guardamos el puntero a la palabra
	beq v0, zero, error_inesperado      # No se pudo leer la palabra

	move a0, v0                         #a0 = puntero a palabra
    lw a1, 16 ($fp)                     #a1 = len(palabra)
	la t9, es_capicua
	jal ra, t9                          #Llama a es_capicua      

	beq v0, zero, continuar_loop        #Si no es capicua continua el loop         
	
	lw a0, 44($fp)                      #a0 = archivo de salida
	lw a1, 20($fp)                      #a1 = puntero a la palabra
    lw a2, 28($fp)                      #a2 = buffer de salida
    lw a3, 56($fp)                      #a3 = tamanio del buffer de salida
    la t9, escribir_palabra_archivo
    jal ra, t9                          #Escribe la palabra en el archivo

continuar_loop:
    
    lw a0, 20($fp)                      #a0 = puntero a palabra
    la t9, my_free
    jal ra,t9                           #Llama a free(palabra)
    j loop

return:
	#CERRAR ARCHIVOS
	
	lw ra, 40($fp)
	lw gp, 36($fp)
	lw $fp, 32($fp)
	addiu sp, sp, 48
	jr ra

error_inesperado:
###############################

.end leer_archivo
.size leer_archivo,.-leer_archivo


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
    jal ra, t9                          #Llama a malloc
    
    beq v0, zero, error_malloc          #Salta si ocurrio un error

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

	subu sp, sp, 32
	sw $fp, 16(sp)
	.cprestore 20
	sw ra, 24(sp)
	move $fp, sp
	
	sw a0, 32($fp)                      # Guardamos el archivo de entrada en el stackframe
	sw a1, 36($fp)                      # Guardamos el puntero al buffer en el stackframe
    sw a2, 40($fp)                      # Guardamos el tamanio total del buffer en el stackframe

    la t0, pos_buffer_entrada
    lw t1, 0, (t0)                      #t1 = pos actual del buffer

    bltu t1, a2, leer_caracter          #Salta si pos actual < tam buffer       

#Si no salta tengo que volver a leer del archivo y llenar el buffer

    li v0, SYS_read
    syscall
    ##VER ERRORES
    
    addu t1, zero, zero                 #Pos_actual = 0

leer_caracter:
    
    lw a1, 36($fp)                      #Cargo el puntero al buffer
    addu t2, t1, a1                     #t2 = buffer + pos
    lub v0, 0(t2)                       #v0 = caracter leido
    addiu t1, t1, 1                     #Incremento la posicion actual

    la t0, pos_buffer_entrada
    sw t1, 0, (t0)                      #Guardamos la pos actual del buffer

return:
    lw ra, 24($fp)
	lw gp, 20($fp)
	lw $fp, 16($fp)
	addiu sp, sp, 32
	jr ra


.end leer_caracter_archivo
.size leer_caracter_archivo,.-leer_caracter_archivo

#___________________________________________________________________________________________


.ent escribir_palabra_archivo

escribir_palabra_archivo:

	.frame $fp, 32, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 32
	sw $fp, 16(sp)
	.cprestore 20
	sw ra, 24(sp)
	move $fp, sp
	
	sw a0, 32($fp)                      # Guardamos el archivo de salida en el stackframe
	sw a1, 36($fp)                      # Guardamos el puntero a la palabra en el stackframe
    sw a2, 40($fp)                      # Guardamos el buffer en el stackframe
    sw a3, 44($fp)                      # Guardamos el tamanio total del buffer en el stackframe

    la t0, pos_buffer_salida
    lw t1, 0, (t0)                      #t1 = pos actual del buffer

    addu t2, zero, zero                 #Inicializamos el indice de la palabra

loop:
    lw a1, 36($fp)                      #Cargamos el puntero a la palabra
    addu t3, a1, t2                     #t3 = palabra + indice
    lub t4, 0(t3)                       #t4 = caracter a escribir
    beq t4, zero, return                #Salta si es \0

    lw a2, 40($fp)                      #Cargamos el puntero al buffer
    addu t5, a2, t1                     #t5 = buffer + pos_actual
    sb t4, 0(t5)                        #Guardamos el caracter

    addiu t1,t1,1                       #Incrementamos pos_actual
    lw a3, 44($fp)                      #Cargamos el tamanio del buffer
    bne t1, a3, continuar_loop          #Salta si pos_actual != tam_buffer

#Si no salta tengo que volver a escribir el archivo y vaciar el buffer

    lw a0, 32($fp)                      # Cargamos el archivo de salida en el stackframe
    lw a1, 40($fp)                      # Cargamos el buffer en el stackframe
    lw a2, 44($fp)                      # Cargamos el tamanio total del buffer en el stackframe
    li v0, SYS_write
    syscall
    ##VER ERRORES
    
    addu t1, zero, zero                 #Pos_actual = 0

continuar_loop:
    addu t2, t2, 1                      #Incrementamos el indice de la palabra
    j loop                              #Vuelve al loop


return:
    la t0, pos_buffer_salida
    sw t1, 0, (t0)                      #Guardamos la pos actual del buffer
    lw ra, 24($fp)
	lw gp, 20($fp)
	lw $fp, 16($fp)
	addiu sp, sp, 32
	jr ra


.end escribir_palabra_archivo
.size escribir_palabra_archivo,.-escribir_palabra_archivo
    
#__________________________________________________

.data

pos_buffer_entrada: .word -1
pos_buffer_salida: .word 0
TAM: .word 10



###Ver que hacer con los buffers cuando se lee el EOF (El buffer de entrada queda incompleto)
#o cuando se escribe el EOF(El buffer de salida queda incompleto)

#Ver tambien que estamos haciendo lb y sb sin tener en cuenta que EOF es int

