.data
.text
.globl main
# addu test 4
main:
    #Initialize registers using addi for unsigned addition
    addi $1 $zero 0x00000002
    

    #test for addition of unsigned numbers to see if every register could be used
    addu $1 $zero $1 #expected output is 2
    addu $2 $zero $1 #expected output is 2
    addu $3 $zero $1 #expected output is 2
    addu $4 $zero $1 #expected output is 2
    addu $5 $zero $1 #expected output is 2
    addu $6 $zero $1 #expected output is 2
    addu $7 $zero $1 #expected output is 2
    addu $8 $zero $1 #expected output is 2
    addu $9 $zero $1 #expected output is 2
    addu $10 $zero $1 #expected output is 2
    addu $11 $zero $1 #expected output is 2
    addu $12 $zero $1 #expected output is 2
    addu $13 $zero $1 #expected output is 2
    addu $14 $zero $1 #expected output is 2
    addu $15 $zero $1 #expected output is 2
    addu $16 $zero $1 #expected output is 2
    addu $17 $zero $1 #expected output is 2
    addu $18 $zero $1 #expected output is 2
    addu $19 $zero $1 #expected output is 2
    addu $20 $zero $1 #expected output is 2
    addu $21 $zero $1 #expected output is 2
    addu $22 $zero $1 #expected output is 2
    addu $23 $zero $1 #expected output is 2
    addu $24 $zero $1 #expected output is 2
    addu $25 $zero $1 #expected output is 2
    addu $26 $zero $1 #expected output is 2
    addu $27 $zero $1 #expected output is 2
    addu $28 $zero $1 #expected output is 2
    addu $29 $zero $1 #expected output is 2
    addu $30 $zero $1 #expected output is 2
    addu $31 $zero $1 #expected output is 2
    
   
    #End Test
    halt
