.data
.text
.globl main

# bltz $t0, label
# branch on less than zero - branch to label if $t0 < 0

# verify program does not run when specified label does not exist
main:
addiu $t0, $0, -1 # initialize $t0 to a negative value
bltz $t0, loop # test that the program stops because loop does not exist
addiu $t0, $0, 100 # program should not reach this instruction

exit:
halt # program should not reach the exit