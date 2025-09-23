`include "def.sv"

module PC (
    input logic             clk,
    input logic             rst,
    input logic             EQ,
    input logic             ALUout,
    input logic [2:0]       funct3,
    input logic             is_JALR,
    input logic             Jump,
    input logic [31:0]      rd1,
    input logic [31:0]      ImmOp,
    input logic             stall,
    input logic             PCsrc,
    output logic [31:0]     PCPlus4F,
    output logic [31:0]     PC_out
);
    logic [31:0] PCnext;
    logic [31:0] PC_Target;

    assign PCPlus4F = PC_out + 4;

    always_comb begin
        PC_Target = is_JALR ? rd1 : PC_out;
        PCnext = PCsrc ? PC_Target + ImmOp: PCPlus4F;
    end

    always_ff @(posedge clk or posedge rst) begin
        if(!stall)
            PC_out <= rst ? 32'b0 : PCnext;

        //$display("PC_out: %h", PC_out); // Debugging output
    end

endmodule
