.data
result: .asciiz "Output: "
expected: .asciiz "\nThe expected result is -7"
.text

addi $t2, $zero, -99 # $t2 = -99        1110011101
xori $t1, $t2, 100 # $t1 = $t2 xori 100 0001100100
                   # $t1 = -7           1111111001

la $a0, result
li $v0, 4
syscall

li $v0, 1
move $a0, $t1
syscall

la $a0, expected
li $v0, 4
syscall

halt
