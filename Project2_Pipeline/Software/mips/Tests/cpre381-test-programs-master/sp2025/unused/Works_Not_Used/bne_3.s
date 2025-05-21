# bne_mss3247_2.s - Edge Case: Zero REG	
.data
.text
.globl main
main:
	#Initialize register and compare with zero register 
	addi $1, $0, 0 
	
	bne $1, $0, not_expected
	
	# This should execute
	addi $1, $0, 5
	
	#test again with a nonzero value
	addi $1, $0, 6 
	
	bne $1, $0, expected
	
	#this should not be executed
	addi $3,$0,1
	j end
	
	not_expected:
	addi $3, $0, 200
	j end
	
	expected:
	addi $3, $0, 300	
	
	end:
	
	halt
	
	