.data
    .byte 0x10
.text
.globl main

# !!! Test purpose:
# Test regular positive numbers (basic functionality)
# on each register: 16

main:
    # Start Test
    addiu $1, $0, 0 # Load address of .data into $1
    lbu $2, 0($1) # Load 0x00000010 into $2
    lbu $3, 0($1) # Load 0x00000010 into $3
    lbu $4, 0($1) # Load 0x00000010 into $4
    lbu $5, 0($1) # Load 0x00000010 into $5
    lbu $6, 0($1) # Load 0x00000010 into $6
    lbu $7, 0($1) # Load 0x00000010 into $7
    lbu $8, 0($1) # Load 0x00000010 into $8
    lbu $9, 0($1) # Load 0x00000010 into $9
    lbu $10, 0($1) # Load 0x00000010 into $10
    lbu $11, 0($1) # Load 0x00000010 into $11
    lbu $12, 0($1) # Load 0x00000010 into $12
    lbu $13, 0($1) # Load 0x00000010 into $13
    lbu $14, 0($1) # Load 0x00000010 into $14
    lbu $15, 0($1) # Load 0x00000010 into $15
    lbu $16, 0($1) # Load 0x00000010 into $16
    lbu $17, 0($1) # Load 0x00000010 into $17
    lbu $18, 0($1) # Load 0x00000010 into $18
    lbu $19, 0($1) # Load 0x00000010 into $19
    lbu $20, 0($1) # Load 0x00000010 into $20
    lbu $21, 0($1) # Load 0x00000010 into $21
    lbu $22, 0($1) # Load 0x00000010 into $22
    lbu $23, 0($1) # Load 0x00000010 into $23
    lbu $24, 0($1) # Load 0x00000010 into $24
    lbu $25, 0($1) # Load 0x00000010 into $25
    lbu $26, 0($1) # Load 0x00000010 into $26
    lbu $27, 0($1) # Load 0x00000010 into $27
    lbu $28, 0($1) # Load 0x00000010 into $28
    lbu $29, 0($1) # Load 0x00000010 into $29
    lbu $30, 0($1) # Load 0x00000010 into $30
    lbu $31, 0($1) # Load 0x00000010 into $31
    # End Test

    # Exit program
    halt
