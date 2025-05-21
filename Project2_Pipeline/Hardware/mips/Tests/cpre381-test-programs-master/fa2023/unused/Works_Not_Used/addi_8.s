.data
.text
.globl main
main:
 	# Start Test
    	addi $0,$0,2			# Check that the zero register can't be changed
    	addi $1,$0,0			# Clear $1
	addi $1,$1,0xff		# $1 = 255 (Check basic functionality of addi, straight addition)
	addi $1,$1,-240		# $1 = 15  (Check basic functionality of addi, subtraction)
 	# End Test

    # Exit program
    halt
