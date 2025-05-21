# addiu_ryanchin_2.s
# Test Case 2: Edge Cases - Zero, Negatives, and Large Immediate
# This test checks how addiu handles zero addition, negative numbers, and large immediate values.
# Assuming instructions above addiu on the list (lui, addi) are tested correctly

.text
.globl main
main:
    lui $t0, 0         # Load upper 16 bits with 0
    addi $t0, $t0, 0   # Initialize $t0 = 0
    addiu $t1, $t0, 0  # $t1 = $t0 + 0 (expected 0), check if handles zero addition

    lui $t2, 0         # Clear $t2
    addi $t2, $t2, -10 # Set $t2 = -10 using addi
    addiu $t3, $t2, 5  # $t3 = -10 + 5 (expected -5), check if handles negative numbers

    lui $t4, 0         # Clear $t4
    addi $t4, $t4, 32767 # Set $t4 = 32767
    addiu $t5, $t4, 1  # $t5 = 32767 + 1 (expected 32768), check if handles large immediate values

    # Halt
    addi $v0, $zero, 10
    syscall