module PC (
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic [31:0] ImmOp,
    output logic [31:0] PC_out
);
    logic [31:0] next_PC;

    always_comb begin
        next_PC = PCsrc ? PC_out + ImmOp : PC_out + 4;
    end

    always_ff @(posedge clk or posedge rst) begin
        PC_out <= rst ? 32'b0 : next_PC;
        //$display("PC_out: %h", PC_out); // Debugging output
    end

endmodule
