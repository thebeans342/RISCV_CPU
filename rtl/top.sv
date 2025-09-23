module top #(
    DATA_WIDTH = 32
) (
    input   logic clk,
    input   logic rst,
    output  logic [DATA_WIDTH-1:0] a0    
);
    // assign a0 = 32'd5;
    //ctrl unit
    logic [DATA_WIDTH-1:0] instr;
    logic EQ;
    logic PCsrcE;

    logic [1:0] ResultSrcD;
    logic [1:0] ResultSrcE;
    logic [1:0] ResultSrcM;
    logic [1:0] ResultSrcW;

    logic MemWriteD;
    logic MemWriteE;
    logic MemWriteM;

    logic [3:0] ALUctrlD;
    logic [3:0] ALUctrlE;
 
    logic ALUsrcD;
    logic ALUsrcE;

    logic [2:0] ImmSrcD;
    logic [1:0] ALUop;

    logic is_JALR_D;
    logic is_JALR_E;

    logic ReadMem;
    logic Jump;

    //regfile
    logic [4:0] Rs1D;
    logic [4:0] Rs2D;
    logic [4:0] Rs1E;
    logic [4:0] Rs2E;

    logic RegWriteD;
    logic RegWriteE;
    logic RegWriteM;
    logic RegWriteW;

    logic [DATA_WIDTH-1:0] PCPlus4D;
    logic [DATA_WIDTH-1:0] PCPlus4E;
    logic [DATA_WIDTH-1:0] PCPlus4M;
    logic [DATA_WIDTH-1:0] PCPlus4W;

    logic [DATA_WIDTH-1:0] WriteDataM;

    logic [DATA_WIDTH-1:0] ALUResultM;
    logic [DATA_WIDTH-1:0] ALUResultW;

    logic [DATA_WIDTH-1:0] RD1D;
    logic [DATA_WIDTH-1:0] RD2D;
    logic [DATA_WIDTH-1:0] RD1E;
    logic [DATA_WIDTH-1:0] RD2E;

    logic [DATA_WIDTH-1:0] ALUout; //wd
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUop2;
    
    logic [DATA_WIDTH-1:0] ImmExtD;
    logic [DATA_WIDTH-1:0] ImmExtE; 

    logic [DATA_WIDTH-1:0] PC_out;

    logic [DATA_WIDTH-1:0] read_data;

    logic [DATA_WIDTH-1:0] instrD;

    logic [DATA_WIDTH-1:0] PCD;
    logic [DATA_WIDTH-1:0] PCE;

    logic [DATA_WIDTH-1:0] ReadDataW; 
    logic [DATA_WIDTH-1:0] ReadDataM;
    
    logic [4:0] RdD;
    logic [4:0] RdE;
    logic [4:0] RdM;
    logic [4:0] RdW; 

    //hazard unit
    logic [1:0] ForwardAE;
    logic [1:0] ForwardBE;
    logic stall;
    logic flush;


    assign RdD = instrD[11:7];
    assign Rs1D = instrD[19:15];
    assign Rs2D = instrD[24:20];

    PC PC (
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .EQ(EQ),
        .Jump(Jump),
        .ALUout(ALUout[0]),
        .funct3(instrD[14:12]),
        .is_JALR(is_JALR_E),
        .rd1(RD1E),
        .ImmOp(ImmExtE),
        .PCsrc(PCsrcE),
        .PC_out(PC_out)
    );

    instr_mem instr_mem (
        .rst(rst),
        .rda(PC_out),
        .dout(instr)
    );     

    fetch_pipeline fetch_pipeline (
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .flush(flush),
        .PCF(PC_out),
        .instrD(instrD),
        .PCD(PCD)
    );

    extend extend (
        .instr(instrD),
        .ImmSrc(ImmSrcD),
        .ext_instr(ImmExtD)
    );     

    ctrl_unit ctrl_unit (
        .instr(instrD),
        .EQ(EQ),
        .ResultSrc(ResultSrcD),
        .MemWrite(MemWriteD),
        .ALUsrc(ALUsrcD),
        .ImmSrc(ImmSrcD),
        .RegWrite(RegWriteD),
        .ALUOp(ALUop),
        .is_JALR(is_JALR_D),
        .ALUout(ALUout),
        .ReadMem(ReadMem),
        .PCsrc(PCsrc)
    );

    ALUctrl_unit ALUctrl_unit (
        .funct3(instrD[14:12]),
        .funct7(instrD[31:25]),
        .ALUop(ALUop), 
        .opcode(instrD[6:0]),
        .ALUctrl(ALUctrlD)
    );

    decode_pipeline decode_pipeline (
        .clk(clk),
        .rst(rst),
        .flush(flush),
        .RegWriteD(RegWriteD),
        .ResultSrcD(ResultSrcD),
        .is_JALR_D(is_JALR_D),
        .ALUctrlD(ALUctrlD),
        .ALUsrcD(ALUsrcD),
        .PCsrcD(PCsrc),
        .RD1D(RD1D),
        .RD2D(RD2D),
        .PCD(PCD),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RdD(RdD),
        .ImmExtD(ImmExtD),
        .PCPlus4D(PCPlus4D),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .is_JALR_E(is_JALR_E),
        .ALUctrlE(ALUctrlE),
        .ALUsrcE(ALUsrcE),
        .PCsrcE(PCsrcE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E)
    );

    reg_file reg_file (
        .clk(clk),
        //.rst(rst),
        .we(RegWriteW),
        .wd(read_data),
        .rs1(Rs1D),
        .rs2(Rs2D),
        .rd(instrD[11:7]),
        .ResultSrc(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .RD1(ALUop1),
        .RD2(regOp2),
        .a0(a0) 
    );

    ALU ALU (
        .ALUop1(ALUop1),
        .regop2(regOp2),
        .ALUctrl(ALUctrlE),
        .ALUsrc(ALUsrcE),
        .ImmOp(ImmExtE),
        .ALUout(ALUout),
        .EQ(EQ)
    );

    execute_pipeline execute_pipeline (
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .ALUresult(ALUout),
        .WriteDataE(regOp2),
        .RdE(RdE),
        .PCPlus4E(PCPlus4E),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M)
    );


    data_mem data_mem(
        .clk(clk),
        .wen(MemWriteM),
        .ResultSrc(ResultSrcW),
        .addr(ALUResultW),
        .write_data(WriteDataM),
        .read_data(ReadDataM),
        .PC_out(PCPlus4W),
        .funct3(instr[14:12]) 
    );

    memory_pipeline memory_pipeline (
        .clk(clk),
        .rst(rst),
        .ALUResultM(ALUResultM),
        .RDM(read_data),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W)
    );

    hazard_unit hazard_unit (
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RegWriteW(RegWriteW),
        .RegWriteM(RegWriteM),
        .RdE(RdE),
        .RdM(RdM),
        .RdW(RdW),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ALUResultM(ALUResultM),
        .ResultW(read_data),
        .PCsrcE(PCsrcE),
        .ReadMem(ReadMem),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .stall(stall),
        .flush(flush)
    );
    

endmodule
