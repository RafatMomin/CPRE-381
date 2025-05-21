# TC6: Negative Overflow
# Tests edge case of a negative overflow (Positive overflowing to negative value)

.data
	val1: .word 0x7FFFFFFF
	val2:	.word 0xFFFFFFFF
.text
.globl main
main:
	lw 	$s0, val1
	lw 	$s1, val2
	sub	$t0, $s0, $s1 # 0x7FFFFFFF - 0xFFFFFFFF = -1 should trigger overflow
	halt 
