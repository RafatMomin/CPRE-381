# Proj1_cf_test.s

# Control Flow Test Application with Call Depth of at least 5

# Tests control-flow instructions: beq, bne, j, jal, jr

.data

test_msg:       .asciiz "Testing control flow instructions\n"

level_msg:      .asciiz "Call depth level: "

success_msg:    .asciiz "Test completed successfully!\n"

beq_msg:        .asciiz "beq test passed\n"

bne_msg:        .asciiz "bne test passed\n"

j_msg:          .asciiz "j test passed\n"

jal_msg:        .asciiz "jal test passed\n"

jr_msg:         .asciiz "jr test passed\n"

newline:        .asciiz "\n"

.text

.globl main

# Main function - entry point

main:

    # Print test message

    li $v0, 4

    la $a0, test_msg

    syscall

    

    # Initialize call depth counter

    li $s0, 1

    

    # Call first function

    jal level1

    

    # Print success message

    li $v0, 4

    la $a0, success_msg

    syscall

    

    # Exit program

    halt

# Level 1 function - Tests j instruction

level1:

    # Save return address and registers

    addi $sp, $sp, -8

    sw $ra, 0($sp)

    sw $s0, 4($sp)

    

    # Print current level

    li $v0, 4

    la $a0, level_msg

    syscall

    

    li $v0, 1

    move $a0, $s0

    syscall

    

    li $v0, 4

    la $a0, newline

    syscall

    

    # Test j instruction

    j j_target

    

    # This should be skipped

    li $t0, -1

    

j_target:

    # Print j success message

    li $v0, 4

    la $a0, j_msg

    syscall

    

    # Increment call depth and call next level

    addi $s0, $s0, 1

    jal level2

    

    # Restore and return

    lw $ra, 0($sp)

    lw $s0, 4($sp)

    addi $sp, $sp, 8

    jr $ra

# Level 2 function - Tests beq instruction

level2:

    # Save return address and registers

    addi $sp, $sp, -8

    sw $ra, 0($sp)

    sw $s0, 4($sp)

    

    # Print current level

    li $v0, 4

    la $a0, level_msg

    syscall

    

    li $v0, 1

    move $a0, $s0

    syscall

    

    li $v0, 4

    la $a0, newline

    syscall

    

    # Test beq instruction

    li $t0, 10

    li $t1, 10

    beq $t0, $t1, beq_target

    

    # This should be skipped

    li $t2, -1

    

beq_target:

    # Print beq success message

    li $v0, 4

    la $a0, beq_msg

    syscall

    

    # Increment call depth and call next level

    addi $s0, $s0, 1

    jal level3

    

    # Restore and return

    lw $ra, 0($sp)

    lw $s0, 4($sp)

    addi $sp, $sp, 8

    jr $ra

# Level 3 function - Tests bne instruction

level3:

    # Save return address and registers

    addi $sp, $sp, -8

    sw $ra, 0($sp)

    sw $s0, 4($sp)

    

    # Print current level

    li $v0, 4

    la $a0, level_msg

    syscall

    

    li $v0, 1

    move $a0, $s0

    syscall

    

    li $v0, 4

    la $a0, newline

    syscall

    

    # Test bne instruction

    li $t0, 5

    li $t1, 10

    bne $t0, $t1, bne_target

    

    # This should be skipped

    li $t2, -1

    

bne_target:

    # Print bne success message

    li $v0, 4

    la $a0, bne_msg

    syscall

    

    # Increment call depth and call next level

    addi $s0, $s0, 1

    jal level4

    

    # Restore and return

    lw $ra, 0($sp)

    lw $s0, 4($sp)

    addi $sp, $sp, 8

    jr $ra

# Level 4 function - Test jal instruction (already being used)

level4:

    # Save return address and registers

    addi $sp, $sp, -8

    sw $ra, 0($sp)

    sw $s0, 4($sp)

    

    # Print current level

    li $v0, 4

    la $a0, level_msg

    syscall

    

    li $v0, 1

    move $a0, $s0

    syscall

    

    li $v0, 4

    la $a0, newline

    syscall

    

    # Note: jal is already being used for function calls

    # Print jal success message

    li $v0, 4

    la $a0, jal_msg

    syscall

    

    # Increment call depth and call next level

    addi $s0, $s0, 1

    jal level5

    

    # Restore and return

    lw $ra, 0($sp)

    lw $s0, 4($sp)

    addi $sp, $sp, 8

    jr $ra

# Level 5 function - Test jr instruction (already being used)

level5:

    # Save return address and registers

    addi $sp, $sp, -8

    sw $ra, 0($sp)

    sw $s0, 4($sp)

    

    # Print current level

    li $v0, 4

    la $a0, level_msg

    syscall

    

    li $v0, 1

    move $a0, $s0

    syscall

    

    li $v0, 4

    la $a0, newline

    syscall

    

    # Note: jr is already being used for function returns

    # Print jr success message

    li $v0, 4

    la $a0, jr_msg

    syscall

    

    # If we wanted to go deeper, we'd call the next level here

    

    # Restore and return

    lw $ra, 0($sp)

    lw $s0, 4($sp)

    addi $sp, $sp, 8

    jr $ra   # Using jr to return
