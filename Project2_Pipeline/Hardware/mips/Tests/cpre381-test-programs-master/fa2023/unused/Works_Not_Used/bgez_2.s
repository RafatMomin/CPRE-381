#Testing with positive integer
li $t0, 10       # Load a positive value into $t0
bgez $t0, Label1 # Branch to Label1 if $t0 >= 0
j Exit           # Otherwise, jump to the Exit
Label1:
addi $t0, $t0, -20 # Subtract 20 from $t0 to make it negative
bgez $t0, Label2   # Branch to Label2 if $t0 >= 0
j Exit             # Otherwise, jump to the Exit
Label2:
addi $t0, $t0, -2147483647 # Subtract the largest negative value from $t0 to make it overflow
bgez $t0, Label3   # Branch to Label3 if $t0 >= 0
j Exit             # Otherwise, jump to the Exit
Label3:
# Add more testing code here
j Exit

Exit:
# Exit code here
halt
