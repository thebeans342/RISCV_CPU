#include "base_testbench.h"
#include <cstdlib>

#define CYCLES 10000

Vdut *ctrl;
VerilatedVcdC *tfp;
unsigned int ticks = 0;

// Define the testbench class and override the required method
class CtrlTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
       ctrl->instr = 0;
    }
};

// R-type: add x0, x2, x3 => opcode: 0110011 funct3: 000 funct7: 0000000
TEST_F(CtrlTestbench, RtypeAddTest) {
    ctrl->instr = 0b00000000001100010000000010110011; // add x1, x2, x3
    ctrl->EQ = 0;
    ctrl->eval();
    EXPECT_EQ(ctrl->RegWrite, 1);
    EXPECT_EQ(ctrl->ALUsrc, 0);
    EXPECT_EQ(ctrl->PCsrc, 0);
    EXPECT_EQ(ctrl->ImmSrc, 0);
    EXPECT_EQ(ctrl->ALUctrl, 0b000); // add
}

// I-type: addi x6, x0, 0xFF => opcode: 0010011
TEST_F(CtrlTestbench, ItypeAddiTest) {
    ctrl->instr = 0x0FF00313; // addi x6, x0, 0xFF
    ctrl->EQ = 0;
    ctrl->eval();
    EXPECT_EQ(ctrl->RegWrite, 1);
    EXPECT_EQ(ctrl->ALUsrc, 1);
    EXPECT_EQ(ctrl->PCsrc, 0);
    EXPECT_EQ(ctrl->ImmSrc, 0); // I-type
}

// S-type: sw x1, 0(x2) => opcode: 0100011
TEST_F(CtrlTestbench, StypeStoreTest) {
    ctrl->instr = 0x00112023; // sw x1, 0(x2)
    ctrl->EQ = 0;
    ctrl->eval();
    EXPECT_EQ(ctrl->RegWrite, 0);
    EXPECT_EQ(ctrl->ALUsrc, 1);
    EXPECT_EQ(ctrl->PCsrc, 0);
    EXPECT_EQ(ctrl->ImmSrc, 1); // S-type
}

// B-type: bne x1, x2, -4 => opcode: 1100011, funct3: 001
TEST_F(CtrlTestbench, BtypeBranchTest) {
    ctrl->instr = 0b11111110001000001001011101100011; // bne x1, x2, -4
    ctrl->EQ = 0; // not equal
    ctrl->eval();
    EXPECT_EQ(ctrl->RegWrite, 0);
    EXPECT_EQ(ctrl->ALUsrc, 0);
    EXPECT_EQ(ctrl->PCsrc, 1); // Because EQ=0, branch taken
    EXPECT_EQ(ctrl->ImmSrc, 2); // B-type
}

TEST_F(CtrlTestbench, BNETest) {
    ctrl->instr = 0xfe659ce3;
    ctrl->eval();
    EXPECT_EQ(ctrl->RegWrite, 0);
    EXPECT_EQ(ctrl->ALUsrc, 0);
    EXPECT_EQ(ctrl->PCsrc, 1); // Because EQ=0, branch taken
    EXPECT_EQ(ctrl->ImmSrc, 2); // B-type
}


int main(int argc, char **argv)
{
    ctrl = new Vdut;
    tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    ctrl->trace(tfp, 99);
    tfp->open("waveform.vcd");
    
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();

    ctrl->final();
    tfp->close();

    delete ctrl;
    delete tfp;

    return res;
}