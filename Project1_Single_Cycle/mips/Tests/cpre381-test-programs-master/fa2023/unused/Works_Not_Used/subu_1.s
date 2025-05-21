.data
.text
.globl test1
test1:
#test for no overflow protection
#according to my research, subu does not have overflow protection
#this is because subu uses unsigned integer

addiu $t1,$0,0 #to test the lack of overflow protection, set the value of $t1 to 0 using $0
subu $t0,$t1,1 # subtract the value 1 in decimal from 0, the result of this should be 0xffffffff

#check the compiler (MARS) to see if t0 is 0xffffffff, then subu has worked correctly with noi overflow protection. This is an important edge case becuse this could be used strateigically to access high register values. Also, it's importa	nt not to use this instruction where you might expect a negative value to be input.

halt
