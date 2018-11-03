#AUTHOR: Enrique Alonso Esposito
#DATE: Feb 28th
#DESCRIPTION: MIPS assignment 01
#========================================================================================================================
#REGISTER USED:
# S registers:
#	-s0 : array pointer number 1 (starts at bottom)
#	-s1 : array pointer number 2 (starts at top)
#	-s2 : counter (for filling the array)
#	-s3 : temp variable 1 to store values while reversing the array
#
# T registers:
#	-t0 : size of the array and boundaries for loops 
#
#
#
#



	.data

array:			.space 		80	#reserving space of 80 bytes

#STRINGS:
StringSizeArray: 	.asciiz 	"\n Enter a size for the array (0-20): "
StringEnterAnInt:	.asciiz 	"\n Enter an interger: "
StringOriginalArray:	.asciiz		"\n The original array was: \n "
StringReversedArray:	.asciiz		"\n The reversed array is: "

#ERROR STRINGS:
ERRORinvalidSize:	.asciiz 	"\n ERROR: the size must be between 0 and 20. \n Enter a new size: "
ERRORinvalidInterger:	.asciiz 	"\n ERROR: intergers must be positive and divisible by 3 \n Enter a new interger: "

	.text
	
main:
		jal	values			#Jumping to values for initializing the pointers and conters (and any other needed register)
		
		j	AskingSize		#Jumping to function for asking for a size

						#Loading values
values:
		li	$s0, 0
		li	$s1, 0
		li	$s7, 0
		li	$t0, 0
		jr	$ra			#Returning to main
		
AskingSize:
		la 	$a0, StringSizeArray	#Loading the string into a0
		li	$v0, 4			#Calling printting string function
	syscall					
		li	$v0, 5			#Calling reading from user function
	syscall					
		add	$t0, $v0, $0		#Storing the size of the array into t0
		
		blt	$t0, $0, ERRORinvalidSizeSub  #If size is wrong go to LABEL
		bgt	$t0, 20, ERRORinvalidSizeSub
		j	exit
	
	
ERRORinvalidSizeSub:
		la 	$a0, ERRORinvalidSize	#Loading the string into a0
		li	$v0, 4			#Calling printting string function
	syscall					
		li	$v0, 5			#Calling reading from user function
	syscall			
		li	$t0, 0
		add	$t0, $v0, $0		#Storing the size of the array into t0	

		blt	$t0, $0, ERRORinvalidSizeSub	#If size is wrong go to LABEL
		bgt	$t0, 20, ERRORinvalidSizeSub	#if size is wrong go to LABEL
		
AskingForNum:
		j 	exit
	
exit:
		li	$v0, 10			#exit
	syscall	
	
	
