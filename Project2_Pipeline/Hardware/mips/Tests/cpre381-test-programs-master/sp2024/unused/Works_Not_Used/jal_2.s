#this stress test for JAL implements a infinite depth recursion, the depth can be changed and modified by
#changing the first addi call number. During this we will use JAL that number of times.
# $a0 holds the desired depth of the recursion.
# s1 will hold the value of 1 if we exited correctly.
# $a0 should also equal zero at end indicating the counter ended. 
.data

.text
.globl main

main:
    	addi $a0, $zero, 10 # **Initialize the counter to anything you want for the number of recursive calls**

    	jal recursiveMethod 	# Jump to the recursive method the first time


recursiveMethod:
    	# Check if the counter has reached zero
    	beq $a0, $zero, returnFromRecursion # If counter is 0, return from this method

    	# Decrement the counter
    	addi $a0, $a0, -1   # Decrement the counter by 1

    	# Recursive call
    	jal recursiveMethod # Jump to itself (recursive call)
    
returnFromRecursion:
	addi $s0, $zero, 1
	halt
