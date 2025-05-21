# Test: Basic Range Test
.data
.text
.globl main
main:
    # Test the range of 16-bit immediate values from 0 to 0xFFFF
    lui $t0, 0x0000      # Test lowest value (0x00000000)
    lui $t1, 0x0001      # Test small positive value (0x00010000)
    lui $t2, 0x7FFF      # Test positive near the upper limit (0x7FFF0000)
    lui $t3, 0xFFFF      # Test highest value (0xFFFF0000)

    # These tests check that we can correctly load a variety of immediate values into the upper 16 bits of a register.
    # The immediate values range from 0 to 0xFFFF.
    # Testing the lowest (0x0000) and highest (0xFFFF) possible values will help confirm that the register can hold
    # both extreme positive values, as well as intermediate values such as 0x0001 and 0x7FFF.

    halt
