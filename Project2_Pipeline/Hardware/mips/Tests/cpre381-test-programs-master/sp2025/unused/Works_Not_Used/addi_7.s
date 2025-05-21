.data
.text
.globl main
main:
	lui $t2, 0x7FFF
	ori $t2, 0xFFFF
    # Start Test
	addi $t3, $t2, 1  # this will cause maximum overflow or mips will show that the program terminate because it exeed maximum positive sign int 
    # End Test

    # Exit program
    halt