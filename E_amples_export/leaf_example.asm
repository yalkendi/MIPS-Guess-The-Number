# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		
main:
	# Initialize param
	lw	$a0, g		# Reg $a0 = g
	lw	$a1, h		# Reg $a1 = h
	lw	$a2, i		# Reg $a2 = i
	lw	$a3, j		# Reg $a3 = j

	jal	leaf_example

	move	$s0, $v0		# Return value saved in $v0. 

	# Print result 
	li	$v0, 1		# print_int syscall code = 1
	move	$a0, $s0	# Load integer to print in $a0
	syscall

	# Exit
	li	$v0, 10		# exit
	syscall

leaf_example:  
	addi 	$sp, $sp, -12
	sw	$t1, 8($sp) 
	sw	$t0, 4($sp) 
	sw 	$s0, 0($sp)
	add 	$t0,$a0,$a1
	add 	$t1,$a2,$a3
	sub 	$s0,$t0,$t1
	add	$v0,$s0,$zero
	lw 	$s0, 0($sp)
	lw 	$t0, 4($sp)
	lw 	$t1, 8($sp)
	addi 	$sp,$sp, 12
	jr 	$ra
	
	# data global (and static) data
	.data
g:	.word 4
h:	.word 3
i:	.word 2
j:	.word 1
