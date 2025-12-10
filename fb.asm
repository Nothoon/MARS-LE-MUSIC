.data
Fizz: .asciiz "Fizz"
Buzz: .asciiz "Buzz"

.text
li $t0, 0
li $t1, 20
li $t2, 3
li $t3, 5

Loop:
    addi $t0, $t0, 1
    li $t5, 0

    jal Check_Fizz
    jal Check_Buzz

    beq $t5, $zero, Print_Regular

    li $v0, 11
    li $a0, 10
    syscall

    j End_of_Loop

Print_Regular:
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 11
    li $a0, 10
    syscall

End_of_Loop:
    beq $t0, $t1, End
    j Loop

Check_Fizz:
    div $t0, $t2
    mfhi $t4

    bne $t4, $zero, Continue_Fizz

    li $t5, 1
    li $v0, 4
    la $a0, Fizz
    syscall

Continue_Fizz:
    jr $ra

Check_Buzz:
    div $t0, $t3
    mfhi $t4

    bne $t4, $zero, Continue_Buzz

    li $t5, 1
    li $v0, 4
    la $a0, Buzz
    syscall

Continue_Buzz:
    jr $ra

End:
