.data
.text
.globl main
main:

    # No combination of bits should pass through and with zero
    # Only testing for the first byte

    # Start Test
    and $t0, $0, $0

    # And zero with 0
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 1
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 2
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 3
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 4
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 5
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 6
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0
    
    # And zero with 7
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 8
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 9
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 10
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 11
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 12
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 13
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 14
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 15
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 16
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 17
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 18
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 19
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 20
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 21
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 22
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 23
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 24
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 25
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 26
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 27
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 28
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 29
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 30
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # And zero with 31
    addi $t0, $t0, 1
    and $t1, $t0, $0
    and $t1, $0, $t0

    # Exit program
    halt
