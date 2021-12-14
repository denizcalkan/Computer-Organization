##
##	Program3.asm is a loop implementation
##	of the Fibonacci function
##        

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here
	li $a0,9	# to calculate fib(7)
	jal fib		# call fib  #flb->fib
	move $a0,$v0	# print result
	li $v0, 1
	syscall         #syscal->syscall

	la $a0,endl	# print newline #end->endl
	li $v0,4
	syscall          #syscal->syscall

	li $v0,10       #100->10 
	syscall	  	#syscal->syscall	# bye bye

#------------------------------------------------


fib:	move $v0,$a0	# initialise last element
	blt $a0,2,done	# fib(0)=0, fib(1)=1 #don->done

	li $t0,0	# second last element
	li $v0,1	# last element

loop:	add $t1,$t0,$v0	# get next value #v0->$v0
	move $t0,$v0	# update second last
	move $v0,$t1	# update last element
	sub $a0,$a0,1	# decrement count
	bgt $a0,1,loop	# exit loop when count=0 #0->1
done:	jr $ra

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
endl:	.asciiz "\n"

##
## end of Program3.asm
