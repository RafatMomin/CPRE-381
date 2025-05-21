# addiu_ryanchin_3.s
# Test Case 3: Overflow-Like Behavior
# This test examines how addiu behaves with extreme values.
# Assuming instructions above addiu on the list (lui, addi) are tested correctly

.text
.globl main
main:
 # -----------------------------
    # Test 1: Subtracting 1 from -32768
    # -----------------------------
    # Goal: Check behavior when subtracting from the smallest 16-bit signed value (-32768).
    
    lui $t0, 0x8000       # Load upper bits of -32768 (0x80000000)
    addiu $t1, $t0, -1    # $t1 = -32768 - 1 (check if wraps correctly)
    # Expected result: 0x7FFFFFFF (-32769 in two's complement)

    # -----------------------------
    # Test 2: Adding 1 to the largest 32-bit signed integer (0x7FFFFFFF)
    # -----------------------------
    # Goal: Test if addiu correctly handles adding 1 to the maximum signed integer.
    
    lui $t2, 0x7FFF       # Load upper 16 bits with 0x7FFF
    addi $t2, $t2, 0xFFFF # Now $t2 = 0x7FFFFFFF (Max signed int)
    addiu $t3, $t2, 1     # $t3 = 0x7FFFFFFF + 1
    # Expected result:  0x80000000

    # Halt
    addi $v0, $zero, 10
    syscall