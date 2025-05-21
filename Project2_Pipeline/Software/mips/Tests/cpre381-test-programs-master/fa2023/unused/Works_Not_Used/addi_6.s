.data
.text
.globl main
main:
	# Start Test
	
	# Initialize a register with value
	addi $t0, $zero, 0    # $t0 = 0

	# Add two registers using addi instruction (should cause underflow)
	addi $t2, $t0, -1     # $t2 = $t0 - 1 = -1	
	
	# End Test
	
	# This case is important because  because it tests the behavior of the instruction in a scenario where it causes an underflow. 
	# The "addi" instruction adds an immediate value to a register, and if the result exceeds the range of a signed 32-bit integer, it will overflow and wrap around to a negative value.
	# However, if the result is less than the minimum value that can be represented, it will underflow and wrap around to a positive value.
	# This should cause an underflow and result in the value of register $t2 being set to the maximum positive value that can be represented.

# Exit program
halt