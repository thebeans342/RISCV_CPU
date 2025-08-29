.text
.globl main

main:
    addi t1, zero, -2048
    addi t2, zero, 0x0F
    # bge t1, t2, true    # enter eq
    bltu t1, t2, true

false:
    li a0, 0x1

true:    
    li a0, 0x5