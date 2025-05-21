.data

.text 

.globl main

			#Tests sra with negative shift amount

main:

			#Start Test
			
	#Check to make sure can sra shift 31 and put back into same register
	
	sra $1, $1, -1		# verify that one can shift reg 1 -1 bits right
	
	sra $4, $4, -1		# verify that one can shift reg 4 -1 bits right
	
	sra $7, $7, -1		# verify that one can shift reg 7 -1 bits right
	
	sra $10, $10, -1	# verify that one can shift reg 10 -1 bits right
	
	sra $14, $14, -1	# verify that one can shift reg 14 -1 bits right
	
	#Check to make sure can sra shfit 31 and put back into different register
	
	sra $12, $11, -1	# reg 11 Shift Right -1 bits ->12

	sra $13, $15, -1	# reg 15 Shift Right -1 bits->13

	sra $25, $24, -1	# reg 24 Shift Right -1 bits->25
	
	sra $20, $23, -1	# reg 23 Shift Right -1 bits->20
	
	
			#End Test
			
	# Exit Program
	
halt