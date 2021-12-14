.data
	message1: .asciiz "Enter the array size: "
	message2: .asciiz "Enter an item: "
	message3: .asciiz "\nEnter 0 to stop or another number for new array size: "
	message4: .asciiz "Number of occurrences of number "
	message5: .asciiz " in the array equals to "
	message6: .asciiz "Here is your array: "
	message7: .asciiz "\nHere is the compressed array: "
	message8: .asciiz "\nEnter the number you want to delete: "
	

.text
	main:
		
		#Print message1
	 	li $v0, 4
		la $a0, message1
		syscall

		#Get users response for message1 (array size)
		li $v0, 5
		syscall
		
		#Store the response in $a1 (array size)
		move $a1, $v0
		
		#After getting the size go to subprogram to get the items from the user and create the array
		jal createPopulateArray
		move $t6, $a0
		
		#Print message8
	 	li $v0, 4
		la $a0, message8
		syscall

		#Get users response for message8 
		li $v0, 5
		syscall
		
		#Store the response in $a2 
		move $a2, $v0
		
		move $a0, $t6
		
		jal compressArray
		
		move $t0, $v0
		move $t1, $v1
		
		print2: beq $t1, $zero, stop2
		
		lw $t3, 0($t0)
		li $v0, 1
		move $a0, $t3
		syscall
		
		addi $t0, $t0, 4
		subi $t1, $t1, 1
	j print2 
	
	stop2:
		
		#Call all subprograms as long as user wants to continue
		again:
			
			#Print message3
	 		li $v0, 4
			la $a0, message3
			syscall
		
			#Get users response for message3
			li $v0, 5
			syscall
		
			#Store the response in $a1 (array size)
			move $a1, $v0
			
			#If user enters 0 end program
			beq $a1, $zero, end
			
			jal createPopulateArray
			move $t5, $a0
		
			#Print message8
	 		li $v0, 4
			la $a0, message8
			syscall

			#Get users response for message8 
			li $v0, 5
			syscall
		
			#Store the response in $a2 
			move $a2, $v0
		
			move $a0, $t5
			
			jal compressArray
			
			move $t0, $v0
			move $t1, $v1
		
			print3: beq $t1, $zero, stop3
		
			       lw $t3, 0($t0)
			       li $v0, 1
		                move $a0, $t3
		                syscall
		
		               addi $t0, $t0, 4
		                subi $t1, $t1, 1
	              j print3 
	
	               stop3:
			
			bne $a1, $zero, again
			
		end:
			li $v0, 10
			syscall

li $v0, 10
syscall
		
			
createPopulateArray:
	
		
	addi $sp, $sp, -24
	sw $s0, 24($sp)
	sw $s1, 20($sp)
	sw $s2, 16($sp)
	sw $s3, 12($sp)
	sw $s4, 8($sp)
	sw $s5, 4($sp)
	sw $s6, 0($sp)
	
	#Creating a space = array size * 4 
	addi $s4, $s4, 4
	mult $a1, $s4
	mflo $s4
	
	#Dynamic array allocation
	move $a0, $s4
	li $v0, 9 		
	syscall
	
	#$s0 holds the beginning adress of the array
	move $s0, $v0
        #$s3 also holds the beginning adress of the array
   	move $s3, $s0
   	#$s6 also holds the beginning adress of the array
   	move $s6, $s0
   	#$s1 holds the array size
	move $s1, $a1
        #$s2 also holds the array size	
	move $s2, $a1
	
	#Ask user to enter items then store them in the array
	while:  beq  $s1, $zero, endi
		
			#Print message2
	 		li $v0, 4
			la $a0, message2
			syscall
		
			#Get users response for message2
			li $v0, 5
			syscall
		
			sw $v0, 0($s0)
			addi $s0, $s0, 4
			subi $s1, $s1, 1
	j while
	
	endi:
		subi $s0, $s0, 4
		
		#Store the adress of the last item in $v1 ( wil be used in other subprogram)
		move $v1, $s0
		
		#Print message6
	 	li $v0, 4
		la $a0, message6
		syscall
	
	#Print array	
	print1: beq $s2, $zero, stop1
		
		lw $s5, 0($s3)
		li $v0, 1
		move $a0, $s5
		syscall
		addi $s3, $s3, 4
		subi $s2, $s2, 1
	j print1 
	
	stop1:
		#$a0 holds the beginning adress of the array
		move $a0, $s6
		
		lw $s6, 0($sp)
		lw $s5, 4($sp)
		lw $s4, 8($sp)
		lw $s3, 12($sp)
		lw $s2, 16($sp)
		lw $s1, 20($sp)
		lw $s0, 24($sp)
		addi $sp, $sp, 24	

jr $ra


compressArray:

	addi $sp, $sp, -32
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $s7, 0($sp)


	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	
	#Count frequency	
	count:  beq $s3, $s1, endco
		lw $s4, 0($s0)
		beq $s4, $s2, addCounter
		addi $s3, $s3, 1
		addi $s0, $s0, 4
		
	j count
	
	addCounter:
		addi $s5, $s5, 1
		addi $s3, $s3, 1
		addi $s0, $s0, 4
		bne $s5, $s6, count
	
	endco:

	addi $s3, $zero, 0
	#$s3 holds the compressed arrays size
	sub $s3, $s1, $s5
	move $v1, $s3
	move $s1, $s5
	move $s3, $a1
	
	addi $s4, $zero, 0
	addi $s5, $zero, 0
	move $s0, $a0
	
	addi $s4, $s4, 4
	mult $s3, $s4
	mflo $s4
	
	
        #Dynamic array allocation
	move $a0, $s4
	li $v0, 9 		
	syscall
	
	#$s4 holds the beggining adress of the compressed array (not the original array)
	move $s4, $v0
	move $s7, $v0
	
	
	fill: beq $s5, $s3, endf
	      lw $s6, 0($s0)
	      bne $s6, $s2, addItem
	      addi $s5, $s5, 1
	      addi $s0, $s0, 4
	j fill
	
	addItem:
		sw $s6, 0($s4)
		addi $s4, $s4, 4
		addi $s5, $s5, 1
	      	addi $s0, $s0, 4
	      	bne $s5, $s3, fill
	 endf: 
	 
	 	#Print message4
	 	li $v0, 4
		la $a0, message4
		syscall
		
		#Print index
		li $v0, 1
		move $a0, $a2
		syscall
		
		#Print message5
	 	li $v0, 4
		la $a0, message5
		syscall
		
		#Print index
		li $v0, 1
		move $a0, $s1
		syscall
		
		#Print message7
	 	li $v0, 4
		la $a0, message7
		syscall
		
		move $v0, $s7
		
	
	lw $s7, 0($sp)
	lw $s6, 4($sp)
	lw $s5, 8($sp)
	lw $s4, 12($sp)
	lw $s3, 16($sp)
	lw $s2, 20($sp)
	lw $s1, 24($sp)
	lw $s0, 28($sp)
	addi $sp, $sp, 32	

jr $ra

		
		
		
