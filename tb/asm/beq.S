.text
.globl main

main:
    li t1, 100
    li t2, 101
    beq t1, t2, eq    # enter eq

n_eq:
    li a0, 0x1

eq:    
    li a0, 0x5    