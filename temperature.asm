	.data
num1:		.float 1.8
num2:		.float 32.0

strJump:	.asciiz 	"\n"
tempCelcius: 	.asciiz 	"\n Input a temperature in Celcius: "
lineDivision:	.asciiz 	"===================================================\n"
result:   	.asciiz 	"\n The temperature in Fahrenheit: \n "

	.text
	
main:	
		la 	$a0, tempCelcius	#Asking and entering the number to convert
		li	$v0, 4			#Asking and entering the number to convert
	syscall					#Asking and entering the number to convert
		li	$v0, 5			#Asking and entering the number to convert
	syscall					#Asking and entering the number to convert
		add	$a0, $v0, $0		#Storing the number to convert in a0
		
		jal	values
		
		j	exit
values:	
		li	$v0, 2			#storing 1.8 into f0
		l.s	$f0, num1
	
		li	$v0, 2
		l.s	$f3, num2
	
		li	$t0, 32

convertingAndSendingToProcessor:

		mtc1 	$a0, $f1
		cvt.s.w	$f1, $f1
		mul.s	$f2, $f0, $f1

		add.s	$f4, $f2, $f3

		la 	$a0, result		#printing the line
		li	$v0, 4			#printing the line
	syscall	
	
		li	$v0, 2
		mov.s   $f12, $f4
	syscall

		jr	$ra

exit:

		li	$v0, 10			#exit
	syscall					#exit
