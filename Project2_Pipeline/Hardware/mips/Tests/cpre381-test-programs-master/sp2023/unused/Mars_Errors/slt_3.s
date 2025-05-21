data
.text
.globl main
main:

 
addi $1, $0, 0            
    addi $2, $0, -2147483648  
    slt $3, $1, $2           
    slt $4, $2, $1           
    slt $5, $1, $1            
    slt $6, $2, $2            

    halt