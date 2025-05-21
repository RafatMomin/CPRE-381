.data
newline: .asciiz "\n"

.text
.globl main

main:
    li $t0, 1          
    sll $t2, $t0, 31   
    li $v0, 1          
    move $a0, $t2      
    syscall
    li $v0, 4          
    la $a0, newline    
    syscall            

    # Exit
    li $v0, 10         
    syscall
