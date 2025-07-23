//EQ == equal to or greater than
module ALU #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  ALUop1,
    input   logic [DATA_WIDTH-1:0]  regop2,
    input   logic [2:0]             ALUctrl,
    input   logic                   ALUsrc,
    input   logic [DATA_WIDTH-1:0]  ImmOp,
    output  logic [DATA_WIDTH-1:0]  ALUout,
    output  logic EQ
);

    logic [DATA_WIDTH-1:0] ALUop2;
    assign ALUop2  = ALUsrc ? ImmOp : regop2;

    always_comb begin
        case (ALUctrl)
            3'b0: begin
                ALUout = ALUop1 + ALUop2;
                EQ = (ALUop1 == ALUop2);
            end
            3'b001: begin
                ALUout = ALUop1 - ALUop2; 
                EQ = (ALUop1 == ALUop2);
            end
            3'b010: begin
                ALUout = ALUop1 & ALUop2; 
                EQ = (ALUop1 == ALUop2);
            end
            3'b011: begin
                ALUout = ALUop1 | ALUop2;
                EQ = (ALUop1 == ALUop2);
            end
            3'b100: begin
                ALUout = ALUop1 ^ ALUop2;
                EQ = (ALUop1 == ALUop2);
            end
            default: begin
                ALUout = '0; 
                EQ = 1'b0;
            end
        endcase
    end


endmodule
