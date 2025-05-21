.data
.text
.globl main
main:
	ori $t1, 0xF
    # Start Test
 	addi $t0, $t1, 0 # testing addi as when it is adding nothing should get F
 	addi $t2, $t0, 1 # testing the carry bit of addi should be getting 0x10
 	addi $t3, $t2, -15 # testing addi with adding negative value Expected output should be 1 
 	addi $t4, $0, 0x7FFF # adding using the MAX positive imm
 	addi $t5, $0, -1 # adding negative 1 which will result in 0xffffffff
    # End Test

    # Exit program
    halt
