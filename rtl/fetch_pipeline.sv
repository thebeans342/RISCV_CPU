`include "def.sv"

module fetch_pipeline (
    input logic clk, 
    input logic rst,
    input logic flush,
    input logic [31:0] instr,
    input logic [31:0] PCF,
    output logic [31:0] instrD,
    output logic [31:0] PCD
);

    always_ff @(posedge clk) begin
        if (flush) begin
            instrD <= 32'b0;
            PCD <= 32'b0;
        end
         if (clk) begin
            instrD <= instr;
            PCD <= PCF;
        end
    end

endmodule
