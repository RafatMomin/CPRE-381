.data
.text
.globl main
main:
	#Start Tests for special cases of registers also being used as comparators, not writable.
	addi $5, $0, 5
	slt $0, $0, $5   #should not be able to write 1 to $0
	slt $2, $5, $5   #should write 0 for an exact value case (same register)
	slt $2, $2, $5   #should write 1 to a register that's also a comparator
	slt $2, $5, $2   #should write 0 to a register that's also a comparator
	slt $5, $5, $5,  #should write 0 to a register that's both comparators
	#End Test
    	# Exit program
    	halt
