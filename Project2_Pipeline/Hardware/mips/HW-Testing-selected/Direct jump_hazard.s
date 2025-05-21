        # CTRL1_J.s
        j       JumpTarget     # unconditional jump
        addi    $t1,$zero,1    # squashed
    JumpTarget:
        addi    $t2,$zero,2
        halt

