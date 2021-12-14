.data
	array: .space 80
	reversedArray: .space 80
	message1: .asciiz "Enter the array size: "
	message2: .asciiz "Enter the item: "
	message3: .asciiz "\nThe array is a palindrome!"
	message4: .asciiz "\nThe array is NOT a palindrome!"
	
.text
	main:
		#Print message1
	 	li $v0, 4
		la $a0, message1
		syscall

		#Get users response for message1
		li $v0, 5
		syscall

		#Store the response in $t0 (array size)
		move $t0, $v0

		#Create a counter 
		addi $t1, $zero, 0
		
		#Create another counter for index 
		addi $t2, $zero, 0

		#Fill the array with the user input
		while1:  beq  $t1, $t0, end1
			
			#Print message2
	 		li $v0, 4
			la $a0, message2
			syscall

			#Get users response for message2 (items)
			li $v0, 5
			syscall
		
			#Store the response in $t3 (item)
			move $t3, $v0
			
			#Store item that $t3 holds to the index where $t2 points to
			sw $t3, array($t2)
			
			#Increment $t2 by 4 so that it points to the next index
			addi $t2, $t2, 4
			
			#Increment $t1 by 1 
			addi $t1, $t1, 1
			
			j while1
			
		end1:
				
		#Reset counter
		addi $t1, $zero, 0
		
		#Reset counter
		addi $t2, $zero, 0
		
		#Reset counter
		addi $t3, $zero, 0
		
		#Display array contents
		while2: beq $t1, $t0, end2
		        lw $t3, array($t2)
		       
		        #print
		        li $v0, 1
		        move $a0, $t3
		        syscall
		       
		        #Increment $t2 by 4 so that it points to the next index
			addi $t2, $t2, 4
			
			#Increment $t1 by 1 
			addi $t1, $t1, 1
			
			j while2
		end2:
		
		#Reset counter
		addi $t1, $zero, 0
		
		#Decrement $t2 by 4 so that it points to the last item in the array
		addi $t2, $t2, -4
		
		#Reset counter
		addi $t3, $zero, 0
		
		#Create a counter for the reversedArray
		addi $t4, $zero, 0
		
		#Reverse the array 	
		while3: beq $t1, $t0, end3
		        
		        lw $t3, array($t2)
		        sw $t3, reversedArray($t4)
		
			#Decrement $t2 by 4 so that it points to the previous index
			addi $t2, $t2, -4
			
			#Increment $t4 by 4 so that it points to the next index
			addi $t4, $t4, 4
			
			#Increment $t1 by 1 
			addi $t1, $t1, 1
			
			j while3
		end3:
		
		#Reset counter
		addi $t1, $zero, 0
		
		#Reset counter
		addi $t2, $zero, 0
		
		
		#Compare the arrays
		while4: beq $t1, $t0, end4
			lw  $t6, array($t2)
		        lw  $t7, reversedArray($t2)
		        
			bne  $t6, $t7, isNotPalindrome
			
			#Increment  $t2 by 4 so that it points to the next index
			addi $t2, $t2, 4
			
			#Increment $t1 by 1 
			addi $t1, $t1, 1
			
		        j while4
		end4:
		
		isPalindrome:
			li $v0, 4
			la $a0, message3
			syscall
			li $v0, 10
                        syscall
		
		
		isNotPalindrome:
			li $v0, 4
			la $a0, message4
			syscall
			li $v0, 10
                        syscall
															
li $v0, 10
syscall
