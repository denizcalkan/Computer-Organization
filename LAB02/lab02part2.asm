.data
	message1: .asciiz "Enter the array size: "
	message2: .asciiz "Enter an item: "
	message3: .asciiz "\nEnter 0 to stop or another number for new array size: "
	message4: .asciiz "\nThe array is a palindrome! "
	message5: .asciiz "\nThe array is NOT a palindrome! "
	message6: .asciiz "\nHere is your array: "
	message7: .asciiz "\nNumber of occurrences of an array element value, whose index is "
	message8: .asciiz " equals to "




.text
	main:
		#To invoke the subprogam countFrequency($a2 can modified from here)
		li $a2, 2
		
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
		
		#Check wheter the array is a palindrome or not in the subprogram
		jal checkPalindrome
		
		#Count the number of occurrences of an array element value, whose index is given in $a2, in the array in the subprogram.
		jal countFrequency
		
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
		
			jal checkPalindrome
		
			jal countFrequency
			
			bne $a1, $zero, again
			
			
		end:
			li $v0, 10
			syscall

li $v0, 10
syscall

createPopulateArray:
	
	addi $sp, $sp, -20
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	
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
	print: beq $s2, $zero, stop
		
		lw $s5, 0($s3)
		li $v0, 1
		move $a0, $s5
		syscall
		addi $s3, $s3, 4
		subi $s2, $s2, 1
	j print 
	
	stop:
		
	lw $s5, 0($sp)
	lw $s4, 4($sp)
	lw $s3, 8($sp)
	lw $s2, 12($sp)
	lw $s1, 16($sp)
	lw $s0, 20($sp)
	addi $sp, $sp, 20	

jr $ra


checkPalindrome:

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
	
	#$s0 holds the beggining adress of the array (not the original array)
	move $s0, $v0
	#$s1 holds the adress of the last item in the array
	move $s1, $v1
	#$s2 holds the array size
	move $s2, $a1
	
	#Filling a new array reversly with the contents of the original array
	reverseArray: beq $s2, $zero, done
		        
		        lw $s3, 0($s1)
		        sw $s3, 0($s0)
		
			#Decrement $s1 by 4 so that it points to the previous index
			addi $s1, $s1, -4
			
			#Increment $s0 by 4 so that it points to the next index
			addi $s0, $s0, 4
			
			#Increment $s2 by 1 
			subi $s2, $s2, 1
			
	j reverseArray
	
	done:	
		#$s0 holds the beginning adress of the reversed array
		move $s0, $v0
		addi $s1, $s1, 4
		#$s6 holds the beginning adress of the original array
		move $s6, $s1 
		move $s2, $a1
	
	
	compareArrays: beq $s2, $zero, endc
		
		lw  $s4, 0($s0)
	        lw  $s5, 0($s1)
		        
		bne  $s4, $s5, isNotPalindrome
			
		#Increment  $s0 by 4 so that it points to the next index
		addi $s0, $s0, 4
		
		#Increment  $s1 by 4 so that it points to the next index
		addi $s1, $s1, 4
			
		#Increment $s2 by 1 
		subi $s2, $s2, 1
        
        j compareArrays
		
	 endc:
		
		isPalindrome:
			#Print message4
			li $v0, 4
			la $a0, message4
			syscall
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
		
		
		isNotPalindrome:
			#Print message5
			li $v0, 4
			la $a0, message5
			syscall
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
jr $ra


countFrequency:

	addi $sp, $sp, -24
	sw $s0, 24($sp)
	sw $s1, 20($sp)
	sw $s2, 16($sp)
	sw $s3, 12($sp)
	sw $s4, 8($sp)
	sw $s5, 4($sp)
	sw $s6, 0($sp)
	
	#$s0 holds the beggining adress of the array
	move $s0, $a0
	#$s4 holds the beggining adress of the array
	move $s4, $a0
	#$s1 holds the index
	add $s1, $s1, $a2
	#$s6 holds the array size
	move $s6, $a1
	
	#Find the value at index $a2 and store it in $s2
	findValueAtIndex: beq $s3, $s1, endf
			  addi $s0, $s0, 4
			  addi $s3, $s3, 1
	j findValueAtIndex
	
	endf:
		lw $s2, 0($s0)
		addi $s3, $zero, 0
		addi $s0, $zero, 0
		
	#Count frequency	
	count:  beq $s5, $s6, endco
		lw $s3, 0($s4)
		beq $s3, $s2, addCounter
		addi $s5, $s5, 1
		addi $s4, $s4, 4
		
	j count
	
	addCounter:
		addi $s0, $s0, 1
		addi $s5, $s5, 1
		addi $s4, $s4, 4
		bne $s5, $s6, count
	
		
	endco:
		
		#Print message7
	 	li $v0, 4
		la $a0, message7
		syscall
		
		#Print index
		li $v0, 1
		move $a0, $s1
		syscall
		
		#Print message8
	 	li $v0, 4
		la $a0, message8
		syscall
		
		#Print frecuency
		li $v0, 1
		move $a0, $s0
		syscall
	
		lw $s6, 0($sp)
		lw $s5, 4($sp)
		lw $s4, 8($sp)
		lw $s3, 12($sp)
		lw $s2, 16($sp)
		lw $s1, 20($sp)
		lw $s0, 24($sp)
		addi $sp, $sp, 24	
	
jr $ra