# TC4: Subtracting Zero
# Tests comon cases of subtracting by 0 and subtracing a value from 0

.data
	val1: .word 6087014	# 0x005CE166
	val2:	.word 16447803	# 0x00FAF93B
	
.text

.globl main
main:
	lw 	$s0, val1 # Load test val1 into $s0
	lw 	$s1, val2 # Load test val into  $s0
	sub 	$t0, $s0, $zero # Test 6087014 - 0 = 6087014 (0x005CE166)
	sub 	$t1, $s1, $zero # Test 16447803 - 0 = 16447803 (0x00FAF93B)
	sub 	$t2, $zero, $s0 # Test 0 - 6087014 = -6087014 (0xFFA31E9A)
	sub 	$t3, $zero, $s1 # Test 0 - 16447803 = -16447803 (0xFF0506C5)
	halt 
