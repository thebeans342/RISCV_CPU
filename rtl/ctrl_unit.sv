module ctrl_unit (
    input   logic [31:0] instr,
    input   logic EQ,
    output  logic RegWrite,
    output  logic ALUctrl,
    output  logic ALUsrc,
    output  logic ImmSrc,
    output  logic PCcsrc 
);
    assign op <= instr[6:0];
    assign funct3 <= instr[14:12];
    assign funct7 <= instr[30];

    

endmodule
