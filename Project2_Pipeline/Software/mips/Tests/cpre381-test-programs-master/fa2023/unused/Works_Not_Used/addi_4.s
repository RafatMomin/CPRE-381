.data
.text
.globl main
main:
	# Start Test
	
	# Initialize two registers with values
	addi $t0, $zero, 10   # $t0 = 10
	addi $t1, $zero, 20   # $t1 = 20

	# Add two registers using addi instruction
	addi $t2, $t0, 5      # $t2 = $t0 + 5 = 15
	
	# End Test
	
	# In this test case, it demonstrates the basic usage of the "addi" instruction.
	# The "addi" instruction adds a constant value to the contents of a register, allowing for simple integer arithmetic operations.
	# Also, this test case also shows how to initialize registers with specific values using the "addi" instruction.
	# Finally, this test case illustrates how to use the result of the "addi" instruction to store the result in another register.
	# This demonstrates how multiple instructions can be combined to perform more complex arithmetic operations in MIPS.
	
# Exit program
halt