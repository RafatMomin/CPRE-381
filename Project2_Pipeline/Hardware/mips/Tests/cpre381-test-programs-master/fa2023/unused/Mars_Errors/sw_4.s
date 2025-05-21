#MIPS store word unit test #2
#Created by: Anthony Manschula 3-1-23
#This test aims to test the ability of the processor to accept base address offsets when doing store word

.data
.text
.globl main

#Start by loading some data into registers
main:
addiu $t0, $0, 0x1234
addiu $t1, $0, 0x9ABC
addiu $t2, $0, 0x0102
addiu $t3, $0, 0x0506

#Same idea as the last test, but using offsets instead of modifying the base address
#Address 0x0
sw $t0, 0($0)
sw $t1, 4($0)
sw $t2, 8($0)
sw $t3, 12($0)

#Middle of range
sw $t0, 504($0)
sw $t1, 508($0)
sw $t2, 512($0)
sw $t3, 516($0)


#End of memory 0x3FB-0x3FF
#Use a negative offset
#This portion also tests the sign-extender module
addiu $t9, $0, 0x204
sw $t0, -4($t9)
sw $t1, -8($t9)
sw $t2, -12($t9)
sw $t3, -16($t9)

halt