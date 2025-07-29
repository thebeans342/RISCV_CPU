#include "base_testbench.h"
#include <cstdlib>

#define CYCLES 10000

Vdut *ctrl_unit;
VerilatedVcdC *tfp;
unsigned int ticks = 0;

// Define the testbench class and override the required method
class ctrlTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
       ctrl_unit->instr = 0;
    }
};

TEST_F(ctrlTestbench, RtypeTest)
{
    ctrl_unit->instr = 0x00310033;
    ctrl_unit->eval();
    // Optional: assertions like EXPECT_EQ(ctrl_unit->some_output, expected_val);
}

TEST_F(ctrlTestbench, StypeTest)
{
    ctrl_unit->instr = 0x00112023;
    ctrl_unit->eval();
}

TEST_F(ctrlTestbench, ItypeTest)
{
    ctrl_unit->instr = 0x0FF00313;
    ctrl_unit->eval();
}

int main(int argc, char **argv)
{
    ctrl_unit = new Vdut;
    tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    ctrl_unit->trace(tfp, 99);
    tfp->open("waveform.vcd");
    
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();

    ctrl_unit->final();
    tfp->close();

    delete ctrl_unit;
    delete tfp;

    return res;
}
