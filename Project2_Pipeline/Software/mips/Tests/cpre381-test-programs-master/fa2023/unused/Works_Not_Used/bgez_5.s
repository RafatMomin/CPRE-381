.data
.text
.globl main
main:
    # Start Test - Branch when register value is > 0
    addi $1, $0, 0xF
    bgez $1, L1       # Verify branch when $1 > 0
    addi $1, $0, 2
    
L1: addi $2, $0, 0xF  # $1 should still be 0xF
    bgez $2, L2       # Verify branch when $2 > 0
    addi $2, $0, 2
    
L2: addi $3, $0, 0xF  # $2 should still be 0xF
    bgez $3, L3       # Verify branch when $3 > 0
    addi $3, $0, 2
    
L3: addi $4, $0, 0xF  # $3 should still be 0xF
    bgez $4, L4       # Verify branch when $4 > 0
    addi $4, $0, 2
    
L4: addi $5, $0, 0xF  # $4 should still be 0xF
    bgez $5, L5       # Verify branch when $5 > 0
    addi $5, $0, 2

L5: addi $6, $0, 0xF  # $5 should still be 0xF
    bgez $6, L6       # Verify branch when $6 > 0
    addi $6, $0, 2

L6: addi $7, $0, 0xF  # $6 should still be 0xF
    bgez $7, L7       # Verify branch when $7 > 0
    addi $7, $0, 2

L7: addi $8, $0, 0xF  # $7 should still be 0xF
    bgez $8, L8       # Verify branch when $8 > 0
    addi $8, $0, 2

L8: addi $9, $0, 0xF  # $8 should still be 0xF
    bgez $9, L9       # Verify branch when $9 > 0
    addi $9, $0, 2

L9: addi $10, $0, 0xF # $9 should still be 0xF
    bgez $10, L10     # Verify branch when $10 > 0
    addi $10, $0, 2

L10:addi $11, $0, 0xF # $10 should still be 0xF
    bgez $11, L11     # Verify branch when $11 > 0
    addi $11, $0, 2

L11:addi $12, $0, 0xF # $11 should still be 0xF
    bgez $12, L12     # Verify branch when $12 > 0
    addi $12, $0, 2

L12:addi $13, $0, 0xF # $12 should still be 0xF
    bgez $13, L13     # Verify branch when $13 > 0
    addi $13, $0, 2

L13:addi $14, $0, 0xF # $13 should still be 0xF
    bgez $14, L14     # Verify branch when $14 > 0
    addi $14, $0, 2

L14:addi $15, $0, 0xF # $14 should still be 0xF
    bgez $15, L15     # Verify branch when $15 > 0
    addi $15, $0, 2

L15:addi $16, $0, 0xF # $15 should still be 0xF
    bgez $16, L16     # Verify branch when $16 > 0
    addi $16, $0, 2

L16:addi $17, $0, 0xF # $16 should still be 0xF
    bgez $17, L17     # Verify branch when $17 > 0
    addi $17, $0, 2

L17:addi $18, $0, 0xF # $17 should still be 0xF
    bgez $18, L18     # Verify branch when $18 > 0
    addi $18, $0, 2

L18:addi $19, $0, 0xF # $18 should still be 0xF
    bgez $19, L19     # Verify branch when $19 > 0
    addi $19, $0, 2

L19:addi $20, $0, 0xF # $19 should still be 0xF
    bgez $20, L20     # Verify branch when $20 > 0
    addi $20, $0, 2

L20:addi $21, $0, 0xF # $20 should still be 0xF
    bgez $21, L21     # Verify branch when $21 > 0
    addi $21, $0, 2

L21:addi $22, $0, 0xF # $21 should still be 0xF
    bgez $22, L22     # Verify branch when $22 > 0
    addi $22, $0, 2

L22:addi $23, $0, 0xF # $22 should still be 0xF
    bgez $23, L23     # Verify branch when $23 > 0
    addi $23, $0, 2

L23:addi $24, $0, 0xF # $23 should still be 0xF
    bgez $24, L24     # Verify branch when $24 > 0
    addi $24, $0, 2

L24:addi $25 $0, 0xF  # $24 should still be 0xF
    bgez $25, L25     # Verify branch when $25 > 0
    addi $25, $0, 2

L25:addi $26, $0, 0xF # $25 should still be 0xF
    bgez $26, L26     # Verify branch when $26 > 0
    addi $26, $0, 2

L26:addi $27, $0, 0xF # $26 should still be 0xF
    bgez $27, L27     # Verify branch when $27 > 0
    addi $27, $0, 2

L27:addi $28, $0, 0xF # $27 should still be 0xF
    bgez $28, L28     # Verify branch when $28 > 0
    addi $28, $0, 2

L28:addi $29, $0, 0xF # $28 should still be 0xF
    bgez $29, L29     # Verify branch when $29 > 0
    addi $29, $0, 2

L29:addi $30, $0, 0xF # $29 should still be 0xF
    bgez $30, L30     # Verify branch when $30 > 0
    addi $30, $0, 2

L30:addi $31, $0, 0xF # $30 should still be 0xF
    bgez $31, L31     # Verify branch when $31 > 0
    addi $31, $0, 2

L31: # $31 should still be 0xF
    # End Test

    # Exit program
    halt
