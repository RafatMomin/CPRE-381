.data
.text
.globl main
main:
	
	# This test subtracts two large positive numbers resulting in an overflow.
	# It checks if overflow is corretly dealt with.

    	# Start Test
	addi $s7, $zero, 100       	# Load 100 into $t6
	addi $t8, $zero, -2147483647  	# Load -2147483647 (MIN_INT) into $t7
	# $t11 = $t9 - $t10 = MAX_INT - (-100) = MAX_INT + 100 (overflow)
	sub $t9, $s7, $t8           	# Subtract $t7 from $t6, causing overflow
    	# End Test

    	# Exit program
    	halt
