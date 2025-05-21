# Proj1_base_test.s

# A comprehensive test of all required MIPS arithmetic and logical instructions

# Tests: add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or,

# ori, slt, slti, sll, srl, sra, sw, sub, subu, lb, lh, lbu, lhu, sllv, srlv, srav

.data

# Data section for test values

test_word:      .word   0x12345678, 0xABCDEF01      # Test words

test_bytes:     .byte   0x11, 0x22, 0x33, 0x44      # Test bytes

test_half:      .half   0x5566, 0x7788              # Test halfwords

result_msg:     .asciiz "Test completed. Results in registers $t0-$t9\n"

.text

.globl main

main:

    # Print starting address (useful for debugging)

    li      $v0, 1

    la      $a0, main

    syscall

    

    # Load addresses for test data

    la      $s0, test_word

    la      $s1, test_bytes

    la      $s2, test_half

    

    # ---------- Test arithmetic instructions ----------

    

    # Test add - Add two registers

    li      $t0, 100

    li      $t1, 200

    add     $t2, $t0, $t1       # $t2 = 100 + 200 = 300

    

    # Test addi - Add immediate value

    addi    $t3, $t2, 50        # $t3 = 300 + 50 = 350

    

    # Test addiu - Add immediate unsigned

    addiu   $t4, $t3, 100       # $t4 = 350 + 100 = 450

    

    # Test addu - Add unsigned

    addu    $t5, $t4, $t0       # $t5 = 450 + 100 = 550

    

    # Test sub - Subtract

    sub     $t6, $t5, $t0       # $t6 = 550 - 100 = 450

    

    # Test subu - Subtract unsigned

    subu    $t7, $t6, $t1       # $t7 = 450 - 200 = 250

    

    # ---------- Test logical instructions ----------

    

    # Test and - Bitwise AND

    li      $t0, 0x0F0F         # $t0 = 0000 1111 0000 1111

    li      $t1, 0xFF00         # $t1 = 1111 1111 0000 0000

    and     $t2, $t0, $t1       # $t2 = 0000 1111 0000 0000 = 0x0F00

    

    # Test andi - Bitwise AND immediate

    andi    $t3, $t0, 0x00FF    # $t3 = 0000 0000 0000 1111 = 0x000F

    

    # Test or - Bitwise OR

    or      $t4, $t0, $t1       # $t4 = 1111 1111 0000 1111 = 0xFF0F

    

    # Test ori - Bitwise OR immediate

    ori     $t5, $t0, 0xFF00    # $t5 = 1111 1111 0000 1111 = 0xFF0F

    

    # Test xor - Bitwise XOR

    xor     $t6, $t0, $t1       # $t6 = 1111 0000 0000 1111 = 0xF00F

    

    # Test xori - Bitwise XOR immediate

    xori    $t7, $t0, 0xFF00    # $t7 = 1111 0000 0000 1111 = 0xF00F

    

    # Test nor - Bitwise NOR

    nor     $t8, $t0, $t1       # $t8 = ~(0x0F0F | 0xFF00) = ~0xFF0F = 0x00F0

    

    # ---------- Test shift instructions ----------

    

    # Test sll - Shift left logical

    li      $t0, 0x00000001

    sll     $t1, $t0, 3         # $t1 = 0x00000001 << 3 = 0x00000008

    

    # Test srl - Shift right logical

    li      $t2, 0x80000000

    srl     $t3, $t2, 4         # $t3 = 0x80000000 >> 4 = 0x08000000

    

    # Test sra - Shift right arithmetic

    li      $t4, 0x80000000     # Most significant bit is 1

    sra     $t5, $t4, 4         # $t5 = 0x80000000 >> 4 (arithmetic) = 0xF8000000

    

    # Test sllv - Shift left logical variable

    li      $t0, 0x00000001

    li      $t1, 5

    sllv    $t2, $t0, $t1       # $t2 = 0x00000001 << 5 = 0x00000020

    

    # Test srlv - Shift right logical variable

    li      $t3, 0x80000000

    li      $t4, 3

    srlv    $t5, $t3, $t4       # $t5 = 0x80000000 >> 3 = 0x10000000

    

    # Test srav - Shift right arithmetic variable

    li      $t6, 0x80000000

    li      $t7, 2

    srav    $t8, $t6, $t7       # $t8 = 0x80000000 >> 2 (arithmetic) = 0xE0000000

    

    # ---------- Test comparison instructions ----------

    

    # Test slt - Set if less than

    li      $t0, 10

    li      $t1, 20

    slt     $t2, $t0, $t1       # $t2 = (10 < 20) ? 1 : 0 = 1

    

    # Test slti - Set if less than immediate

    slti    $t3, $t0, 5         # $t3 = (10 < 5) ? 1 : 0 = 0

    

    # ---------- Test memory instructions ----------

    

    # Test lui - Load upper immediate

    lui     $t0, 0x1234         # $t0 = 0x12340000

    

    # Test lw - Load word

    lw      $t1, 0($s0)         # $t1 = 0x12345678

    

    # Test lb - Load byte

    lb      $t2, 0($s1)         # $t2 = 0x00000011 (sign extended)

    lb      $t3, 1($s1)         # $t3 = 0x00000022 (sign extended)

    

    # Test lbu - Load byte unsigned

    lbu     $t4, 2($s1)         # $t4 = 0x00000033 (zero extended)

    

    # Test lh - Load halfword

    lh      $t5, 0($s2)         # $t5 = 0x00005566 (sign extended)

    

    # Test lhu - Load halfword unsigned

    lhu     $t6, 2($s2)         # $t6 = 0x00007788 (zero extended)

    

    # Test sw - Store word

    li      $t7, 0xDEADBEEF

    sw      $t7, 4($s0)         # Store 0xDEADBEEF at test_word[1]

    

    # Load it back to verify

    lw      $t8, 4($s0)         # $t8 should be 0xDEADBEEF

    

    # ---------- Final verification ----------

    # Now we'll do a sequence of dependent operations to verify

    # that data dependencies are properly handled

    

    li      $t0, 1              # Initialize t0 = 1

    add     $t0, $t0, $t0       # t0 = 1 + 1 = 2

    add     $t0, $t0, $t0       # t0 = 2 + 2 = 4

    add     $t0, $t0, $t0       # t0 = 4 + 4 = 8

    add     $t0, $t0, $t0       # t0 = 8 + 8 = 16

    add     $t0, $t0, $t0       # t0 = 16 + 16 = 32

    

    # Print completion message

    li      $v0, 4

    la      $a0, result_msg

    syscall

    

    # Exit program

    halt
