.data
    .byte 0x7F 0x80
.text
.globl main

# !!! Test purpose:
# Test boundary conditions and zero-extension:
# 127 and 128 should both be 0-extended

main:
    # Start Test
    addiu $1, $0, 0 # Load address of .data into $1
    lbu $2, 0($1) # Load 0x0000007F into $2
    lbu $3, 1($1) # Load 0x00000080 into $3
    lbu $4, 0($1) # Load 0x0000007F into $4
    lbu $5, 1($1) # Load 0x00000080 into $5
    lbu $6, 0($1) # Load 0x0000007F into $6
    lbu $7, 1($1) # Load 0x00000080 into $7
    lbu $8, 0($1) # Load 0x0000007F into $8
    lbu $9, 1($1) # Load 0x00000080 into $9
    lbu $10, 0($1) # Load 0x0000007F into $10
    lbu $11, 1($1) # Load 0x00000080 into $11
    lbu $12, 0($1) # Load 0x0000007F into $12
    lbu $13, 1($1) # Load 0x00000080 into $13
    lbu $14, 0($1) # Load 0x0000007F into $14
    lbu $15, 1($1) # Load 0x00000080 into $15
    lbu $16, 0($1) # Load 0x0000007F into $16
    lbu $17, 1($1) # Load 0x00000080 into $17
    lbu $18, 0($1) # Load 0x0000007F into $18
    lbu $19, 1($1) # Load 0x00000080 into $19
    lbu $20, 0($1) # Load 0x0000007F into $20
    lbu $21, 1($1) # Load 0x00000080 into $21
    lbu $22, 0($1) # Load 0x0000007F into $22
    lbu $23, 1($1) # Load 0x00000080 into $23
    lbu $24, 0($1) # Load 0x0000007F into $24
    lbu $25, 1($1) # Load 0x00000080 into $25
    lbu $26, 0($1) # Load 0x0000007F into $26
    lbu $27, 1($1) # Load 0x00000080 into $27
    lbu $28, 0($1) # Load 0x0000007F into $28
    lbu $29, 1($1) # Load 0x00000080 into $29
    lbu $30, 0($1) # Load 0x0000007F into $30
    lbu $31, 1($1) # Load 0x00000080 into $31
    # End Test

    # Exit program
    halt
