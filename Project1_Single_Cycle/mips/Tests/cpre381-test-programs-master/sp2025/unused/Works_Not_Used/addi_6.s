.data
.text
.globl main
main:
	lui $t1, 0x8000
    # Start Test
    	#comment it out for testing 
	addi $t0, $t1, -1 # this will cause overflow to show 1 and for mars it will terminate cause of 32 bit limit on negative int
    # End Test

    # Exit program
    halt
