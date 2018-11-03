	.data
	
	
	
space:	.asciiz "\n"
message:.space 10
encrypt:.space 10
decrypt:.space 10

	.text
main:
	la $s3, decrypt
	la $s1, encrypt
	li $t0, 10
	li $t5, 10
	
	li $v0, 8
	la $a0, message
	li $a1, 10
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	
#----------------------------
	la $a0, message
	li $v0, 4
	syscall
	
	
	
	la $s2, message
#----------------------------
	li $v0, 4
	la $a0, space
	syscall
	


loop: beq $t0, $0, print
	lb $t1, 0($s2)
	addi $s2, $s2, 1
	xor $t2, $t1, $t5
	sb $t2, 0($s1)
	li $t1, 0
	li $t2, 0
	addi $s1, $s1, 1
	addi $t0, $t0, -1
	
	j loop
	
	
	
print:	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 4
	la $a0, encrypt
	syscall
	
	la $s1, encrypt
	
loop2:	beq $t0, 10, print2
	lb $t1, 0($s2)
	addi $s1, $s1, 1
	xor $t2, $t1, $t5
	sb $t2, 0($s3)
	addi $s3, $s3, 1
	li $t1, 0
	li $t2, 0
	addi $t0, $t0, 1
	j loop2
	
	
	
print2:	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 4
	la $a0, decrypt
	syscall
	
exit:	li $v0, 10
	syscall
	