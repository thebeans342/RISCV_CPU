module top #(
    DATA_WIDTH = 32
) (
    input   logic clk,
    input   logic rst,
    output  logic [DATA_WIDTH-1:0] a0    
);
    // assign a0 = 32'd5;
    logic [DATA_WIDTH-1:0] instr;
    logic EQ;
    logic PCsrc;
    logic [1:0] ResultSrc;
    logic MemWrite;
    logic [3:0] ALUctrl;
    logic ALUsrc;
    logic [2:0] ImmSrc;
    logic [1:0] ALUop;
    logic is_JALR;

    logic we;
    logic [DATA_WIDTH-1:0] ALUout; //wd
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUop2;
    
    logic [DATA_WIDTH-1:0] ImmOp;

    logic [DATA_WIDTH-1:0] PC_out;

    logic [DATA_WIDTH-1:0] read_data;

    PC PC (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .ImmOp(ImmOp),
        .PC_out(PC_out),
        .is_JALR(is_JALR),
        .ImmSrc(ImmSrc),
        .rd1(ALUop1)
    );

    instr_mem instr_mem (
        .rst(rst),
        .rda(PC_out),
        .dout(instr)
    );     

    extend extend (
        .instr(instr),
        .ImmSrc(ImmSrc),
        .ext_instr(ImmOp)
    );     

    ctrl_unit ctrl_unit (
        .instr(instr),
        .EQ(EQ),
        .PCsrc(PCsrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        //.ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmSrc(ImmSrc),
        .RegWrite(we),
        .ALUOp(ALUop),
        .is_JALR(is_JALR)
    );

    ALUctrl_unit ALUctrl_unit (
        .funct3(instr[14:12]),
        .funct7(instr[31:25]),
        .ALUop(ALUop), 
        .opcode(instr[6:0]),
        .ALUctrl(ALUctrl)
    );

    reg_file reg_file (
        .clk(clk),
        //.rst(rst),
        .we(we),
        .wd(read_data),
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd(instr[11:7]),
        .RD1(ALUop1),
        .RD2(regOp2),
        .a0(a0) 
    );

    ALU ALU (
        .ALUop1(ALUop1),
        .regop2(regOp2),
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmOp(ImmOp),
        .ALUout(ALUout),
        .EQ(EQ)
    );


    data_mem data_mem(
        .clk(clk),
        .wen(MemWrite),
        //.read_enable(ResultSrc),
        .ResultSrc(ResultSrc),
        .addr(ALUout),
        .write_data(regOp2),
        .read_data(read_data),
        .PC_out(PC_out) 
    );
    

endmodule
