.data
.text
.globl main
main:
    # Load max positive value into a register
    addi $1, $0, 2147483647  # Max signed 32-bit integer
    addi $2, $1, 1           # Overflow expected: 2147483647 + 1

    # Load min negative value into a register
    addi $3, $0, -2147483648 # Min signed 32-bit integer
    addi $4, $3, -1          # Overflow expected: -2147483648 - 1

    # Test a case where overflow does NOT occur
    addi $5, $3, 1           # -2147483648 + 1 = -2147483647 (no overflow)

    # End Test
    halt
