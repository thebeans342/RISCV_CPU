`include "def.sv"

module fetch_pipeline (
    input logic clk, 
    input logic rst,
    input logic flush,
    input logic stall,
    input logic [31:0] instr,
    input logic [31:0] PCF,
    input logic [31:0] PCPlus4F,
    output logic [31:0] instrD,
    output logic [31:0] PCD,
    output logic [31:0] PCPlus4D
);

    always_ff @(posedge clk) begin
        if (flush) begin
            instrD <= 32'b0;
            PCD <= 32'b0;
        end
         if (!stall) begin
            instrD <= instr;
            PCD <= PCF;
            PCPlus4D <= PCPlus4F;
        end
    end

endmodule
