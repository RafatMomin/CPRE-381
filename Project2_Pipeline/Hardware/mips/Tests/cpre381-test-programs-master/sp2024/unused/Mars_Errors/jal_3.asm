#third stress test for JAL, this JAL test will combine the other two in a way that has not been seen.
#we will use Lw along with a recursive function, that calls two jal methods within it as a sub routine.
# we instead define how to read this in a easier way by storring the data. You can then commpare your desired max depth with current
#to see where an issue may have occured. If an issue occured, go back to the other two tests and find where.
# maxdepth will hold the desired depth
# current depth will hold the current dept of calls.
# current should be equal to max when ending to know it correctly ran all the times.
# $s0 will also be set to 1 to verify it exited properly and fell off.

.data
maxDepth: .word 5  	# Maximum recursion depth
currentDepth: .word 0 	# Current depth of recursion

.text
.globl main

main:
    	# Initialize recursion depth to 0
    	addi $a0, $zero, 0	# Starting depth

    	# Begin recursive sequence
    	jal recursiveFunction

    	# Exit program by dropping off.
	j end

recursiveFunction:
    	# Load current depth
    	lw $t0, currentDepth

    	# Check for base case to stop recursion
    	lw $t1, maxDepth
    	beq $t0, $t1, returnFromRecursion

    	# Call method1
    	jal method1

    	# Call method2
    	jal method2

    	# Increment current depth
    	addi $t0, $t0, 1
    	sw $t0, currentDepth

    	# Recursive call
    	jal recursiveFunction

returnFromRecursion:
    	jr $ra	# Return from recursion

method1:
    	# just return as we arent testing anyhting else.
    	jr $ra

method2:
    	# just return as we arent testing anything else.
    	jr $ra

end: 	#stop infinite loop
	addi $s0, $zero, 1
	halt
