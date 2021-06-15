# .data assembler directive
.data
	ask: .asciiz "Input a number: "

	newline: .asciiz "\n"
	
	bigger: .asciiz " is bigger than the number.\n"
	smaller: .asciiz " is smaller than the number.\n"
	won: .asciiz "You found the number! Play again? (Y/N)"
	
	note: .asciiz " is the generated random number (for grading)\n"

	
# Declare main sciiz as a global function
.globl main 

# All program code is placed after the
# .text assembler directive
.text 
# The label 'main' represents the starting point
main:
	#----------------------- Write your code here
	
	addi $t0, $zero, 'Y'		#assign $t0 to 'Y'  "char run = 'Y';"
	while:
		beq   $t0, 'N', exit	# same as while (run == 'Y')
		
		# "int random = generate_random(10);" 
		addi $a1, $zero, 100 	#Argumant for generate_random
		jal generate_random	# the returned random int is in $s0
		move $s0, $v0
		
		#print the note for grading 
		# the number is already in $a0
		la    $a0,($s0)        # the number
		addi $v0, $zero, 1             
	        syscall 
        	
		la    $a0,note        # the note
		li    $v0,4             
        	syscall   
		
		# Branch to "while (1)"
		b while2
		while2:
			#print "Input a number: " ask 
			la    $a0,ask        # print string "starting seed generator:"
			li    $v0,4             # service 4
        		syscall
        		
        		# read the input 
        		 li    $v0,5    	#read int into $v0
		         syscall		# service 5
		         move $a0,$v0		# the guessed number is saved into $a0
		        
		        move $t1,$v0	# move the guessed numb to $t1 for printing 
		        
		        # $a0 and $a1 are the argumants for "compare(n,random)"
		         move $a1, $s0
		         
		         jal compare
		         move $s1, $v0
		         #The retuned value is stored in $s1

			beq $s1, 1, if
			beq $s1, -1, elseIf
			beq $s1, 0, else
			
			if:
				#print the guessed number 
			        move $a0, $t1
				addi $v0, $zero, 1
				syscall
				
				#print bigger 
				la    $a0,bigger        
				li    $v0,4             # service 4
        			syscall
				
				j endIf
			
			elseIf:
				#print the guessed number 
			        move $a0, $t1
				addi $v0, $zero, 1
				syscall
				
				#print smaller 
				la    $a0,smaller        
				li    $v0,4             # service 4
        			syscall
				
				j endIf
			
			else:
				#print won 
				la    $a0,won        
				li    $v0,4           
        			syscall	
        			
        			#scan for "Play again? (Y/N)"
        			li    $v0,12    		#read int into $v0
				syscall			
		         	move $t0,$v0		# the char is saved into $t0 for the first while loop   			
        			
        			j exit2	         	
			endIf:
		
			j while2
		exit2:
		
			#print newline 
			la    $a0,newline        
			li    $v0,4           
        		syscall	
		
		j while
	exit:
	

	
	#You must print (show) the number generated after the function call. 
	#You must use a JAL and JR as a pair, stack (if needed), and correct registers for each function call.
	#----------------------- Write your code here
	
	# Syscall to end the program
	li $v0, 10
	syscall
	
#generate_random function starts here.	
generate_random:
	#----------------------- Write your code here
	
	# Stack pointer allocation 
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)
	
	
	move $t0, $a0	#store the max value (argument) in $t0. 
	
	        #set seed to the time
        li	$v0, 30		# get time 
        syscall
	move	$t1, $a0	# save time to $t1 
         
        li	$a0, 1		# For the random number generator "$a0 = i.d. of pseudorandom number generator (any int)."
        move 	$a1, $t1	# seed value (time)
        li	$v0, 40		# seed random number syscall code
        syscall
        
        
        li	$a0, 1		# random generator id (from the seeding step)
	li	$a1, 100	# upper bound of the range
	li	$v0, 42		# random int range
	syscall
        
        move 	$v0, $a0		# save the random int in $s0     
        
        
	# restore the stack pointer 
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
#compare function starts here.
compare:
 #----------------------- Write your code here

 	blt $a0, $a1, cif 	
	beq $a0, $a1, cifElse
	bgt $a0, $a1, celse
 	cif:
 		addi $v0, $zero, -1
 		j cend
	cifElse:
 		addi $v0, $zero, 0
 		j cend
 	celse:
 		addi $v0, $zero, 1 	
 	cend:

 	
 	jr $ra