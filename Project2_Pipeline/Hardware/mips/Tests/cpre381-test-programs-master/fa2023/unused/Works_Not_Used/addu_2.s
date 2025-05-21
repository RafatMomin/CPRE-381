.data
.text
.globl main
# addu test 3
main:
    #Initialize registers using addi for unsigned addition
    addi $1 $zero 0x00000002
    addi $2 $zero 0x00000001

    #test for addition of unsigned numbers to see if we can add to the zero register 
    addu $3 $zero $1 #expected output is 2
    addu $4 $zero $2 #expected output is 2
    addu $5 $3 $4 #expected output is 4
    addu $zero $zero $5 #expected output is 0, can't add towards the $zero

    #End Test
    halt
