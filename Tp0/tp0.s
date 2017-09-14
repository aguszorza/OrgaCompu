	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	leer_palabra
	.ent	leer_palabra
leer_palabra:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	move	$a0,$zero
	li	$a1,10			# 0xa
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	sw	$zero,28($fp)
$L18:
	lw	$a0,56($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,56($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L21
	lw	$a0,24($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,36($fp)
	b	$L17
$L21:
	lw	$v0,32($fp)
	slt	$v0,$v0,65
	bne	$v0,$zero,$L24
	lw	$v0,32($fp)
	slt	$v0,$v0,91
	bne	$v0,$zero,$L23
$L24:
	lw	$v0,32($fp)
	slt	$v0,$v0,97
	bne	$v0,$zero,$L25
	lw	$v0,32($fp)
	slt	$v0,$v0,123
	bne	$v0,$zero,$L23
$L25:
	lw	$v0,32($fp)
	slt	$v0,$v0,48
	bne	$v0,$zero,$L26
	lw	$v0,32($fp)
	slt	$v0,$v0,58
	bne	$v0,$zero,$L23
$L26:
	lw	$v1,32($fp)
	li	$v0,45			# 0x2d
	beq	$v1,$v0,$L23
	lw	$v1,32($fp)
	li	$v0,95			# 0x5f
	beq	$v1,$v0,$L23
	b	$L22
$L23:
	lw	$v1,24($fp)
	lw	$v0,28($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,32($fp)
	sb	$v0,0($v1)
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	lw	$a0,28($fp)
	li	$v0,1717960704			# 0x66660000
	ori	$v0,$v0,0x6667
	mult	$a0,$v0
	mfhi	$v0
	sra	$v1,$v0,2
	sra	$v0,$a0,31
	subu	$v1,$v1,$v0
	move	$v0,$v1
	sll	$v0,$v0,2
	addu	$v0,$v0,$v1
	sll	$v0,$v0,1
	subu	$v0,$a0,$v0
	bne	$v0,$zero,$L18
	lw	$v0,28($fp)
	addu	$v0,$v0,10
	lw	$a0,24($fp)
	move	$a1,$v0
	la	$t9,realloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	b	$L18
$L22:
	lw	$v1,24($fp)
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$v1,60($fp)
	lw	$v0,28($fp)
	sw	$v0,0($v1)
	lw	$v0,24($fp)
	sw	$v0,36($fp)
$L17:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	leer_palabra
	.size	leer_palabra, .-leer_palabra
	.align	2
	.globl	es_capicua
	.ent	es_capicua
es_capicua:
	.frame	$fp,32,$ra		# vars= 16, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 0
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,32($fp)
	sw	$a1,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L30
	sw	$zero,16($fp)
	b	$L29
$L30:
	sw	$zero,8($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,-1
	sw	$v0,12($fp)
$L31:
	lw	$v0,8($fp)
	lw	$v1,12($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L33
	b	$L32
$L33:
	lw	$v1,32($fp)
	lw	$v0,8($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$a0,$v0,2
	lw	$v1,32($fp)
	lw	$v0,12($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sll	$v1,$v0,1
	lw	$v0,_tolower_tab_
	addu	$v0,$v1,$v0
	addu	$v0,$v0,2
	lh	$v1,0($a0)
	lh	$v0,0($v0)
	beq	$v1,$v0,$L34
	sw	$zero,16($fp)
	b	$L29
$L34:
	lw	$v0,8($fp)
	addu	$v0,$v0,1
	sw	$v0,8($fp)
	lw	$v0,12($fp)
	addu	$v0,$v0,-1
	sw	$v0,12($fp)
	b	$L31
$L32:
	li	$v0,1			# 0x1
	sw	$v0,16($fp)
$L29:
	lw	$v0,16($fp)
	move	$sp,$fp
	lw	$fp,28($sp)
	addu	$sp,$sp,32
	j	$ra
	.end	es_capicua
	.size	es_capicua, .-es_capicua
	.rdata
	.align	2
$LC0:
	.ascii	"-i\000"
	.align	2
$LC1:
	.ascii	"Debe indicar un archivo de entrada luego de -i\n\000"
	.align	2
$LC2:
	.ascii	"-\000"
	.align	2
$LC3:
	.ascii	"r\000"
	.align	2
$LC4:
	.ascii	"El archivo de entrada no pudo abrirse\n\000"
	.align	2
$LC5:
	.ascii	"-o\000"
	.align	2
$LC6:
	.ascii	"Debe indicar un archivo de salida luego de -o\n\000"
	.align	2
$LC7:
	.ascii	"w\000"
	.align	2
$LC8:
	.ascii	"El archivo de salida no pudo abrirse\n\000"
	.align	2
$LC9:
	.ascii	"-V\000"
	.align	2
$LC10:
	.ascii	"TP0 version 1.0002\n\000"
	.align	2
$LC11:
	.ascii	"-h\000"
	.align	2
$LC12:
	.ascii	"Usage:\n\n"
	.ascii	"tp0 -h\n"
	.ascii	"tp0 -V\n"
	.ascii	"tp0 [options]\n\n"
	.ascii	"Options:\n"
	.ascii	"-V, --version  Print version and quit.\n"
	.ascii	"-h, --help   Print this information.\n"
	.ascii	"-i, --input   Location of the input file.\n"
	.ascii	"-o, --output   Location of the output file.\n\n"
	.ascii	"Example:\n"
	.ascii	"tp0 -i ~/input -o ~/output\n\000"
	.align	2
$LC13:
	.ascii	"Ocurrio un error inesperado\n\000"
	.align	2
$LC14:
	.ascii	"%s\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	la	$v0,__sF
	sw	$v0,24($fp)
	la	$v0,__sF+88
	sw	$v0,28($fp)
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
$L36:
	lw	$v0,36($fp)
	lw	$v1,72($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L39
	b	$L37
$L39:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC0
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L40
	lw	$v0,36($fp)
	addu	$v1,$v0,1
	lw	$v0,72($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,$L41
	la	$a0,$LC1
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$v0,2			# 0x2
	sw	$v0,48($fp)
	b	$L35
$L41:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	lw	$v0,0($v0)
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L38
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L38
	la	$a0,$LC4
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$v0,1			# 0x1
	sw	$v0,48($fp)
	b	$L35
$L40:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC5
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L45
	lw	$v0,36($fp)
	addu	$v1,$v0,1
	lw	$v0,72($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,$L46
	la	$a0,$LC6
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$v0,2			# 0x2
	sw	$v0,48($fp)
	b	$L35
$L46:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	lw	$v0,0($v0)
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L38
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC7
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	bne	$v0,$zero,$L38
	la	$a0,$LC8
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$v0,1			# 0x1
	sw	$v0,48($fp)
	b	$L35
$L45:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC9
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L50
	la	$a0,__sF+88
	la	$a1,$LC10
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,48($fp)
	b	$L35
$L50:
	lw	$v0,36($fp)
	sll	$v1,$v0,2
	lw	$v0,76($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	la	$a1,$LC11
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L38
	la	$a0,__sF+88
	la	$a1,$LC12
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,48($fp)
	b	$L35
$L38:
	lw	$v0,36($fp)
	addu	$v0,$v0,2
	sw	$v0,36($fp)
	b	$L36
$L37:
	.set	noreorder
	nop
	.set	reorder
$L53:
	lw	$v0,24($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L55
	b	$L54
$L55:
	addu	$v0,$fp,44
	lw	$a0,24($fp)
	move	$a1,$v0
	la	$t9,leer_palabra
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L56
	la	$a0,$LC13
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$v0,3			# 0x3
	sw	$v0,48($fp)
	b	$L35
$L56:
	lw	$a0,40($fp)
	lw	$a1,44($fp)
	la	$t9,es_capicua
	jal	$ra,$t9
	beq	$v0,$zero,$L57
	lw	$a0,28($fp)
	la	$a1,$LC14
	lw	$a2,40($fp)
	la	$t9,fprintf
	jal	$ra,$t9
$L57:
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
	b	$L53
$L54:
	lw	$a0,24($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,28($fp)
	la	$t9,fclose
	jal	$ra,$t9
	sw	$zero,48($fp)
$L35:
	lw	$v0,48($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
