.data
.text
.globl main
main:
    addi $1, $0, -32768 # test lower bound of immediate field
    addi $2, $1, 0      # add 0 to result to verify is correct
    addi $3, $1, 1      # add positive value to verify overflow doesn't occur
    addi $4, $0, 0      # add 0 to register to verify that can be cleared
halt
