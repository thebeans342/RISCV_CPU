.text
.globl main
main:
    li t1, 1
    slli a0, t1, 1  # exepected output 2
    srli a0, t1, 1   # expected output 1  
    sltiu a0, t1, 2  # expected output 1