.data
.text
.globl main
main:

# Get 0xFFFF_FFFF in $20
lui $20, 0xFFFF
addi $20, $20, 0x7FFF
addi $20, $20, 0x7FFF
addi $20, $20, 0x0001

addi $21, $20, 0	# 0xFFFF_FFFF + 0, should be 0xFFFF_FFFF
addi $22, $20, 1	# 0xFFFF_FFFF + 1, should be 0
addi $23, $20, 2	# 0xFFFF_FFFF + 2, should be 1

# Basic Addition
addi $24, $zero, 1337
addi $25, $24, 1337	# $25 = 1337 + 1337 = 2674

halt
