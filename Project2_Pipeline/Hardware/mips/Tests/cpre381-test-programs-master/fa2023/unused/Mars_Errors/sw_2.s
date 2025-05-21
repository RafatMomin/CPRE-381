.data
.text
.globl main
main:
    # Start Test
    ori $1, 0x4567    # Load common value into register 1
    lui $1, 0x0123    # Load common value into register 1 (top half)

    sw $5, 0($1)      # store value in register to $1
    sw $6, 0($1)      # store value in register to $1  
    sw $7, 0($1)      # store value in register to $1  
    sw $8, 4($1)      # store value in register to $1 
    sw $9, 4($1)      # store value in register to $1 
    sw $10, 4($1)     # store value in register to $1 

    # End Test

    # Exit program
    halt
