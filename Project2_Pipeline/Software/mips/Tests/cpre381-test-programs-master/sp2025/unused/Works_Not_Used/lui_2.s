.data
.text
.globl main
main:


lui $t0, 0xFFFF   # Expect $t0 = 0xFFFF0000
addi $t0, $t0, 0x1234   # Expect $t0 = 0xFFFF1234

addi $t1, $t1, 0x1234   # Expect $t1 = 0x00001234
lui $t1, 0xFFFF   # Expect $t1 = 0xFFFF0000


#Common case of lui, ensure 16 bit immediate is placed in upper sixteen bits, and bottom sixteen bits can be set by addi. Test what happens when lower bits are already set.

halt
