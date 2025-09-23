`include "def.sv"

module decode_pipeline (
    input logic clk,
    input logic rst,
    input logic flush,
    
    input logic RegWriteD,
    input logic [1:0] ResultSrcD,
    input logic is_JALR_D,
    input logic [3:0] ALUctrlD,
    input logic ALUsrcD,
    input logic PCsrcD,

    input logic [31:0] RD1D,
    input logic [31:0] RD2D,
    input logic [31:0] PCD,
    input logic [4:0] Rs1D,
    input logic [4:0] Rs2D,
    input logic [4:0] RdD,
    input logic [31:0] ImmExtD,
    input logic [31:0] PCPlus4D,

    output logic RegWriteE,
    output logic [1:0] ResultSrcE,
    output logic MemWriteE,
    output logic is_JALR_E,
    output logic [3:0] ALUctrlE,
    output logic ALUsrcE,
    output logic PCsrcE,

    output logic [31:0] RD1E,
    output logic [31:0] RD2E,
    output logic [31:0] PCE,
    output logic [4:0] Rs1E,
    output logic [4:0] Rs2E,
    output logic [4:0] RdE,
    output logic [31:0] ImmExtE,
    output logic [31:0] PCPlus4E

);

    always_ff @(posedge clk) begin
        if (flush) begin
            RegWriteE <= 0;
            ResultSrcE <= 0; 
            is_JALR_E <= 0;
            ALUctrlE <= 0;
            ALUsrcE <= 0;
            PCsrcE <= 0;

            RD1E <= 0;
            RD2E <= 0;
            Rs1E <= 0;
            Rs2E <= 0;
            PCE <= 0;
            RdE <= 0;
            ImmExtE <= 0;
            PCPlus4E <= 0;
        end else if (clk) begin
            RegWriteE <= RegWriteD;
            ResultSrcE <= ResultSrcD; 
            is_JALR_E <= is_JALR_D;
            ALUctrlE <= ALUctrlD;
            ALUsrcE <= ALUsrcD;
            PCsrcE <= PCsrcD;

            RD1E <= RD1D;
            RD2E <= RD2D;
            PCE <= PCD;
            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;
            ImmExtE <= ImmExtD;
            PCPlus4E <= PCPlus4D;
        end
    end

endmodule
