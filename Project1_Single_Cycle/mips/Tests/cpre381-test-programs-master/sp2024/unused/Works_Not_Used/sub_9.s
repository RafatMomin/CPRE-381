#TC3: Subtracting Positive and Negative Numbers
# Tests common case of subtracting a postive number from a negative number (and visa-versa)

.data
	val1: .word 6087014	# 0x005CE166
	val2:	.word -16447803	# 0x00FAF93B
	
.text

.globl main
main:
	lw 	$s0, val1 # Load test val1 into $s0
	lw 	$s1, val2 # Load test val into  $s0
	sub 	$t0, $s0, $s1 # Test 6087014 - (-16447803) = 22534817 (0x0157DAA1)
	sub 	$t1, $s1, $s0 # Test -16447803 - 6087014 = -22534817 (0xFEA8255F)
	halt 
