#include "top_testbench.h"
#include <cstdlib>

#define CYCLES 10000

unsigned int ticks = 0;

class CpuTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        top->rst = 0;

        // system("./compile.sh --input asm/program.s");

        // int result = system("./compile.sh asm/assembly_test.S");
        // if (result != 0) {
        //     FAIL() << "Compilation failed with error code: " << result;
        // }

    }
};

TEST_F(CpuTestbench, BaseProgramTest)
{
    bool success = false;
    system("./compile.sh asm/assembly_test.S");

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
        if (top->a0 == 254)
        {
            SUCCEED();
            success = true;
            break;
        }
    }
    if (!success)
    {
        FAIL() << "a0 did not reach 254, it reached " << top->a0;
    }
}



// Note this is how we are going to test your CPU. Do not worry about this for
// now, as it requires a lot more instructions to function
// TEST_F(CpuTestbench, Return5Test)
// {
//     system("./compile.sh c/return_5.c");
//     runSimulation(100);
//     EXPECT_EQ(top->a0, 5);
// }

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}