//EQ == equal to or greater than
module ALUctrl_MUX #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  in0,
    input   logic [DATA_WIDTH-1:0]  in1,
    input   logic [2:0]             ALUctrl,
    output  logic [DATA_WIDTH-1:0]  ALUout,
    output  logic EQ
);
    always_comb begin
        case (ALUctrl)
            3'b0: begin
                ALUout = in0 + in1;
                EQ = (in0 == in1);
            end
            3'b001: begin
                ALUout = in0 - in1; 
                EQ = (in0 == in1);
            end
            3'b010: begin
                ALUout = in0 & in1; 
                EQ = (in0 == in1);
            end
            3'b011: begin
                ALUout = in0 | in1;
                EQ = (in0 == in1);
            end
            3'b100: begin
                ALUout = in0 ^ in1;
                EQ = (in0 == in1);
            end
            default: begin
                ALUout = '0; 
                EQ = 1'b0;
            end
        endcase
    end


endmodule