module top #(
    DATA_WIDTH = 32
) (
    input   logic clk,
    input   logic rst,
    output  logic [DATA_WIDTH-1:0] a0    
);
    assign a0 = 32'd5;
    logic [DATA_WIDTH-1:0] instr;
    logic EQ;
    logic PCsrc;
    logic ResultSrc;
    logic MemWrite;
    logic [2:0] ALUctrl;
    logic ALUsrc;
    logic [1:0] ImmSrc;
    logic RegWrite;

    logic we;
    logic [DATA_WIDTH-1:0] ALUout; //wd
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUop2;
    
    logic [DATA_WIDTH-1:0] ImmOp;

    logic [DATA_WIDTH-1:0] PC_out;

    

endmodule