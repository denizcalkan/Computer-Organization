#A program that calculates an arithmetic expression
.data
	expression: .asciiz "A= (B*(C MOD D) + C/B) - B\n"
	message1:   .asciiz "Please enter B: "
	message2:   .asciiz "Please enter C: "
	message3:   .asciiz "Please enter D: "
	message4:   .asciiz "A = "
	
	
.text
	main:
	
		#Print expression
	 	li $v0, 4
		la $a0, expression
		syscall
		
		#Print message1
		li $v0, 4
		la $a0, message1
		syscall

		#Get users response for message1
		li $v0, 5
		syscall
		
		#Store the response in $a1 (B)
		addi $a1, $v0, 0
		
		#Print message2
		li $v0, 4
		la $a0, message2
		syscall

		#Get users response for message2
		li $v0, 5
		syscall
		
		#Store the response in $a2 (C)
		addi $a2, $v0, 0
		
		#Print message3
		li $v0, 4
		la $a0, message3
		syscall

		#Get users response for message3
		li $v0, 5
		syscall
		
		#Store the response in $a3 (D)
		addi $a3, $v0, 0
		
		
		#Call function
		jal calculateExpression
		
		#Store the result in $t6
		move $t6, $v0
		
		#Print message5
		li $v0, 4
		la $a0, message4
		syscall
		
		#Print result
		li $v0, 1
		addi $a0, $t6, 0
		syscall
		
	
	li $v0, 10
	syscall
	
calculateExpression: 
	
	div $a2, $a3 # C MOD D
	mfhi $t0  # $t0 = C MOD D
	mult $t0, $a1 # B * (C MOD D)
	mflo $t1 # $t1 = B * (C MOD D)
	div $a2, $a1 # C / B
	mflo $t2 #$t2 = C / B
	add $t3, $t2, $t1 # $t3 = B * (C MOD D) + C/B
	sub $t4, $t3, $a1 # t4 =  (B * (C MOD D) + C/B) - B
	addi $v0, $t4, 0
	
    jr $ra


