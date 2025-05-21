.data
  
.text
.globl main
main:
    addi $1, $0, 2147483647   # set register to max value
    addi $2, $0, 1           # add 1 to immediate value
    addi $3, $1, $2          # this should trigger overflow
    addi $4, $0, 0           # add 0 to register to verify that can be cleared
halt
