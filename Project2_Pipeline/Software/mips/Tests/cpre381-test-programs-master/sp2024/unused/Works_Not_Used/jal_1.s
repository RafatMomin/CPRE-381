.data
#This tests only the inital call for JAL, and the returns using the $ra, the loop will run user defined times
#before dropping off the bottom. execution will continue in an infite loop. For the person of this example
# I have set it to 100, which means 5 Jal per time, or 500 JAL operations. Further down you can specify a multiplier to 
# to run it even more times, meaning you can run this loop 100 times, times the multiplier of 150, or 150000 * 5 jal
#operations each time so a very large amount of times. This each time just sets the JAL register, and keeps flipping through.
#if more is wanted a simple jal pattern can be seen to modify it. 
# $a0 will track number of loops.
# $a1 will track the number of completed loops and or this is the modifier value.
# $s0 will hold the value of one if we successfully complete all the loops and exited properly by falling off.


.text
.globl main

main:
    # Initialize loop counter
	addi $a0, $zero, 0	# a0 will represent the number of loop runs, and $a1 will represent the number of loop runs*100.
	addi $a1, $zero, 0	# We initalize A0 and A1 to zero so we can track everything correctly.
    	li $a0, 0             	# $a0 will keep track of the total number of iterations

loop_start:
    	# Check if loop counter has reached 100 iterations
   	 li $t0, 3           	# Load loop limit into $t0 ********this is where you load the loop limit********
    	beq $a0, $t0, loop_end 	# If $a0 == 100, exit loop

    	# Call Method 1
    	jal method1

    	# Call Method 2
   	jal method2

    	# Call Method 3
    	jal method3

    	# Call Method 4
    	jal method4

    	# Call Method 5
    	jal method5

   	# Increment loop counter and continue loop
    	addi $a0, $a0, 1
    	j loop_start

loop_end:
   	 # At this point, $a0 contains the total number of iterations (100)
    	addiu $a1, $a1, 1         	# Copy the iteration count to $a1
    	addu $a0, $zero, $zero		#reset $a0 to 0, and run again.

    	# End of program
    	# Implement an exit syscall or an infinite loop here depending on your environment's requirements
    	
    	li $t0, 150          # Load immediate value 150 into $t0 for comparison******multiplier here*******
    	beq $a1, $t0, end_test  # If $t0 equals 150, branch to end_test
    	
    	                   	
# Method Definitions

method1:
    	# Empty for purposes of testing jump and link.
    	jr $ra

method2:
    	# Empty for purposes of testing jump and link.
    	jr $ra

method3:
   	 # Empty for purposes of testing jump and link.
    	jr $ra

method4:
    	# Empty for purposes of testing jump and link.
    	jr $ra

	method5:
    	# Empty for purposes of testing jump and link.
    	jr $ra
    	
end_test:
	addi $s0, $zero, 1
	halt
