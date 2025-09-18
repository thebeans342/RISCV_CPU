`include "def.sv"

module ALU #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  ALUop1,
    input   logic [DATA_WIDTH-1:0]  regop2,
    input   logic [3:0]             ALUctrl,
    input   logic                   ALUsrc,
    input   logic [DATA_WIDTH-1:0]  ImmOp,
    output  logic [DATA_WIDTH-1:0]  ALUout,
    output  logic EQ
);

    logic [DATA_WIDTH-1:0] ALUop2;
    assign ALUop2  = ALUsrc ? ImmOp : regop2;

    always_comb begin
        EQ = (ALUop1 == ALUop2) ? 1 : 0; // Default case
        
        case (ALUctrl)
            //ADD
            `ADD_ALUCTRL: ALUout = ALUop1 + ALUop2;
            //SUB
            `SUB_ALUCTRL: ALUout = ALUop1 - ALUop2; 
            //AND
            `AND_ALUCTRL: ALUout = ALUop1 & ALUop2; 
            //OR
            `OR_ALUCTRL: ALUout = ALUop1 | ALUop2;
            //XOR
            `XOR_ALUCTRL: ALUout = ALUop1 ^ ALUop2;
            //SLL = shift left logical
            `SLL_ALUCTRL: ALUout = ALUop1 << ALUop2; 
            //SRL = logical shift right, shifts in zeros
            `SRL_ALUCTRL: ALUout = ALUop1 >> ALUop2; 
            //SRA = arithmetic shift right, shifts in sign bit
            `SRA_ALUCTRL: ALUout = ALUop1 >>> $signed(ALUop2);
            //SLT = set if less than
            `SLT_ALUCTRL: ALUout = ($signed(ALUop1) < $signed(ALUop2)) ? {31'b0, 1'b1} : 32'b0; 
            //SLTU = SLT (unsigned)
            `SLTU_ALUCTRL: ALUout = (ALUop1 < ALUop2) ? {31'b0, 1'b1} : 32'b0;
            default: begin
                ALUout = '0; 
            end
        endcase
    end


endmodule
