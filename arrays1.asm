	.data
	
arr1:	.word 		0,0,0,0,0,0,0,0,0,0
str:	.asciiz 	"\n"
str1: 	.asciiz 	"\n How many elements does the array have? "
str2:   .asciiz 	"\n ERROR: Enter a number between 1 and 10: "
str3:	.asciiz 	"\n The content of the array in reversed order is: "
str4:	.asciiz 	"\n===================================================\n"
str5:    .asciiz 	"\n Enter a number: "

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
	

loop:
		beq 	$s0,$s3, printing
		
		la	$a0, str5
		li	$v0, 4
	syscall
		li 	$v0, 5
	syscall
	
		add 	$t0, $v0, $0
		
		sw	$t0, 0($s2)
		
		add	$s0, $s0, 1
		add	$s2, $s2, 4
		
		li	$s4, 0
		li	$s5, 0
		
		j	loop
		
printing:
		beq 	$s5, $0, lastStr
	
		beq	$s4, $s3, exit
		
		addi 	$s2, $s2, -4
		
		lw	$t0, 0($s2)
		
		li	$v0, 1
		add	$a0, $0, $t0
	syscall
	
		li 	$v0, 4
		la	$a0, str
	syscall
		
		add	$s4, $s4, 1
		
		j	printing

lastStr:

		la	$a0, str3
		li	$v0, 4
	syscall

		la	$a0, str4
		li 	$v0, 4
	syscall
	
		add	$s5, $s5, 1
		
		j	printing	
								
error:
		li	$v0, 4
		la	$a0, str2

	syscall
		j 	main
	
exit:

	
		li	$v0, 10
	syscall
