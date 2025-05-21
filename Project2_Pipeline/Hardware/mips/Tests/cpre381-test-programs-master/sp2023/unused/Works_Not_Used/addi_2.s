.data

.text
.globl main
main:
    addi $1, $0, 32767  # test upper bound of immediate field
    addi $2, $1, 0      # add 0 to result to verify 
    addi $3, $1, -1     # add negative value to verify overflow doesn't occur
    addi $4, $0, 0      # add 0 to register to verify that can be cleared
halt
