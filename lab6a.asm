	.data

strJump:	.asciiz 	"\n"
firstNumber: 	.asciiz 	"\n Input a number in decimal form: "
lineDivision:	.asciiz 	"===================================================\n"
result:   	.asciiz 	"\n The number in binary is: \n "

	.text
	
main:	
		la 	$a0, firstNumber	#Asking and entering the number to convert
		li	$v0, 4			#Asking and entering the number to convert
	syscall					#Asking and entering the number to convert
		li	$v0, 5			#Asking and entering the number to convert
	syscall					#Asking and entering the number to convert
		add	$a0, $v0, $0		#Storing the number to convert in a0
		
		jal	values
		
		j	exit
values:	
		li	$t4, 0			#counter for poping and printing
		li	$s1, 2			#Storing two in s1
		la	$s0, ($a0)
		
changeBase:	
		#add	$s0, $a0, $0
						#Converting base function
		beq	$s0, $0, print		#Stop the converting loop when t1(remainder register) is zero
		div	$s0, $s1		#Dividing the number by two (s1)
		mfhi	$t1			#Storing the result in t0
		mflo	$s0			#Storing the remainder in t1
		addi	$sp, $sp, -4		#Stack pointer -4
		sw	$t1, 0($sp)		#Sending the remainder to the bottom of the stack
		addi	$t4, $t4, 1
		j	changeBase		#jumping back to the begining of the loop
		
print:		
		la 	$a0, lineDivision	#printing the line
		li	$v0, 4			#printing the line
	syscall					#printing the line
		la 	$a0, result		#printing the string
		li	$v0, 4			#printing the string
	syscall					#printing the string
	
zeros:
		li	$t5, 32			#loading 32 into t5
		sub	$t5, $t5, $t4		#t5 - counter (how many times zeros are gonna be printed)
printZeros:
		beq	$t5, $0, pop		#go to pop as soon as all the zeros are printed
		la	$a0, ($0)		#load a zero	
		li	$v0, 1			#print it
	syscall
		addi	$t5, $t5, -1		#decreasing the counter by one
		j	printZeros

pop:		
		li	$s5, 0			#loading a 0 into s5
		beq 	$t4, $0, endFunc	#as soon as all the numbers (counter) have been returned from the stack and printed exit.
		lw	$t2, 0($sp)		#storing from the stack into the register t2
		addi	$sp, $sp, 4		#increasing the pointer of the stack
		add	$s5, $t2, $0		#storing the returned value into s5
		la	$a0, ($s5)		#loading s5
		li	$v0, 1			#printing the value
	syscall
		addi	$t4, $t4, -1		#decreasing the counter by 1
		j	pop		

endFunc:
		jr	$ra

exit:
		li	$v0, 10			#exit
	syscall					#exit
