`include "def.sv"

module hazard_unit(
    input logic [4:0] Rs1D,
    input logic [4:0] Rs2D,
    input logic [4:0] Rs1E,
    input logic [4:0] Rs2E,

    input logic       RegWriteW,
    input logic       RegWriteM,
    input logic       RegWriteE,
    input logic       RegWriteD,

    input logic [4:0] RdD,
    input logic [4:0] RdE,
    input logic [4:0] RdM,
    input logic [4:0] RdW,

    input logic [31:0] RD1E,
    input logic [31:0] RD2E,

    input logic [31:0] ALUResultM,
    input logic [31:0] ResultW,

    input logic        PCsrcE,
    input logic        ReadMemD,
    input logic        ReadMemE,

    output logic [1:0] ForwardAE,
    output logic [1:0] ForwardBE,
    output logic       stall,
    output logic       flush
);

    always_comb begin
        flush = 0;
        stall = 0;
        ForwardAE = 0;
        ForwardBE = 0;

        if((Rs1E == RdW) && RegWriteW) 
            ForwardAE = 2'b01;
        if((Rs2E == RdW) && RegWriteW) 
            ForwardBE = 2'b01;
        if((RdM == Rs1E) && RegWriteM) 
            ForwardAE = 2'b10;
        if((RdM == Rs2E) && RegWriteM) 
            ForwardBE = 2'b10;


        //load instructions
        if((Rs1D == RdE) && ReadMemE)
            stall = 1;
        if((Rs2D == RdE) && ReadMemE)
            stall = 1;


        //branch instructions
        if(PCsrcE == 1)
            flush = 1;
    end
        
endmodule
