# TC5: Positive Overflow
# Tests edge case of a positive overflow (Negative overflowing to positive value)

.data
	val1: .word 0x80000000
	val2:	.word 0x1
.text
.globl main
main:
	lw 	$s0, val1
	lw 	$s1, val2
	sub	$t0, $s0, $s1 # 0x80000000 - 0x1 = 1 will trigger overflow
	halt 
