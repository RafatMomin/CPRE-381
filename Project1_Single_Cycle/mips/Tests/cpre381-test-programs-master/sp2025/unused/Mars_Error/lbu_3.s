.data
    .byte 0xA0 0xA1 0xA2 0xA3 0xA4 0xA5 0xA6 0xA7 0xA8 0xA9 0xAA 0xAB 0xAC 0xAD 0xAE 0xAF 0xB0 0xB1 0xB2 0xB3 0xB4 0xB5 0xB6 0xB7 0xB8 0xB9 0xBA 0xBB 0xBC 0xBD 0xBE 0xBF
.text
.globl main

# Test purpose:
# Test immediate offset, both negative and positive.
# NOTE: Values in DMEM may look reversed due to endianness.

main:
    # Start Test
    addiu $1, $0, 4 # Load address of .data into $1
    lbu $2, -2($1) # Load 0x000000A2 into $2
    lbu $3, -1($1) # Load 0x000000A3 into $3
    lbu $4, 0($1) # Load 0x000000A4 into $4
    lbu $5, 1($1) # Load 0x000000A5 into $5
    lbu $6, 2($1) # Load 0x000000A6 into $6
    lbu $7, 3($1) # Load 0x000000A7 into $7
    lbu $8, 4($1) # Load 0x000000A8 into $8
    lbu $9, 5($1) # Load 0x000000A9 into $9
    lbu $10, 6($1) # Load 0x000000AA into $10
    lbu $11, 7($1) # Load 0x000000AB into $11
    lbu $12, 8($1) # Load 0x000000AC into $12
    lbu $13, 9($1) # Load 0x000000AD into $13
    lbu $14, 10($1) # Load 0x000000AE into $14
    lbu $15, 11($1) # Load 0x000000AF into $15
    lbu $16, 12($1) # Load 0x000000B0 into $16
    lbu $17, 13($1) # Load 0x000000B1 into $17
    lbu $18, 14($1) # Load 0x000000B2 into $18
    lbu $19, 15($1) # Load 0x000000B3 into $19
    lbu $20, 16($1) # Load 0x000000B4 into $20
    lbu $21, 17($1) # Load 0x000000B5 into $21
    lbu $22, 18($1) # Load 0x000000B6 into $22
    lbu $23, 19($1) # Load 0x000000B7 into $23
    lbu $24, 20($1) # Load 0x000000B8 into $24
    lbu $25, 21($1) # Load 0x000000B9 into $25
    lbu $26, 22($1) # Load 0x000000BA into $26
    lbu $27, 23($1) # Load 0x000000BB into $27
    lbu $28, 24($1) # Load 0x000000BC into $28
    lbu $29, 25($1) # Load 0x000000BD into $29
    lbu $30, 26($1) # Load 0x000000BE into $30
    lbu $31, 27($1) # Load 0x000000BF into $31
    # End Test

    # Exit program
    halt
