.data
newline: .asciiz "\n"

.text
.globl main

main:
    # Load a small number and shift left
    li $t0, 5          
    sll $t1, $t0, 2    
    
    li $v0, 1          
    move $a0, $t1
    syscall

    # Exit
    li $v0, 10         
    syscall
