.data
.text
.globl main
main:

addi $t0, $0, -2

addiu $t1, $t0, -2 # test shows subtracting an immediate from reg into a different register. Expected $t1 = -4

halt # end