.data
.text
.globl main
main:
    # Start Test
    # OR with 1
    # $t0 = 0x340F
    # $t1 = 0xFFFF
    # Expected $t2 = 0xFFFF

    addi $t0, $t0, 0x340F
    addi $t1, $t1, 0xFFFF

    or $t2, $t0, $t1
    # End Test

    # Exit program
    halt