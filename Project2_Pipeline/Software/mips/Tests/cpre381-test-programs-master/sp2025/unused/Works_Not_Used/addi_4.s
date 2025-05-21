.data
.text
.globl main
main:
    # Verify that addi works with zero
    addi $1, $0, 0      # 0 + 0 = 0
    addi $2, $1, 5      # 0 + 5 = 5
    addi $3, $2, -5     # 5 - 5 = 0

    # Test small positive and negative immediate values
    addi $4, $0, 1      # 0 + 1 = 1
    addi $5, $4, -1     # 1 - 1 = 0
    addi $6, $5, 127    # 0 + 127 = 127
    addi $7, $6, -128   # 127 - 128 = -1

    # End Test
    halt
