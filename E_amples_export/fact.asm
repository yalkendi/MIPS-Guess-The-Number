# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		
main:
	# Initialize param
	li	$a0, 3
	jal	fact

	# Print result 
	move	$s0, $v0	# Return value saved in $v0. 
	li	$v0, 1		# print_int syscall code = 1
	move	$a0, $s0	# Load integer to print in $a0
	syscall

	# Exit
	li	$v0, 10		# exit
	syscall

fact:  
	#stack push
	addi	$sp, $sp, -8
	sw	$ra, 0 ($sp)
	sw	$a0, 4 ($sp)

	slti	$t0, $a0, 1
	beq	$t0, $zero, else
	
	# $a0 < 1 
	lw	$ra, 0 ($sp)
	lw	$a0, 4 ($sp)
	addi	$sp, $sp, 8
	#set return value and return 
	li	$v0, 1
	jr	$ra
	
else:	
	addi	$a0, $a0, -1
	jal	fact
	
	#stack pop
	lw	$ra, 0 ($sp)
	lw	$a0, 4 ($sp)
	addi	$sp, $sp, 8
	mul	$v0, $v0, $a0
	jr	$ra
        
	# data global (and static) data
	.data
