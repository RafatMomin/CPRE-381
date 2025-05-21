addi $t0, $zero, 1
bgez $t0, end

# 10 skipped instructions
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

end:
halt
