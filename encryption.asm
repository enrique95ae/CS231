	.data
string1:	.byte		10
string2:	.byte		10
buffer:		.space		30
strJump:	.asciiz 	"\n"
inputString: 	.asciiz 	"\n Input a string to encrypt: "
encryptedString:   .asciiz 	"\n The encrypted string is: "
decryptedString:   .asciiz 	"\n The decrypted string is: "

	.text
	
main:	
	jal values

	j askingForString


values:
	li	$a0, 0
	li	$t0, 0
	jr	$ra
	

askingForString:
		la $a0,inputString
      	        li $v0,4
        syscall

        	li $v0,8
     	syscall
     		la $a0, string1
     		li $a1, 30
     	syscall
     		move $t0, $a0
     	
     	
         	la $a0, strJump
     		li $v0, 4
     	syscall
     	
    		la $a0, buffer  
    		move $a0, $t0   
    		li $v0, 4     
   	 syscall
     	
exit:
		li	$v0, 10			#exit
	syscall					#exit

     	