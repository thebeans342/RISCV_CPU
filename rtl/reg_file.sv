//rs1, rs2 == regiters containing first and second operand
// rd == register to write result to

module reg_file ( 
    input   logic clk,
    input   logic         we,
    input   logic [4:0]   rs1,
    input   logic [4:0]   rs2,
    input   logic [4:0]   rd,
    input   logic [1:0]   ResultSrc, 
    input   logic [31:0]  ALUResultW,
    input   logic [31:0]  ReadDataW,
    input   logic [31:0]  PCPlus4W,
    output  logic [31:0]  wd,
    output  logic [31:0]  RD1,
    output  logic [31:0]  RD2,
    output  logic [31:0]  a0 // For testing purposes, outputting a0 register content
);
    logic [31:0] reg_content [31:0];

    assign a0 = reg_content[10];

    always_comb begin 
        RD1 = reg_content[rs1];
        RD2 = reg_content[rs2];

        case(ResultSrc)
            2'b00: wd = ALUResultW; // From ALU
            2'b01: wd = ReadDataW; // From Data Memory
            2'b10: wd = PCPlus4W;  // From PC + 4 (for JAL/JALR)
            default: wd = 32'b0;  
        endcase// Default case (should not occur)
    end

    always_ff @ (negedge clk) begin
        if (we & rd != '0) begin
            reg_content[rd] <= wd;
            //$display("Writing to reg[%0d]: %h", rd, wd); // Debugging output
        end
    end

endmodule
