.data
.text
.globl main
main:
	lui $t0, 0x3321
	ori $t0, 0x1241
    # Start Test
 	addi $t1, $t0, 32767 # adding 30000 to a relly large value, general testing with largest positive int result = 0x33219240
    	addi $t2, $t1, -32768 # subsiture the smallest neg value result = 0x33211240
    # End Test

    # Exit program
    halt
