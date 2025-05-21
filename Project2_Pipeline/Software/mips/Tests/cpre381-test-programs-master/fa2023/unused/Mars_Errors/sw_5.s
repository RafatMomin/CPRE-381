#MIPS store word unit test #3
#Created by: Anthony Manschula 3-1-23
#This test aims to test the ability of the processor to accept consecutive writes to the same address

.data
.text
.globl main

#Start by loading some data into registers
main:
addiu $t0, $0, 0x1234
addiu $t1, $0, 0x9ABC
addiu $t2, $0, 0x0102
addiu $t3, $0, 0x0506

#Choose a random address to start with. End result should be t0 having 0x0506
sw $t0, 768($0)
sw $t1, 760($0)
sw $t2, 760($0)
sw $t3, 760($0)

halt