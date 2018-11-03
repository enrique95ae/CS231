			.data
str1:			.asciiz	"\n Enter how many intergers are going to be added: "
str2:			.asciiz "\n Enter an interger: "
str3:			.asciiz "\n The total is: "
			.text
main:			
		#PRINTING THE STRING AND STORING THE NUMBER OF INTERGER TO BE ADDED
        		la      $a0, str1			# print the content of $a0 which is string
        		li      $v0, 4					
      		 syscall
        
        		li      $v0, 5 				#read an integer from user into $v0
		syscall
	
	     	  	add     $s2,$0,$v0  			#store THE END OF THE LOOP INTO $S2

 			li	$s1, 0          		#start of the loop  
 			li	$s3, 0				#initializing the total variable
 			       				 	              
loopDecision:		beq 	$s1, $s2, exit
			la	$a0, str2
			li	$v0, 4
		syscall
			li      $v0, 5 				#read an integer from user into $v0
		syscall
			add     $s4,$0,$v0  			#interger to be added
			add 	$s3,$s3,$s4
			add	$s1,$s1,1
			j       loopDecision
			
  exit:		
  			la	$a0, str3
			li	$v0, 4
		syscall
			li	$v0, 1
			move	$a0, $s3
		syscall
  			li	$v0, 10
		syscall	
