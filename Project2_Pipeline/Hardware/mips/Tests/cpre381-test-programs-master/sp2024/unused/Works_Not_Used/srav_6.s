#Stress test file 1 for the (srav) "shift right arithmetic variable" instruction
# Shift R-Type Instruction (only uses two registers but needs the shamt field, thererfore is R-type)
#
# This particular file checks that sign extension is functioning properly without compromising any normal behavior
# Sign extension is a super important thing to test as not having sign extension working correctly can cause
# particularly hard to track down errors (it compiles, it runs, everything is in the right place, but still does not work)
#
# Instructions addi, lui, and sub are needed to load values to be shifted, and to create registers to compare to/act upon 
.data
.text
.globl main

main:

    # Begin Test
# sign extension 1s
    lui $t0, 0xFFFF # t0 = 0xFFFF0000
    lui $t1, 0xFFFF # t1 = 0xFFFF0000
    ori $t1, $0, 0xFFFF # $t1 = 0xFFFFFFFF
    addi $t2, $0, 27 # t2 = 0x0000001B
    
    # shift by 0 (nothing should change between $t0 and $s1)
    srav $s1, $t0, $0 # s1 = 0xFFFF0000
    sub $s1, $s1, $t0 # s1 = 0x00000000
    
    srav $s1, $t0, $t2 # s1 = 0xFFFFFFFF
    sub $s1, $s1, $t1 # s1 = 0x00000000
    
# sign extension 0s 
    lui $t0, 0x7FFF # t0 = 0x7FFF0000
    addi $t1, $0, 0x7FFF # t1 = 0x00007FFF
    addi $t2, $0, 16 # t2 = 0x00000010
    
    srav $s1, $t0, $t2 # s1 = 0x00007FFF
    sub $s1, $s1, $t0 # s1 = 0x00000000
    
    # End Test
   
    # Exit program
    halt
