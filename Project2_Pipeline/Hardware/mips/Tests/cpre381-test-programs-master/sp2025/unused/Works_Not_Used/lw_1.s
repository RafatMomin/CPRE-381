.data
	test_data1: .word 0x12345678
	
.text
.globl main

#simple test to verify that a full word can be read out of memory. 

main:
	lui $t0, 0x1001 #Loads memory base address into $t0
	addiu $t0, $t0, 0x0000 #complated base address load
	lw $s0, 0($t0) #loads expected value of 0x12345678 into $s0
	halt