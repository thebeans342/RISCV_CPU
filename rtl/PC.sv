module PC (
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic [31:0] ImmOp,
    output logic [31:0] PC_out
)
    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            PC_out <= 32'b0; 
        end else if (PCsrc) begin
            PC_out <= ImmOp + PC_out; // Update PC with immediate value
        end else begin
            PC_out <= PC_out + 4; // Increment PC by 4 for next instruction
        end
    end
endmodule