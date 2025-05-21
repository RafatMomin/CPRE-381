.data
operand1: .word 5
operand2: .word 10
result: .word 0

.text
.globl main
main:
    # Load operands into registers
    lw $t0, operand1
    lw $t1, operand2
    
    # Subtract operand2 from operand1
    sub $s0, $t0, $t1

    # Store result in memory
    sw $s0, result

    # Exit program
    halt

