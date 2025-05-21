# Case where a value is shifted more bits than the size of the register for all registers
#Different hardware may handle an overshift differently, so it is good to see how the hardware will deal with an over shift.

# Start Test

srl $1, $1, 33		#Shift by 1 greater than the register size in bits
srl $2, $2, 33		#Shift by 2 greater than the register size in bits
srl $3, $3, 33		#Shift by 3 greater than the register size in bits
srl $4, $4, 33		#Shift by 4 greater than the register size in bits
srl $5, $5, 33		#Shift by 5 greater than the register size in bits
srl $6, $6, 33		#Shift by 6 greater than the register size in bits
srl $7, $7, 33		#Shift by 7 greater than the register size in bits
srl $8, $8, 33		#Shift by 8 greater than the register size in bits
srl $9, $9, 33		#Shift by 9 greater than the register size in bits
srl $10, $10, 33	#Shift by 10 greater than the register size in bits
srl $11, $11, 33	#Shift by 11 greater than the register size in bits
srl $12, $12, 33	#Shift by 12 greater than the register size in bits
srl $13, $13, 33	#Shift by 13 greater than the register size in bits
srl $14, $14, 33	#Shift by 14 greater than the register size in bits
srl $15, $15, 33	#Shift by 15 greater than the register size in bits
srl $16, $16, 33	#Shift by 16 greater than the register size in bits
srl $17, $17, 33	#Shift by 17 greater than the register size in bits
srl $18, $18, 33	#Shift by 18 greater than the register size in bits
srl $19, $19, 33	#Shift by 19 greater than the register size in bits
srl $20, $20, 33	#Shift by 20 greater than the register size in bits
srl $21, $21, 33	#Shift by 21 greater than the register size in bits
srl $22, $22, 33	#Shift by 22 greater than the register size in bits
srl $23, $23, 33	#Shift by 23 greater than the register size in bits
srl $24, $24, 33	#Shift by 24 greater than the register size in bits
srl $25, $25, 33	#Shift by 25 greater than the register size in bits
srl $26, $26, 33	#Shift by 26 greater than the register size in bits
srl $27, $27, 33	#Shift by 27 greater than the register size in bits
srl $28, $28, 33	#Shift by 28 greater than the register size in bits
srl $29, $29, 33	#Shift by 29 greater than the register size in bits
srl $30, $30, 33	#Shift by 30 greater than the register size in bits
srl $31, $31, 33	#Shift by 31 greater than the register size in bits

#End Program
halt