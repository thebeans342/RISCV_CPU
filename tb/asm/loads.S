.text
.globl main

main:;
    li s0, 0x00010000

    li t1, 10000
    sw t1, 0(s0) 

    lw t2, 0(s0)

    add a0, zero, t2