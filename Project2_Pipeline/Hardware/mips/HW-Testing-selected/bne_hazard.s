        # BNE_NOTTAKEN_FIXED.s
        .data
result: .word 0

        .text
        .globl main
main:
    # Start Test: BNE not‑taken → delay slot executes
    la    $1, result           # load address of result into $1
    addi  $t0, $zero, 5        # $t0 = 5
    addi  $t1, $zero, 5        # $t1 = 5
    bne   $t0, $t1, Skip       # 5 == 5 → not taken, no flush
    addi  $t2, $zero, 17       # delay slot: should execute
    sw    $t3, 0($1)           # store 17 into result
Skip:
    # End Test

    halt                       # exit

