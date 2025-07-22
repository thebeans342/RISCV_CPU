#include "top_testbench.h"
#include <cstdint>
#include <gtest/gtest.h>

unsigned int ticks = 0;

class DDRPixelOutTop : public BaseTestbench {
protected:
    Vdut* s;
    
    void initializeInputs() override {
        s = top.get();
        s->m00_axis_aresetn = 1;
        s->m00_axis_aclk = 1;
        s->m00_axis_tvalid = 1;
    }

    void runSimulation(int cycles = 1)
    {
        for (int i = 0; i < cycles; i++)
        {
            for (int m00_axis_aclk = 0; m00_axis_aclk < 2; m00_axis_aclk++)
            {
                top->eval();
#ifndef __APPLE__
                tfp->dump(2 * ticks + m00_axis_aclk);
#endif
                top->m00_axis_aclk = !top->m00_axis_aclk;
            }
            ticks++;

            if (Verilated::gotFinish())
            {
                exit(0);
            }
        }
    }

};


TEST_F(DDRPixelOutTop, TestDataLoad) {
    VlWide<5> data = {0x55667788, 0x11223344, 0, 0, 0}; // 64-bit LSB packed, rest zero
    VlWide<5> data2 = {0x43257893, 0x43231278, 0, 0, 0}; // 64-bit LSB packed, rest zero
    for (int i = 0; i < 20; ++i) {
        s->read_addr = i;
        runSimulation(1);
    }
    
    for (int i = 0; i < 5; ++i) {
        s->m00_axis_tdata[i] = data[i];
    }
    runSimulation(4);
    s->chunk_transfer_ready = 1;
    for (int i = 0; i < 5; ++i) {
        s->m00_axis_tdata[i] = data2[i];
    }
    runSimulation(10);
    s->chunk_transfer_ready = 0;
    runSimulation(5);
    s->m00_axis_tlast = 1;
    runSimulation(10);
}


int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}