# This test is for testing that you get an exception form loading from
# not half word alligned memory address.
.data
.text
.globl main
main:

lhu $8, 0x10010001($zero) #this should throw exception not halfword alligned

#exit
halt