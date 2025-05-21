# addiu_ryanchin_1.s
# Test Case 1: Basic Addition
# This test checks if addiu correctly adds small positive numbers.
# Assuming instructions above addiu on the list (lui, addi) are tested correctly

.text
.globl main
main:
    lui $t0, 0         # Load upper 16 bits with 0 (clears $t0)
    addi $t0, $t0, 5   # Set $t0 = 5 using addi

    addiu $t1, $t0, 10 # $t1 = $t0 + 10 (expected 15), check if correctly adds small positive numbers.
    
    addiu $t2, $t0, 6  # $t1 = $t0 + 6 (expected 11), check if correctly adds small positive numbers.

    # Halt
    addi $v0, $zero, 10
    syscall
