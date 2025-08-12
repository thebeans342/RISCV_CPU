.text
.global main

main: # expected result a0 =  1
    li t0, -8                 # Load 5 into t0
    li t1, 1               # Load 10 into t1
    sra t2, t0, t1           # t2 = (t0 < t1) ? 1 : 0

    add a0, zero, t2         # Move t2 to a0