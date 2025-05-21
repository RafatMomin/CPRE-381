.data
.text
.globl main
main:

	#Start Test Immediate: Set most to a number within the register (example: $1 = X"03010000" then I will just try to and that 1). This one has fewer test cases, but it is to prove that you can and a different register and corresponding number)
	#Justification: This is to make sure it can read another register and an immediate that corresponds
	andi $2, $28, 32768	#test, just grab the 8000 from $28
	andi $7, $29, 60
	andi $10, $29, 4
	andi $14, $29, 124
	andi $17, $29, 13
	andi $21, $29, 28
	andi $28, $28, 268468224
	andi $29, $29, 2147479548
halt
