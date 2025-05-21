.data
	test_array: .word 1,2,3,4,5,6,7,8
	
.text
.globl main

#This unit test verifies that you can offset the address and read in an array

main:
	lui $t0, 0x1001 #Loads memory base address into $t0
	addiu $t0, $t0, 0x0000 #complated base address load
	lw $s0, 0($t0) #$s0 should contain 1
	addiu $t0, $t0, 4 #offset the address
	lw $s1, 0($t0) #$s1 should contain 2
	addiu $t0, $t0, 4 #offset the address
	lw $s2, 0($t0) #$s2 should contain 3
	addiu $t0, $t0, 4 #offset the address	
	lw $s3, 0($t0) #$s3 should contain 4
	addiu $t0, $t0, 4 #offset the address	
	lw $s4, 0($t0) #$s4 should contain 5
	addiu $t0, $t0, 4 #offset the address	
	lw $s5, 0($t0) #$s5 should contain 6
	addiu $t0, $t0, 4 #offset the address	
	lw $s6, 0($t0) #$s6 should contain 7
	addiu $t0, $t0, 4 #offset the address	
	lw $s7, 0($t0) #$s7 should contain 8
	addiu $t0, $t0, 4 #offset the address	
	
	halt