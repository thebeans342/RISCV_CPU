# RISCV_CPU
A 32 bit RISCV CPU:

# How it works:
## Reg_file:
The register file consists of 32, 32-bit registers with 2 read and 1 write port, each address corresponding to the following register:

The instructions will contain registers rs1, rs2 and rd:
* rs1 specifies the register containing the first operand
* rs2 specifies the register containing the second operand
* RD1 and RD2 specify the destination register, containing the result of the computation

The wd signal is the MemtoReg signal, which inputs the value from ALUOut when deasserted. The we signal is the WriteEnable signal, which when asserted causes registers to be written
