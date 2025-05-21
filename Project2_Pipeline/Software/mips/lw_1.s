# Test program for MIPS processor
# Uses all required instructions while avoiding hazards

.data
array:  .word 0, 0, 0, 0, 0   # Array to store values in memory

.text
.globl main
main:
    # Initialize base registers with values
    lui     $1, 0x1000       # $1 = 0x10000000 (base address for array)
    ori     $2, $0, 10       # $2 = 10
    addiu   $3, $0, 20       # $3 = 20
    addi    $4, $0, 5        # $4 = 5
    
    # Perform arithmetic operations
    add     $5, $2, $3       # $5 = 30
    addu    $6, $3, $4       # $6 = 25
    sub     $7, $3, $2       # $7 = 10
    subu    $8, $5, $4       # $8 = 25
    
    # Store values to memory
    sw      $5, 0($1)        # Store 30 at array[0]
    sw      $6, 4($1)        # Store 25 at array[1]
    sw      $7, 8($1)        # Store 10 at array[2]
    sw      $8, 12($1)       # Store 25 at array[3]
    
    # Perform logical operations
    and     $9, $5, $6       # $9 = 24 (30 & 25)
    andi    $10, $5, 15      # $10 = 14 (30 & 15)
    or      $11, $2, $4      # $11 = 15 (10 | 5)
    ori     $12, $7, 5       # $12 = 15 (10 | 5)
    nor     $13, $2, $4      # $13 = 0xFFFFFFF0 (~(10 | 5))
    xor     $14, $5, $7      # $14 = 20 (30 ^ 10)
    xori    $15, $5, 10      # $15 = 20 (30 ^ 10)
    
    # Comparison operations
    slt     $16, $2, $3      # $16 = 1 (10 < 20)
    slti    $17, $3, 15      # $17 = 0 (20 < 15 is false)
    
    # Load operations
    lw      $18, 0($1)       # $18 = 30
    lb      $19, 0($1)       # $19 = 30 (sign extended)
    lbu     $20, 0($1)       # $20 = 30
    lh      $21, 0($1)       # $21 = 30 (sign extended)
    lhu     $22, 0($1)       # $22 = 30
    
    # Shift operations with immediates
    sll     $23, $2, 2       # $23 = 40 (10 << 2)
    srl     $24, $5, 1       # $24 = 15 (30 >> 1)
    sra     $25, $7, 1       # $25 = 5 (10 >> 1)
    
    # Shift operations with variables
    sllv    $26, $2, $4      # $26 = 320 (10 << 5)
    srlv    $27, $5, $4      # $27 = 0 (30 >> 5)
    ori     $4, $0, 1        # Reset $4 to 1 (avoid using result immediately)
    srav    $28, $7, $4      # $28 = 5 (10 >> 1)
    
    # Jump and branch - carefully ordered to avoid hazards
    j       jump_target      # Jump forward
    ori     $29, $0, 100     # $29 = 100 (delay slot)
    
not_taken:
    # This should be skipped
    ori     $0, $0, 0        # No-op (does nothing)
    
jump_target:
    # Continue execution here after jump
    ori     $30, $0, 200     # $30 = 200
    
    # Branch equal test
    ori     $4, $0, 5        # $4 = 5
    ori     $7, $0, 5        # $7 = 5 
    beq     $4, $7, beq_target # Branch taken
    ori     $0, $0, 1        # Delay slot instruction
    
    # This should be skipped
    ori     $0, $0, 0        # No-op

beq_target:
    # Branch not equal test
    ori     $4, $0, 6        # $4 = 6
    bne     $4, $7, bne_target # Branch taken (6 != 5)
    ori     $0, $0, 2        # Delay slot instruction
    
    # This should be skipped
    ori     $0, $0, 0        # No-op

bne_target:
    # Jump and link test
    jal     function         # Call function
    ori     $0, $0, 3        # Delay slot instruction
    
    # Program should continue here after function returns
    sw      $31, 16($1)      # Store return address at array[4]
    
    # End of program
    j       end              # Jump to end
    ori     $0, $0, 0        # Delay slot

function:
    # Function body
    ori     $31, $31, 0      # Use return address
    jr      $31              # Return to caller
    ori     $0, $0, 4        # Delay slot instruction

end:
    # Program complete
    halt                     # Halt execution
