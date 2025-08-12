//EQ == equal to or greater than
//For the following R type instructions:
//add, sub, and, or, slt, sll, srl, xor
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
            4'b0: ALUout = ALUop1 + ALUop2;
            //SUB
            4'b0001: ALUout = ALUop1 - ALUop2; 
            //AND
            4'b0010: ALUout = ALUop1 & ALUop2; 
            //OR
            4'b0011: ALUout = ALUop1 | ALUop2;
            //XOR
            4'b0100: ALUout = ALUop1 ^ ALUop2;
            //SLL = shift left logical
            4'b0101: ALUout = ALUop1 << ALUop2; 
            //SRL = logical shift right, shifts in zeros
            4'b0110: ALUout = ALUop1 >> ALUop2; 
            //SRA = arithmetic shift right, shifts in sign bit
            4'b0111: ALUout = ALUop1 >>> $signed(ALUop2);
            //SLT = set if less than
            4'b1000: ALUout = ($signed(ALUop1) < $signed(ALUop2)) ? {31'b0, 1'b1} : 32'b0; 
            //SLTU = SLT (unsigned)
            4'b1001: ALUout = (ALUop1 < ALUop2) ? {31'b0, 1'b1} : 32'b0;
            default: begin
                ALUout = '0; 
            end
        endcase
    end


endmodule
