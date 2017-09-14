#include <mips/regdef.h>
#include <sys/syscall.h>

.text
.abicalls
.align2
#.globl
.ent es_capicua
es_capicua:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder
	subu sp, sp, 40
	sw $fp, 24(sp)
	.cprestore 28
	sw ra, 32(sp)
	move $fp, sp
	
	sw a0, 40($fp) # guardamos el primer argumento en el stackframe
	sw a1, 44($fp) # guardamos el segundo argumento en el stackframe
	beq a1, zero, return_false
	
	addu s0, zero, zero #Inicializamos la variable inicio
	subu s1, a1, 1 #Inicializamos la variable final

loop:
	lb a0, s0(a0) # Leemos un caracter
	la t9, my_tolower
	jal t9
	sw v0, 16($fp) # Guardamos el primer caracter
	lw a0, 40(sp)
	lb a0, s1(a0)	# Leemos un caracter del final
	la t9, my_tolower
	jal t9
	sw v0, 20($fp)
	move t0, v0
	lw t1, 16($fp)
	bne t0, t1, return_false
	addiu s0, s0, 1
	subu s1, s1, 1
	bge s0, s1, return_true
	j loop

return_true:
	addiu v0, zero, 1
	j return

return_false:
	addu v0, zero, zero

return:
	lw ra, 32($fp)
	lw gp, 28($fp)
	lw $fp, 24($fp)
	addiu sp, sp, 40
	jr ra
.end es_capicua
.size es_capicua,.-es_capicua 






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

	sw a0, 24($fp)
	
	blt a0, 65, return # ascii del A
	bgt a0, 90, return # ascii del Z
	addiu a0, a0, 32 # ascii a - A
	
return:
	move a0, v0
	lw gp, 20($fp)
	lw $fp, 16($fp)
	addiu sp, sp, 24
	jr ra
.end my_tolower
.size my_tolower,.-my_tolower 






.ent leer_palabra

leer_palabra:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder
	subu sp, sp, 40
	sw $fp, 24(sp)
	.cprestore 28
	sw ra, 32(sp)
	move $fp, sp
	
	sw a0, 40($fp) # guardamos el primer argumento en el stackframe
	sw a1, 44($fp) # guardamos el segundo argumento en el stackframe
	

	lw a0, TAM
	la t9, my_malloc
	jal t9 

	sw v0, 16($fp) #Guardamos el puntero a la palabra
	addu s0, zero, zero # Inicializamos la longitud de la palabra

loop:
	lw a0, 40($fp) # Puntero al archivo
	la t9, leer_caracter_archivo
	jal t9


	beq v0, 45, es_caracter # ascii del '-'
	beq v0, 95, es_caracter # ascii del '_'
	
	sgeu t0, v0, 65 # Mayor que "A"
	sleu t1, v0, 90 # Menor que "Z"
	beq t0, t1, es_caracter

	sgeu t0, v0, 97 # Mayor que "a"
	sleu t1, v0, 122 # Menor que "z"
	beq t0, t1, es_caracter

	sgeu t0, v0, 48 # Mayor que "0"
	sleu t1, v0, 57 # Menor que "9"
	beq t0, t1, es_caracter

no_es_caracter:
	lw a0, 16($fp)
	addu t0, s0, a0
	sw zero, 0(t0) #Guardamos el "\0"
	
	lw a1, 44($fp)	# Cargamos puntero a len
	sw s0, 0(a1) # Guardamos el len
	j return

es_caracter:
	lw a0, 16($fp)
	addu t0, s0, a0
	sw v0, 0(t0) #Guardamos el caracter

	addiu s0, s0, 1

	lw t1, TAM
	remu t2, s0, t1

	bne t2, zero, loop
	
	lw a0, 16($fp)
	addu a1, s0, t1

	la t9, my_realloc
	jal t9

	j loop

return:
	lw v0, 16($fp)
	
	lw ra, 32($fp)
	lw gp, 28($fp)
	lw $fp, 24($fp)
	addiu sp, sp, 40
	jr ra
.end leer_palabra
.size leer_palabra,.-leer_palabra 





.ent main_2

main_2:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder
	subu sp, sp, 40
	sw $fp, 24(sp)
	.cprestore 28
	sw ra, 32(sp)
	move $fp, sp
	
	sw a0, 40($fp) # guardamos el primer argumento en el stackframe
	sw a1, 44($fp) # guardamos el segundo argumento en el stackframe

	sw zero, 16($fp)
	
loop:
	#Verificar  eof del archivo
	beq v0, zero, return
	
	addu a1, $fp, 16
	
	la t9, leer_palabra
	jal t9

	sw v0, 20($fp) # Guardamos el puntero a la palabra
	beq v0, zero, error_inesperado

	move a0, v0
	la t9, es_capicua
	jal t9

	beq v0, zero, fin_loop 
	
	lw a0, 44($fp)
	lw a1, 20($fp)

	#SYS CALL


char* palabra;
	int len;
	while(!feof(entrada)){
		palabra = leer_palabra(entrada, &len);
		if (!palabra){
			fputs("Ocurrio un error inesperado\n", stderr);
			return 3;
		}
		if (es_capicua(palabra, len)){
			fprintf(salida, "%s\n", palabra);
		}
		free (palabra);
	}





