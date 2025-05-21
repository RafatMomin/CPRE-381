.data
.text
.globl main
main:
# This test is edge to see if you can jr to the last  locaiton in instruction memory
## What is expected to happen is that 
##Runs as expecteted until jr $20, which hold 0x004fffffc which should be the hold the instruciton of halt


    # Start Test

   
    lui $20, 0x004f #loads 0x01000 0000 into register
    addi $20,$20,0xfffc
    jr $20 #Jump to the initial program memory location
    # End Test


    
.text 0x4ffffc
    halt
    
       # Exit program