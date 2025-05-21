.data
.text
.globl main
main:
    # Test adding large positive numbers
    addi $1, $0, 32767     # Maximum positive 16-bit immediate
    addi $2, $1, -32768    # Adding the smallest possible immediate

    # Test sign extension
    addi $3, $0, -1        # -1 stored in register
    addi $4, $3, 1         # -1 + 1 = 0
    addi $5, $4, -32768    # 0 - 32768 = -32768 (check sign extension)
    addi $6, $5, 32767     # -32768 + 32767 = -1

    # Edge cases with signed values
    addi $7, $0, -32768    # Ensure it is correctly interpreted as a negative
    addi $8, $7, 32767     # Should result in -1

    # End Test
    halt
