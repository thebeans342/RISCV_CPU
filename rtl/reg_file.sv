//rs1, rs2 == regiters containing first and second operand
// rd == register to write result to

module reg_file ( 
    input   logic clk,
    input   logic         we,
    input   logic [31:0]  wd,
    input   logic [4:0]   rs1,
    input   logic [4:0]   rs2,
    input   logic [4:0]   rd,
    output  logic [31:0]  RD1,
    output  logic [31:0]  RD2,
    output  logic [31:0]  a0 // For testing purposes, outputting a0 register content
);
    logic [31:0] reg_content [31:0];

    assign a0 = reg_content[10];

    always_comb begin 
        RD1 = reg_content[rs1];
        RD2 = reg_content[rs2];
    end

    always_ff @ (negedge clk) begin
        if (we & rd != '0) begin
            reg_content[rd] <= wd;
            //$display("Writing to reg[%0d]: %h", rd, wd); // Debugging output
        end
    end

endmodule
