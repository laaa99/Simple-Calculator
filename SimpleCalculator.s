# Lucy Tran
# 9-30-16
# Hw 4: Simple Calculator

		.data 
# intialization of phrases to console
phrase:	 .asciiz "Enter the first number: "
phrase2: .asciiz "Enter the second number: "
phrase3: .asciiz "Enter the operation type: "
phrase4: .asciiz "\nThe result is "
		
		.text
main:
	# Prompt for first number
	li	$v0, 4 		# print_string $a0 = string
	la	$a0, phrase	# Print to console
	syscall 		# call operating system to perform print operation
	
	# Get first number from user
	li	$v0, 5		# read_int
	syscall
	move $t0, $v0   # t0 = v0
	
	# Prompt for second number
	li $v0, 4
	la $a0, phrase2
	syscall
	
	# Get second number from user
	li $v0, 5
	syscall
	move $t1, $v0	# t1 = v0
	
	# Prompt for operation type
	li $v0, 4
	la $a0, phrase3
	syscall
	
	# Get operation type from user
	li $v0, 5
	syscall
	move $t2, $v0	# t2 = v0
	
	# Temporary registers to compare with operation type
	addi $t3, $zero, 0 # t3 = 0
	addi $t4, $zero, 1 # t4 = 1
	addi $t5, $zero, 2 # t5 = 2
	
	# Move to operation type labels
	beq $t3, $t2, ADD_OP      # if t2 = 0
	beq $t4, $t2, SUBTRACT_OP # if t2 = 1
	beq $t5, $t2, MULTIPLY_OP # if t2 = 0

Result:
	# Print sentence before result
	li $v0, 4
	la $a0, phrase4
	syscall
	
	# Print result
	li $v0, 1      # load appropriate system call code into register $v0;
	move $a0, $t6  # move integer to be printed into $a0:  $a0 = $t6
	syscall
	
	jr	$ra        # return to caller
	
ADD_OP:
	# Add user inputted numbers
	add $t6, $t0, $t1 # t0 + t1
	j Result          # Move to Result
	
SUBTRACT_OP:
	# Subtract user inputted numbers
	sub $t6, $t0, $t1 # t0 - t1
	j Result          # Move to Result
	
MULTIPLY_OP:
	# Multiply user inputted numbers
	mult $t0, $t1 # t0 * t1 = $LO
	mflo $t6      # contents of register LO moved to t6
	j Result      #
	