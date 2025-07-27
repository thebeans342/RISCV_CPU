#pragma once

#include <memory>
#include "Vdut.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"

#define MAX_SIM_CYCLES 10000

class BaseTestbench : public ::testing::Test
{
public:
    void runSimulation(int cycles = 1)
    {
        for (int i = 0; i < cycles; i++)
        {
            for (int clk = 0; clk < 2; clk++)
            {
                top->eval();
                tfp->dump(2 * ticks + clk);
                top->clk = !top->clk;
            }
            ticks++;
        }

        if (Verilated::gotFinish())
            exit(0);
    }

    void SetUp() override
    {
        top = new Vdut;
        tfp = new VerilatedVcdC;

        Verilated::traceEverOn(true);
        top->trace(tfp, 99);
        tfp->open("waveform.vcd");

        ticks = 0;
        initializeInputs();
    }

    void TearDown() override
    {
        top->final();
        tfp->close();

        delete top;
        delete tfp;
    }

    virtual void initializeInputs() = 0;

protected:
    Vdut* top;
    VerilatedVcdC* tfp;
    unsigned int ticks = 0;
};
