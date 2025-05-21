.data
.text
.globl main
main:
	#Start Test
	li $t1, 0x10000001
	li $t0, 0x1111ff11
	sw $t0, 0x10000000($zero)
	lbu $t2, 0($t1)
    	# End Test



    	# Exit program
halt