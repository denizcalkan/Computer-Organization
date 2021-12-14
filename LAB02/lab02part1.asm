.data

	message1: .asciiz "Enter a number to be complemented: "
	message2: .asciiz "Enter the value of n (n number of rightmost bits): "
	message3: .asciiz "\nYour input in hex format: "
	message4: .asciiz "\nYour input's complement in hex format: "
	message5: .asciiz "\nEnter 0 to stop or another number to be complemented: "




.text
	main:
		#Print message1
	 	li $v0, 4
		la $a0, message1
		syscall
		
		#Get users response for message1
		li $v0, 5
		syscall

		#Store the response in $a1 (number to be complemented)
		move $a1, $v0
		
		 #Print message2
	 	li $v0, 4
		la $a0, message2
		syscall
		
		#Get users response for message2
		li $v0, 5
		syscall
		
		#Store the response in $a2 (n number of rightmost bits)
		move $a2, $v0
		
		jal bitComplementor
		
		 #Print message3
	 	li $v0, 4
		la $a0, message3
		syscall
		
		#Print number in hex 
		move $a0, $a1
	 	li $v0, 34
		syscall
		
		 #Print message4
	 	li $v0, 4
		la $a0, message4
		syscall
		
		#Print complemented number in hex
		move $a0, $v1
	 	li $v0, 34
		syscall
		
		again: 
		        #Print message5
	 		li $v0, 4
			la $a0, message5
			syscall
			
			#Get users response for message5
			li $v0, 5
			syscall
		
			#Store the response in $a3 (n number of rightmost bits)
			move $a1, $v0
			
			beq, $zero, $a1, end
			
			#Print message2
	 		li $v0, 4
			la $a0, message2
			syscall
		
			#Get users response for message2
			li $v0, 5
			syscall
		
			#Store the response in $a2 (n number of rightmost bits)
			move $a2, $v0
			
			jal bitComplementor
			
			#Print message3
	 		li $v0, 4
			la $a0, message3
			syscall
		
			#Print number in hex 
			move $a0, $a1
	 		li $v0, 34
			syscall
			
			 #Print message4
	 		li $v0, 4
			la $a0, message4
			syscall
			
			#Print complemented number in hex
			move $a0, $v1
	 		li $v0, 34
			syscall
			
			#If user enters 0 end program
			bne, $zero, $a1, again
		
		end:
			li $v0, 10
			syscall

li $v0, 10
syscall


bitComplementor:

	#Creating a control register
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	#Store all 1's
	li $s0, -1

		shift: 
			#shifting left  n times
			sll $s0, $s0, 1
			subi  $a2, $a2, 1
			bne , $a2, 0, shift 
			beq , $a2, 0, convertBits
		
	convertBits:
		#XNOR operation gives the opposite of B when A is 0 and gives B when A is 1.
		# A = $s0, B = $a1	
		xor $v0, $a1, $s0 
	        not $v1, $v0
	        
	lw $s0, 0($sp)
	addi $sp, $sp, 4	

jr $ra	


		
		
