	.data

arr1:	.word 		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
arr2:	.word		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

strJump:	.asciiz 	"\n"
numItems: 	.asciiz 	"\n Enter the number of items you are purchasing: "
lineDivision:	.asciiz 	"===================================================\n"
result:   	.asciiz 	"\n The total is: \n "
errorTooMany:	.asciiz 	"\n Sorry too many items, enter a new amount: "
enterPrice:	.asciiz		"\n Enter the price of the item: "
enterCoupons:	.asciiz 	"\n Enter the number of coupons: "
errorTooManyCoupons:	.asciiz "\n Sorry too many coupons, enter a new amount: "
notAcceptable:	.asciiz 	"\n Coupon not acceptable: "
enterAmountCoupon:	.asciiz "\n Enter the amount of the coupon: "

	.text
	
main:	
		la 	$a0, numItems		#Asking for the number of items buying
		li	$v0, 4			
	syscall					
		li	$v0, 5			
	syscall					
		add	$a0, $v0, $0		#Storing the number in a0
		
		jal	values
		
		j	validationNumItems
		
		j	exit	
		
values:	
		la	$s3, arr1
		la	$s4, arr2
		li	$s7, 0
		li	$t8, 0
		li	$s5, 0
		li	$s0, 0 			#pointer
		li	$t0, 0			#counter for printing after strings (item X)
		li	$s6, 0
		li	$t2, 0
		add	$s1, $a0, $0
		jr	$ra
		
validationNumItems:
		blt	$s1, 21, gettingItems	#if less than 20, start asking the prices
		la 	$a0, errorTooMany	#ERROR too many items
		li	$v0, 4			
	syscall
		li	$v0, 5			
	syscall
		add	$s1, $v0, $0		#Storing the number in a0	
		j	validationNumItems
		
gettingItems:	
		beq	$t0, $s1, numOfCoupons
		la 	$a0, enterPrice		#Asking for the number of items buying
		li	$v0, 4			
	syscall					
		li	$v0, 5			
	syscall	
		add	$s2, $v0, $0		#price into s2
		sw	$s2, 0($s3)		#price into array1				
		addi	$t0, $t0, 1		#counter++
		addi	$s3, $s3, 4		#array1 pointer+4
		j	gettingItems	
		
numOfCoupons:	
		la	$s3, arr1
		#li	$s3, 0			#reseting the pointer to 0
		la 	$a0, enterCoupons	#Asking for the number of coupons
		li	$v0, 4			
	syscall					
		li	$v0, 5			
	syscall	
		add	$s5, $v0, $0		
		j 	validationNumCoupons
		
validationNumCoupons:
		beq	$s5, $s1, gettingCouponsValue
		la 	$a0, errorTooManyCoupons	#Asking for the number of coupons
		li	$v0, 4			
	syscall					
		li	$v0, 5			
	syscall	
		add	$s5, $v0, $0		
		j 	validationNumCoupons			
		
gettingCouponsValue:
		beq	$t2, $s5, resetCount
		la 	$a0, enterAmountCoupon		#Asking for the value of the coupons
		li	$v0, 4			
	syscall					
		li	$v0, 5			
	syscall	
		add	$s6, $v0, $0
		
		jal	couponsValueVal
		j	gettingCouponsValue
			
couponsValueVal: 
		lw	$s2, 0($s3)
		addi	$s3, $s3, 4
		beq	$s6, $s2, sameValue
		bgt	$s6, $s2, greaterThanPrice	
		bgt	$s6, 10, greaterThanTen	
		j	lessThanPrice
		jr	$ra

sameValue:
		la 	$a0, notAcceptable		
		li	$v0, 4			
	syscall
		sw	$0, 0($s4)
		addi	$s4, $s4, 4
		addi	$t2, $t2, 1
		j	gettingCouponsValue
		
greaterThanPrice:
		la 	$a0, notAcceptable		
		li	$v0, 4			
	syscall
		sw	$0, 0($s4)
		addi	$s4, $s4, 4
		addi	$t2, $t2, 1
		j	gettingCouponsValue

greaterThanTen:
		la 	$a0, notAcceptable		
		li	$v0, 4			
	syscall
		sw	$0, 0($s4)
		addi	$s4, $s4, 4
		addi	$t2, $t2, 1
		j	gettingCouponsValue
		
lessThanPrice:
		sw	$s6, 0($s4)
		addi	$s4, $s4, 4
		addi	$t2, $t2, 1
		j	gettingCouponsValue

resetCount:
		li	$t0, 0
		la	$s3, arr1
		la	$s4, arr2
				
addPrices:
		
		beq	$t0, $s5, exit
		
		lw	$t5, 0($s3)
		lw	$t6, 0($s4)

		sub	$s7, $t5, $t6
		
		add	$t8, $t8, $s7
		
		
		addi	$s3, $s3, 4
		addi    $s4, $s4, 4

		addi 	$t0, $t0, 1
		
		j	addPrices
				
exit:
		la 	$a0, result		
		li	$v0, 4			
	syscall					
		la	$a0, ($t8)
		li	$v0, 1
	syscall
		li	$v0, 10			#exit
	syscall					#exit					
									
