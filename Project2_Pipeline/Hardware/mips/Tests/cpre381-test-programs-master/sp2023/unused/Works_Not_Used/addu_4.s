.data
.text
.globl main
# addu test 1
main:
    #Initialize registers using addi for unsigned addition
    addi $1 $zero 0xFFFFFFFF
    addi $2 $zero 0x00000002

    #test for overflow of unsigned numbers
    addu $3 $1 $2 #output is 0x00000001 no overflow happens since its unsigned, it just wraps around
    addu $4 $1 $3 #output is 0x00000000 no overflow happens since its unsigned, it just wraps around

    #End Test
    halt
