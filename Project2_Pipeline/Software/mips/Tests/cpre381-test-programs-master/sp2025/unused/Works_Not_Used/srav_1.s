.data
.text
.globl main
main:
    # Start Test
    
    #srav Rd , Rt , Rs shift the value in Rt by Rs, then get the value in Rd
    
    addi $t3, $zero, 4
    lui $t2, 0x7FFF
    ori $t2, $t2, 0xFFFF
    
    srav $0, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $1, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $2, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension  
    srav $3, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $4, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $5, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $6, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension  
    srav $7, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension 
    srav $8, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension
    srav $9, $t2, $t3     # verify that positive numbers can be shifted with proper sign extension
    
    
    addi $t1, $zero, 4
    lui $t0, 0x7FFF		#changes the RT and RS registers so that all registers are tested	
    ori $t0, $t0, 0xFFFF
        
    srav $10, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $11, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $12, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $13, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $14, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $15, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $16, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $17, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $18, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $19, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $20, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $21, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $22, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $23, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $24, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $25, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $26, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension   
    srav $27, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $28, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension  
    srav $29, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    srav $30, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension 
    srav $31, $t0, $t1     # verify that positive numbers can be shifted with proper sign extension
    # End Test

    # Exit program
    halt
