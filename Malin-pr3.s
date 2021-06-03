#Seth Malin
#Program 3
#CSCI 313

    
.data 
  
newLine:
    .asciiz "\n"
space:
    .asciiz " "
    
message:
	.asciiz "The smallest in the array is: "
	
array1:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	
array2: 
	.word 30, 300, -23, 106, -5000


array3:
	.word 4, 8, 15, 16, 23, 42
   	
.align 2

.text

la $a0, array1 # load array into $a0
addi $a1, $zero, 9 # set $a1 to the size of the array - 1
jal min
la $a0, message
move $a1, $v0
jal printlnStringInt

la $a0, array2 # load array into $a0
addi $a1, $zero, 4 # set $a1 to the size of the array - 1
jal min
la $a0, message
move $a1, $v0
jal printlnStringInt

la $a0, array3 # load array into $a0
addi $a1, $zero, 5 # set $a1 to the size of the array - 1
jal min
la $a0, message
move $a1, $v0
jal printlnStringInt

# end program

li $v0, 10			# sys number to exit
syscall

# $t0 is the return address save
# $t1 is the current index in the array
# $t2 is the size of the array within the function
# $t3 is array address within function
# $t4 is the current index in the array
# $t5 is the next index in the array to compare
# $t6 is the min value
# $a0 is the address of the array
# $a1 is the length of the array 
# $v0 is the return value, the smallest number in the array
min:
	move $t0, $ra # preserve return address
	addi $t1, $zero, 0 # set $t1 to first index of array
	move $t2, $a1 # move the array size into $t2
	move $t3, $a0 # move the array address into #t3
	lw $t6, 0($a0) # Store the first value into the array
	While: beq $t1, $t2, After
	addi $t1, $t1, 1 # increment index
	lw $t4, 0($t3) # load item at current index of array into $t4
	addi $t3, $t3, 4 # increment array's address by 4, increasing the index by 1
	lw $t5, 0($t3) # load the item at next index in array to $t5
	bge $t5, $t4, While
	move $t6, $t5
	j While
	After:
	move $v0, $t6
	move $ra, $t0 # retrieve return address
	jr $ra


printSpace:
	# prints a space
	
	la $a0, space
	li $v0, 4
	syscall
	
	jr $ra
	
println:
	# prints a new line
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	jr $ra
	
printInt:
	# prints an integer
	# $a0 has integer
	
	li $v0, 1
	syscall
		
	jr $ra

printlnInt:
	# prints an integer with a new line
	# $a0 has integer
	
	li $v0, 1
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall
	
	jr $ra

printString:
	# prints a string
	# $a0 has string address
	
	li $v0, 4
	syscall
	
	jr $ra
	
	
printlnString:
	# prints a string with a new line
	# $a0 has string address
	
	li $v0, 4
	syscall
	
	la $a0, newLine
	li $v0, 4
	syscall

	jr $ra
	
	
printStringInt:
	# prints a string and an integer
	# $a0 is string address
	# $a1 is int
	
	# save return address so not overwritten
	# save $a1 so not overwritten
	
	addiu $sp, $sp, -8
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	
	# print string
	
	jal printString
	
	# print int
	# get argument from stack
	
	lw $a0, 4($sp)
	jal printInt
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra

printlnStringInt:
	# prints a string and an integer with new line
	# $a0 is string address
	# $a1 is int
	
	# save return address so not overwritten
	# save $a1 so not overwritten
	
	addiu $sp, $sp, -8
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	
	# print string
	
	jal printString
	
	# print int
	# get argument from stack
	
	lw $a0, 4($sp)
	jal printlnInt
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra

