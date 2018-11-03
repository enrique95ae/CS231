		.data
Prompt:		.asciiz "Please enter the message that you want to be sent:\n\n"
EncryptPrompt:	.asciiz "\nYour encrypted message is:\n"
DecryptPromt:	.asciiz "\nYour decrtpyed message is:\n"
NewLine:	.asciiz "\n"
space1:		.asciiz "\n"
Input:		.byte	'_','_','_','_','_','_','_','_','_','_'
space2:		.asciiz "\n"
Encryption:	.byte	'_','_','_','_','_','_','_','_','_','_'
space3:		.asciiz "\n"
Decryption:	.byte	'_','_','_','_','_','_','_','_','_','_'

	.text
main:
	li $t0, 10
	li $t5, 10
	la $s1, Encryption
	la $s2, Decryption


	la $a0, Prompt
	li $v0, 4
	syscall
	
	la $a0, Input
	li $a1, 10
	li $v0, 8
	syscall
	
	la $a0, NewLine
	li $v0, 4
	syscall
	
	la $a0, EncryptPrompt
	li $v0, 4
	syscall
	
	la $s0, Input
LoopEncrypt:

	beq $t0, $0, PrintEncrypt
	lb $t1, 0($s0)
	
	addi $s0, $s0, 1
	
	xor $t2, $t1, $t5	# $t2 = 1st Character + 10
	sb $t2, 0($s1)
	
	li $t1, 0
	li $t2, 0
	
	addi $s1, $s1, 1
	addi $t0, $t0, -1
j LoopEncrypt
	
PrintEncrypt:
	la $a0, EncryptPrompt
	li $v0, 4
	syscall
	
	la $a0, Encryption
	li $v0, 4
	syscall
	
	la $s1, Encryption
	la $s2, Decryption
	li $t0, 10
	
LoopDecrypt:
	beq $t0, $0, PrintDecrypt
	lb $t1, 0($s1)
	
	addi $s1, $s1, 1
	
	xor $t2, $t1, $t5	# $t2 = 1st Character + 10
	sb $t2, 0($s2)
	
	li $t1, 0
	li $t2, 0
	
	addi $s2, $s2, 1
	addi $t0, $t0, -1
	
j LoopDecrypt

PrintDecrypt:
	la $a0, DecryptPromt
	li $v0, 4
	syscall
	
	#la $s2, Decryption
	la $a0, Decryption
	li $v0, 4
	syscall

Exit:
	li $v0, 10
	syscall