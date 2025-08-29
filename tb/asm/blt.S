.text
.globl main

main:
    li t1, 100 
    li t2, 99   
    bltu t1, t2, true    # enter eq

false:
    li a0, 0x1

true:    
    li a0, 0x5
