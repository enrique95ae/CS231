	.data
	
arr1:	.word 		0,0,0,0,0,0,0,0,0,0
str:	.asciiz 	"\n"
str1: 	.asciiz 	"\n How many elements does the array have? "
str2:   .asciiz 	"\n ERROR: Enter a number between 1 and 10: "
str3:	.asciiz 	"\n The median is: "
str4:	.asciiz 	"\n===================================================\n"
str5:   .asciiz 	"\n Enter a number: "

	.text
	
main:	
		la 	$a0, str1 
		li	$v0, 4
	syscall
		li	$v0, 5
	syscall
		add	$s3, $v0, $0
		blt	$s3, 1, error
		bgt	$s3, 10, error

		li	$s0, 0
		la	$s2, arr1
		
		li	$t5, 4
	
loop:
		beq 	$s0,$s3, oddOrEven
		
		la	$a0, str5
		li	$v0, 4
	syscall
		li 	$v0, 5
	syscall
	
		add 	$t0, $v0, $0
		
		sw	$t0, 0($s2)
		
		add	$s0, $s0, 1
		add	$s2, $s2, 4
			
		j	loop

oddOrEven:
		li 	$s4, 2
		div	$s3, $s4
		mfhi	$t1
		mflo	$t8
		
		beq	$t1, 0, isEven
		beq	$t1, 1, isOdd	
		
		j	error
		
isEven:		
		la	$s2, arr1
		
		mult 	$t8, $t5
		mflo	$s6
		
		add	$s2, $s6, $s2
		
		lw	$s7, 0($s2)
		
		addi	$s2, $s2, -4
		
		lw	$s6, 0($s2)
		
		add	$s6, $s6, $s7
		
		div	$s6, $s4
		mflo	$s6
		
		la	$a0, ($s6)
		li	$v0, 1
	syscall
		
		
		
		

	
		j 	exit
isOdd:	
		la	$s2, arr1

		div 	$s3, $s4
		mflo	$t3
		
		mult	$t3, $t5
		mflo	$t6
		
		add 	$s2, $s2, $t6
		
		lw	$t7, 0($s2)
		la	$a0, ($t7)
		li	$v0, 1
	syscall
	
		j 	exit				
error:
		li	$v0, 4
		la	$a0, str2

	syscall
		j 	main
	
exit:
		
		li	$v0, 10
	syscall
