        # CTRL4_BNEnTaken.s
        .data
                 
        .text
        .globl main
main:
    # Start Test: BNE not‑taken should not flush
    addi    $t1, $zero, 8       # $t1 = 8
    addi    $t2, $zero, 8       # $t2 = 8
    bne     $t1, $t2, Skip      # equal → not taken, IF/ID should not flush
    addi    $t3, $zero, 4       # executed in delay slot
Skip:
    halt                        # exit

