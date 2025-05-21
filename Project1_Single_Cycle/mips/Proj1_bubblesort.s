# Bubble Sort Implementation in MIPS Assembly

# 

# Register usage:

# $a0 - array base address

# $a1 - array size

# $t0 - i counter (outer loop)

# $t1 - j counter (inner loop)

# $t2 - size - i - 1 (inner loop bound)

# $t3 - address of array[j]

# $t4 - value of array[j]

# $t5 - value of array[j+1]

# $t6 - temporary for swap

.data

# Example array for testing

array:  .word   64, 34, 25, 12, 22, 11, 90

size:   .word   7

.text

.globl main

main:

    # Load array address and size

    la      $a0, array        # Load array address

    lw      $a1, size         # Load array size

    

    # Call bubble sort

    jal     bubbleSort

    

    # Exit program

    halt

# bubbleSort(int array[], int size)

# $a0 - array address

# $a1 - array size

bubbleSort:

    # Function prologue

    addi    $sp, $sp, -12     # Allocate stack space

    sw      $ra, 0($sp)       # Save return address

    sw      $s0, 4($sp)       # Save $s0

    sw      $s1, 8($sp)       # Save $s1

    

    move    $s0, $a0          # Save array address

    move    $s1, $a1          # Save array size

    

    li      $t0, 0            # i = 0

    

outer_loop:

    # Check outer loop condition: i < size - 1

    addi    $t7, $s1, -1      # $t7 = size - 1

    bge     $t0, $t7, outer_loop_end  # if i >= size - 1, exit loop

    

    li      $t1, 0            # j = 0

    sub     $t2, $t7, $t0     # $t2 = size - 1 - i (inner loop bound)

    

inner_loop:

    # Check inner loop condition: j < size - i - 1

    bge     $t1, $t2, inner_loop_end  # if j >= size - i - 1, exit inner loop

    

    # Calculate address of array[j]

    sll     $t3, $t1, 2       # $t3 = j * 4 (word offset)

    add     $t3, $s0, $t3     # $t3 = address of array[j]

    

    # Load array[j] and array[j+1]

    lw      $t4, 0($t3)       # $t4 = array[j]

    lw      $t5, 4($t3)       # $t5 = array[j+1]

    

    # Compare and swap if needed

    ble     $t4, $t5, no_swap # if array[j] <= array[j+1], no swap needed

    

    # Swap elements

    move    $t6, $t4          # temp = array[j]

    sw      $t5, 0($t3)       # array[j] = array[j+1]

    sw      $t6, 4($t3)       # array[j+1] = temp

    

no_swap:

    # Increment j and continue inner loop

    addi    $t1, $t1, 1       # j++

    j       inner_loop

    

inner_loop_end:

    # Increment i and continue outer loop

    addi    $t0, $t0, 1       # i++

    j       outer_loop

    

outer_loop_end:

    # Function epilogue

    lw      $ra, 0($sp)       # Restore return address

    lw      $s0, 4($sp)       # Restore $s0

    lw      $s1, 8($sp)       # Restore $s1

    addi    $sp, $sp, 12      # Deallocate stack space

    

    jr      $ra               # Return
