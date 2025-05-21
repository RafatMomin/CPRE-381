.data
	test_data: .byte 0x14 # store 0x14 in memory
.text
.globl main
main:
    # Start Test
    lui $t0, 0x1001 # $t0 = 0x10010000
    lb $t1, 0($t0) # Load byte 1 from memory assuming test_data is at 0x10010000
    
    # Expected outcome: $t1 = 0x14
    
    # This test is made specifically for
    # testing simple execution of the lb command
    # making sure it only loads one byte into
    # the appropriate register and does not
    # sign extend
