module reg_file ( 
    input logic clk,
    input logic [31:0] instr,
    input logic we,
    input logic wd
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