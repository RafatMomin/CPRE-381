.data

.globl main

main: 
 

# check random random registers and if they are less than zero go to the loop
#follow the amount of times gone to loop through $t0

 # test 
 bltz $0, loop
 bltz $2, loop
 bltz $3, loop
 bltz $4, loop
 bltz $5, loop
 bltz $6, loop
 bltz $7, loop
 bltz $8, loop 
 bltz $31,loop

loop: 
addi $t0,$t0,1
 
 #end test
# li $v0, 10
 #syscall
halt
