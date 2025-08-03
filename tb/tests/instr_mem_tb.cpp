#include "base_testbench.h"
#include <cstdlib>

#define CYCLES 10

Vdut *PC;
VerilatedVcdC *tfp;
unsigned int ticks = 0;

// Define the testbench class and override the required method
class ctrlTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
       PC->instr = 0x00000000; // Initialize instruction to a known value
       PC->clk = 1;
       PC->rst = 0;
    }
};

TEST_F(ctrlTestbench, RtypeTest)
{
    bool success = false;
    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
        if (PC->PC_out == 0x00000028)
        {
            SUCCEED();
            success = true;
            break;
        }
    }
    if(!success){
        FAIL() << "a0 did not reach 254, it reached " << PC->PC_out;
    }
}


int main(int argc, char **argv)
{
    PC = new Vdut;
    tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    PC->trace(tfp, 99);
    tfp->open("waveform.vcd");
    
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();

    PC->final();
    tfp->close();

    delete PC;
    delete tfp;

    return res;
}
