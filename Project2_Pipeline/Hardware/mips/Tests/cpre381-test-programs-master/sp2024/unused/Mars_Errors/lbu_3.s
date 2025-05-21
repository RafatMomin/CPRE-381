# lbu_atryan_test3.s
# This test program checks for overflow and boundary conditions 
# by attempting to load a byte from the last index of an array 
# with maximum unsigned byte values.


.data
arr:    .byte   255, 255, 255, 255, 255  # A sample byte array with maximum unsigned byte values
result: .space  4                         # Space to store the result

    .text
    .globl  main

main:
    # Get the address of array arr
    la $t1, arr 
    # Load the byte at index 4 of the array into register $t0
    lbu $t0, 4($t1)

    # Store the result in memory
    sb $t0, result

    # End of program
    li $v0, 10
    syscall
