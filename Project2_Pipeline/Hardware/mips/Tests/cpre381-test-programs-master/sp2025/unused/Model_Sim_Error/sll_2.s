.data
newline: .asciiz "\n"

.text
.globl main

main:
    # Load a larger number and shift left
    li $t0, 1024      
    sll $t1, $t0, 4    
    li $v0, 1          
    move $a0, $t1
    syscall
    li $v0, 4          
    la $a0, newline    
    syscall            

    # Exit
    li $v0, 10         
    syscall
