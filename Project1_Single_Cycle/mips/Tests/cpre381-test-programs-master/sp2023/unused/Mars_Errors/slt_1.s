.data
.text
.globl main
main:
  
    addi $t1, $0, 2147483647  
    addi $t2, $0, -2147483648 
    slt $t3, $t2, $t1       
    slt $t4, $t1, $t2  
    slt $t5, $t1, $t2      
    slt $t6, $t2, $t2


    halt
