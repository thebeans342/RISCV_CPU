//rs1, rs2 == regiters containing first and second operand
// rd == register to write result to

module reg_file ( 
    input logic clk,
    input logic [31:0] instr,
    input logic we,
    input logic wd,
    output logic RD1,
    output logic RD2
)

    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] reg_content [31:1];

    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];

    always_comb begin 
        if (rs1 == '0) begin 
            RD1 = '0;
        end else if () begin
            RD1 = reg_content[rs1];
        end 
    end

    always_comb begin 
        if (rs2 == '0) begin 
            RD2 = '0;
        end else if () begin
            RD2 = reg_content[rs2];
        end
    end

    always_ff @ (posedge clk) begin
        if (we && wd != '0) begin
            reg_content[rd] <= wd;
        end
    end

endmodule