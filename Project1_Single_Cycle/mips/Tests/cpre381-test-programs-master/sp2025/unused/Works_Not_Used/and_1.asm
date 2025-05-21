.data
.text
.globl main
main:
	#What am I testing:
	#Test 1 ensures that any value in a register anded with the zero register
	#will result in 0.
	
	#Start Test
	
	#Sets $t0 = 0xFFFFFFFF (all 1's)
	lui $t0, 0xFFFF
	addi $t0, $t0, 0xFFFF
	
	#Ensure that $t1 is all 0's
	and $t1, $t0, $zero
	
	# End Test

	# Exit program
	halt