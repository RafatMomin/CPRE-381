.data
.text
.globl main
main:
	# This test case is to make sure that 5 < 10 and that the output is properly 1
	# Using register $8, $9, and $10 because they are temporary register, could use any realistically
	# Start Test
	# Clear registers
	andi $8, $0, 0
	andi $9, $0, 0
	andi $10, $0, 0

	# Test 1: Set $t0 to 1 if $t1 < $t2, else 0
	addi $9, $0, 5
	addi $10, $0, 10
	slt $8, $9, $10  # $t1 (5) < $t2 (10), so $8 should be 1
	# End Test

	# Exit program
	halt
