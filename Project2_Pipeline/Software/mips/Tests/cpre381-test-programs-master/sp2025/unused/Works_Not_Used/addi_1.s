.data
.text
.globl main
main:
#test to detect overflow

#In this one there is no overflow
addi $1, $0, 0x09000000	#initialize $1 to 0x09000000	 
addi $2, $1, 1		#$2=$1+1

#In this one there is overflow
addi $3, $0, 0x08000000 #initialize $3 to 0x08000000 
addi $4, $3, 0x7F000000	#$4=$3+0x7F000000 --> runtime exception: arithmetic overflow




    halt
