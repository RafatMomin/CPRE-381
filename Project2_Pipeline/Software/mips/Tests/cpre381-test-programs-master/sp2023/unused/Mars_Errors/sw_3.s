#MIPS store word unit test #1
#Created by: Anthony Manschula 3-1-23
#This test aims to test range of addresses contained within the memory component

.data
.text
.globl main

#Start by loading some data into registers
main:
addiu $t0, $0, 4660	#TAFIX 0x1234
addiu $t1, $0, 39612	#TAFIX 0x9ABC
addiu $t2, $0, 258	#TAFIX 0x0102
addiu $t3, $0, 1286	#TAFIX 0x0506

#Address of memory location we want to store at --> 0d508 (1024 mem locations total)
addiu $t9, $0, 504 #TAFIX 0x1F8

#Write to the middle of memory, as well as both extremes.
#I don't think it's necessary to include every address. Aside from being excessively lengthy, if both extremes of the memory work fine,
#then it can be reasonably inferred that the rest of the memory component will function as expected.
sw $t0, 0($t9)
addiu $t9, $t9, 4
sw $t1, 0($t9)
addiu $t9, $t9, 4
sw $t2, 0($t9)
addiu $t9, $t9, 4
sw $t3, 0($t9)
addiu $t9, $t9, 4

#Address 0x0
and $t9, $t9, $0
sw $t0, 0($t9)
addiu $t9, $t9, 4
sw $t1, 0($t9)
addiu $t9, $t9, 4
sw $t2, 0($t9)
addiu $t9, $t9, 4
sw $t3, 0($t9)
addiu $t9, $t9, 4

#End of memory 0x3F0-0x3FF
addiu $t9, $t9, 1008 #TAFIX 0x3F0
addiu $t9, $t9, -512
sw $t0, 0($t9)
addiu $t9, $t9, 4
sw $t1, 0($t9)
addiu $t9, $t9, 4
sw $t2, 0($t9)
addiu $t9, $t9, 4
sw $t3, 0($t9)
addiu $t9, $t9, 4

halt
