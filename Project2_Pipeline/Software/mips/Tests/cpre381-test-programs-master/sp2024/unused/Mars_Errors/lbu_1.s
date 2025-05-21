# lbu_atryan_test1.s
# This test program verifies the basic functionality of the "lbu" instruction 
# by loading a byte from a specified index of an array and storing it in a register.

    .data
arr:    .byte   255, 0, 128, 64, 32  # A sample byte array
result: .space  4                     # Space to store the result

    .text
    .globl  main

main:
    # Get the address of array arr
    la $t1, arr
    # Load the byte at index 2 of the array into register $t0
    lbu $t0, 2($t1)

    # Store the result in memory
    sb $t0, result

    # End of program
    li $v0, 10
    syscall
