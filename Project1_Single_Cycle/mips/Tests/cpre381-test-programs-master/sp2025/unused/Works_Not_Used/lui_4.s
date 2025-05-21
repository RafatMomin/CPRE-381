# Test: Negative Range Test (Edge cases for signed values)
.data
.text
.globl main
main:
    # Load negative 2's complement numbers
    lui $t0, 0x8000      # Test -32768 (0x80000000 in 2's complement)
    lui $t1, 0xFFFE      # Test near -2 (0xFFFE0000 in 2's complement)
    lui $t2, 0xFFFF      # Test near -1 (0xFFFF0000 in 2's complement)

    # These tests check that we correctly load negative values and that the immediate values are properly extended
    # for 32-bit signed numbers (2's complement). Negative values are loaded into the upper 16 bits.
    # The test includes a check for the boundary at -32768 (0x8000), which represents the smallest negative value that can
    # be represented by 2's complement in a 32-bit system.
    # The test also includes values near -1 and -2, ensuring that the instruction behaves properly near the negative edge cases.
    # These cases will also help validate the correct handling of negative 2's complement values in the `lui` instruction.


    halt
