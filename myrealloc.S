#include <mips/regdef.h>
#include <sys/syscall.h>

.text
.abicalls
.align 2

.globl myrealloc
.ent myrealloc

myrealloc:							
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
	
	sw a0, 40($fp)                      # guardamos el puntero
	sw a1, 44($fp)                      # guardamos el tamanio del bloque
    sw a2, 48($fp)                      # guardamos el tamanio a agregar

	addu a0, a1, a2						#a0 = nuevo tamanio bloque
	la t9, mymalloc
	jalr t9								#Llama a malloc
	beq v0, zero, return				#Si devuelve cero ocurrio un error y devuelve cero
	
	sw v0, 16($fp)						#Guardamos el puntero nuevo
	addu s0, zero, zero					#s0 = indice actual
	
loop:
	lw t0, 44($fp)						#t0 = tamanio original
	bgeu s0, t0, terminar				#salta si ya copio todo
	
	lw t0, 40 ($fp)						#t0 = puntero viejo
	addu t0, t0, s0						#t0 = puntero viejo + indice
	
	lw t1, 16($fp)						#t1 = puntero nuevo
	addu t1, t1, s0						#t1 = puntero nuevo + indice
	
	lbu t2, 0(t0)						#Cargo el byte a copiar en t2
	sb t2, 0(t1)						#Guardo el byte
	
	addiu s0, s0, 1						#incremento el indice
	b loop								#Vuelve al loop
	
terminar:
	lw a0, 40($fp)						#a0 = puntero viejo
	la t9, myfree
	jalr t9								#Libera el puntero viejo
	lw v0, 16($fp)						#v0 = puntero nuevo
	
return:
	lw s0, 24($fp)
	lw ra, 36($fp)
	lw gp, 32($fp)
	lw $fp, 28($fp)
	addiu sp, sp, 40
	jr ra
	
.end myrealloc
.size myrealloc,.-myrealloc 
	
	
	
								
