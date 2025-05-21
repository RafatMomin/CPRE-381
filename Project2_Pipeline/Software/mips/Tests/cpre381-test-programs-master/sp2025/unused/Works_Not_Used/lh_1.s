# This program tests whether lh correctly loads standard values from aligned memory and applies proper sign extension
# Ever case included confirms correct basic functionality of lh 

        .data
test_data:
        .half 0x0000    
        .half 0x7FFF  
        .half 0x1234       

        .text
        .globl main

main:
        lui   $t0, 0x1001    
        #addiu $t0, $t0, test_data  

        # Ensures positive numbers are not modified when extended
        # Load smallest possible halfword
        lh    $t1, 0($t0)    # Expect 0x0000
        
        # Ensures positive numbers are not modified when extended
        # Load largest positive halfword
        lh    $t2, 2($t0)    # Expect 0x7FFF
        
        # Ensures positive numbers are not modified when extended
        # Load arbitrary positive number
        lh    $t3, 4($t0)    # Expect 0x1234
