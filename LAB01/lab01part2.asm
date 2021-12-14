.data
	expression: .asciiz "x = a * (b - c) / d\n"
	message1:   .asciiz "Please enter a: "
	message2:   .asciiz "Please enter b: "
	message3:   .asciiz "Please enter c: "
	message4:   .asciiz "Please enter d: "
	message5:   .asciiz "x = "
	
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
		
		#Store the response in $a1 (a)
		addi $a1, $v0, 0
		
		#Print message2
		li $v0, 4
		la $a0, message2
		syscall

		#Get users response for message2
		li $v0, 5
		syscall
		
		#Store the response in $a2 (b)
		addi $a2, $v0, 0
		
		#Print message3
		li $v0, 4
		la $a0, message3
		syscall

		#Get users response for message3
		li $v0, 5
		syscall
		
		#Store the response in $a3 (c)
		addi $a3, $v0, 0
		
		#Print message4
		li $v0, 4
		la $a0, message4
		syscall

		#Get users response for message4
		li $v0, 5
		syscall
		
		#Store the response in $a0 (d)
		addi $a0, $v0, 0
		
		#Call function
		jal calculateExpression
		
		#Store the result in $t6
		move $t6, $v0
		
		#Print message5
		li $v0, 4
		la $a0, message5
		syscall
		
		#Print result
		li $v0, 1
		addi $a0, $t6, 0
		syscall
		
	
	li $v0, 10
	syscall
	
calculateExpression: 
	
	sub $t0, $a2, $a3 # (b - c) = $t0
	mult $t0, $a1 # a * $t0
	mflo $t1 # $t1 = a * $t0
	div $t1, $a0 # $t1 / d
	mfhi $t2  # $t2 = $t1 % d
	addi $v0, $t2, 0
	
    jr $ra


	
