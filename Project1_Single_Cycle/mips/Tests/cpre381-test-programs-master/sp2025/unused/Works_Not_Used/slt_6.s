.data
.text
.globl main
main:
	# This test case is here to show that slt can properly handle negative numbers, in the case where slt should be 1
	# -5 < -7 -> 0

	# Using registers $8, $9, and $10 as these are temporary registers in MIPS
	# Start Test
	# Clear registers
	andi $8, $0, 0
	andi $9, $0, 0
	andi $10, $0, 0

	# Test 2: Set $8 to 1 if $9 < $10, else 0. same in all
	addi $9, $0, -5
	addi $10, $0, -7
	slt $8, $9, $10 # $9 < $10, so $8 should be 0
	# End Test

	# Exit program
	halt
