.data
.text
.globl main
main:
	# Start Test
	
	# Initialize a register with value
	addi $t0, $zero, 2147483647  # $t0 = 2^31 - 1

	# Add two registers using addi instruction (should cause overflow)
	addi $t2, $t0, 1            # $t2 = $t0 + 1 = -2147483648 (overflow)
	
	# End Test
	
	# This test case is important because it helps to verify the correctness of the processor's handling of integer overflow. 
	# In the test case, the value of register $t0 is set to the maximum positive value that can be represented by a 32-bit signed integer, which is 2^31 - 1. 
	# Then, an "addi" instruction is used to add 1 to $t0 and store the result in $t2.

	# Since the result of the addition exceeds the maximum value that can be represented by a 32-bit signed integer, the result should be negative due to integer overflow. 
	# Specifically, the value of $t2 should be -2^31, which is the minimum value that can be represented by a 32-bit signed integer. 

# Exit program
halt