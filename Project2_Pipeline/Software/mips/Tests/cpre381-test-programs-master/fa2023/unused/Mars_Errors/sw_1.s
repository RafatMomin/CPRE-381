.data
.text
.globl main
main:
    # Start Test
    ori $1, 17767 #0x4567    # Load common value into register 1
    lui $1, 291 #0x0123    # Load common value into register 1 (top half)

    sw $1, 0($2)      # store value in $1
    sw $1, 0($5)      # store value in $1 
    sw $1, 0($6)      # store value in $1
    sw $1, 4($7)      # store value in $1 
    sw $1, 4($12)      # store value in $1 
    sw $1, 4($17)     # store value in $1 

    # End Test

    # Exit program
    halt
