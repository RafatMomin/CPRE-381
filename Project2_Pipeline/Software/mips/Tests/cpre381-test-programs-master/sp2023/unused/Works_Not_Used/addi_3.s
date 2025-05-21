.data
.text
.globl main
main:
 	# Start Test
    	addi $2,$0,0			# Clear Register
    	addi $2, $2, 0x7FFF		#Add upper limit
    	addi $2, $2, 1			# Should overflow $2 causing $2 to equal 0 	
    	addi $3,$0,0			#Clear Register
    	addi $3,$3, -0x8000		#Add lower limit
    	addi $3,$3, -1			#Should overflow $3 causing $3 to equal 0
 	# End Test

    # Exit program
halt
