#include "base_testbench.h"
#include <cstdlib>

#define CYCLES 10000

Vdut *ALU;
VerilatedVcdC *tfp;
unsigned int ticks = 0;

// Define the testbench class and override the required method
class ctrlTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
       ALU->ALUctrl = 0;
       ALU->ALUop1 = 0x0001;
       ALU->regop2 = 0x0002;
       ALU->ALUsrc = 0;
    }
};

TEST_F(ctrlTestbench, addTest)
{
    ALU->ALUctrl = 0b000;
    ALU->eval();
    // Optional: assertions like EXPECT_EQ(ALU->some_output, expected_val);
}

TEST_F(ctrlTestbench, subTest)
{
    ALU->ALUctrl = 0b001;
    ALU->eval();
}

TEST_F(ctrlTestbench, andTest)
{
    ALU->ALUctrl = 0b010;
    ALU->eval();
}

TEST_F(ctrlTestbench, multTest)
{
    ALU->ALUctrl = 0b011;
    ALU->eval();
}

int main(int argc, char **argv)
{
    ALU = new Vdut;
    tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    ALU->trace(tfp, 99);
    tfp->open("waveform.vcd");
    
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();

    ALU->final();
    tfp->close();

    delete ALU;
    delete tfp;

    return res;
}
