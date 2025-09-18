#include "top_testbench.h"
#include <cstdlib>

#define CYCLES 1000000

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
    //system("./compile.sh asm/assembly_test.S");
    system("./compile.sh asm/bge.S");

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
        if (top->a0 == 5)
        {
            SUCCEED();
            success = true;
            break;
        }
    }
    if (!success)
    {
        FAIL() << "a0 did not reach 20, it reached " << top->a0;
    }
}

// TEST_F(CpuTestbench, ALUInstructionTest)
// {
//     //system("./compile.sh asm/assembly_test.S");

//     setupTest("alutest");  // asm/alu.s -> program.hex
//     initSimulation();

//     runSimulation(100); // Enough to finish executing all instructions

//     // Check register values: result of each instruction
//     EXPECT_EQ(top->reg_content[10], 20);   // ADD: 15 + 5
//     EXPECT_EQ(top->reg_content[11], 10);   // SUB: 15 - 5
//     EXPECT_EQ(top->reg_content[12], 5);    // AND: 15 & 5
//     EXPECT_EQ(top->reg_content[13], 15);   // OR: 15 | 5
//     EXPECT_EQ(top->reg_content[14], 10);   // XOR: 15 ^ 5
//     EXPECT_EQ(top->reg_content[15], 480);  // SLL: 15 << 5
//     EXPECT_EQ(top->reg_content[16], 0);    // SRL: 15 >> 5
//     EXPECT_EQ(top->reg_content[17], 0);    // SRA: 15 >> 5 (signed)
//     EXPECT_EQ(top->reg_content[18], 0);    // SLTU: 15 < 5 → false
// }

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