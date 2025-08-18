module PC (
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic is_JALR,
    input logic [2:0] ImmSrc,
    input logic [31:0] rd1,
    input logic [31:0] ImmOp,
    output logic [31:0] PC_out
);
    logic [31:0] PCnext;
    logic [31:0] PC_Target;

    always_comb begin
        PC_Target = is_JALR ? rd1 : PC_out;
        PCnext = PCsrc ? PC_Target + ImmOp: PC_out + 4;
    end

    always_ff @(posedge clk or posedge rst) begin
        PC_out <= rst ? 32'b0 : PCnext;
        //$display("PC_out: %h", PC_out); // Debugging output
    end

endmodule
