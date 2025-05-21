# This test is for testing that you get an exception form loading from
# not half word alligned memory address.
.data
.text
.globl main
main:

# This should give an exception because it isn't half word alligned
lhu $8, 0x10010003($zero) 

#exit
halt