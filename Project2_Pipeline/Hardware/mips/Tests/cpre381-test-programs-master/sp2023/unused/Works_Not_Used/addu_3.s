.data
.text
.globl main
# addu test 2
main:
    #Initialize registers using addi for unsigned addition
    addi $1 $zero 0x00000002

    #test for addition of unsigned numbers
    addu $2 $1 $1 #expected output is 4
    addu $3 $2 $2 #expected output is 8
    addu $4 $3 $3 #expected output is 16
    addu $5 $4 $4 #expected output is 32
    addu $6 $5 $1 #expected output is 34

    #End Test
    halt
