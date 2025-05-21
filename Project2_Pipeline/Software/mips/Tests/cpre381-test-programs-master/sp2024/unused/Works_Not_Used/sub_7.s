# TC1: Subtracting Positive Numbers 
# Tests common case of subtracting two postiive numbers

.data
	val1: .word 6087014	# 0x005CE166
	val2:	.word 16447803	# 0x00FAF93B
	
.text

.globl main
main:
	lw 	$s0, val1 # Load test val1 into $s0
	lw 	$s1, val2 # Load test val into  $s0
	sub 	$t0, $s0, $s1 # Test 6087014 - 16447803 = -10360787 (0xFF61E82D)
	sub 	$t1, $s1, $s0 # Test 16447803 - 6087014 = 10360789 (0x009E17D5)
	halt 
