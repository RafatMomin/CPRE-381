# lbu_atryan_test2.s
# This test program focuses on edge cases, 
# specifically loading a byte from the first index of an array.


.data
arr:    .byte   0, 255, 128, 64, 32   # A sample byte array with various values
result: .space  4                     # Space to store the result

    .text
    .globl  main

main:
    # Get the address of array arr
    la $t1, arr
    # Load the byte at index 2 of the array into register $t0
    lbu $t0, 0($t1)

    # Store the result in memory
    sb $t0, result

    # End of program
    li $v0, 10
    syscall
