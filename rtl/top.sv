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

    logic we;
    logic [DATA_WIDTH-1:0] ALUout; //wd
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUop2;
    
    logic [DATA_WIDTH-1:0] ImmOp;

    logic [DATA_WIDTH-1:0] PC_out;

    PC PC (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .ImmOp(ImmOp),
        .PC_out(PC_out)
    );

    instr_mem instr_mem (
        .rst(rst),
        .rda(PC_out),
        .dout(instr)
    );     

    extend extend (
        .instr(instr),
        .ImmSrc(ImmSrc[0]),
        .ext_instr(ImmOp)
    );     

    ctrl_unit ctrl_unit (
        .instr(instr),
        .EQ(EQ),
        .PCsrc(PCsrc),
        //.ResultSrc(ResultSrc),
        //.MemWrite(MemWrite),
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmSrc(ImmSrc),
        .RegWrite(we)
    );

    reg_file reg_file (
        .clk(clk),
        //.rst(rst),
        .we(we),
        .wd(ALUout),
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

    // always_ff @(posedge clk) begin
    //     $display("PC: %h, instr: %h, a0: %h", PC_out, instr, a0);
    // end


    // data_mem #(
    //     .DATA_WIDTH(DATA_WIDTH)
    // ) data_mem (
    //     .clk(clk),
    //     .wen(MemWrite),
    //     .read_enable(ResultSrc),
    //     .addr(ALUout[DATA_WIDTH-1:0]),
    //     .write_data(regOp2),
    //     .read_data(instr[11:7]) // Assuming read_data is used for some purpose
    // );
    

endmodule
