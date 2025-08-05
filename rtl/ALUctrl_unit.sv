module ALUctrl_unit (
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [1:0] ALUop,
    input logic [6:0] op,
    output logic [2:0] ALUctrl
);
    always_comb begin
        case (ALUop)
            2'b00: begin // lw, sw
                ALUctrl = 3'b000;
            end
            2'b01: begin // beq
                ALUctrl = 3'b001; 
            end
            2'b10: begin // S-type
                case (funct3)
                    3'b000: 
                        case ({op[5], funct7[5]}) 
                            2'b00: ALUctrl = 3'b000;
                            2'b01: ALUctrl = 3'b000; 
                            2'b10: ALUctrl = 3'b000;
                            2'b11: ALUctrl = 3'b001; // sub
                            default: ALUctrl = 3'b010; // default to and
                        endcase
                    3'b010: 
                        ALUctrl = 3'b101; // slt
                    3'b110:
                        ALUctrl = 3'b011; // or
                    3'b111:
                        ALUctrl = 3'b010; // and
                endcase
            end
            default: begin
                ALUctrl = 3'b000; // Default case to avoid latches
            end
        endcase
    end

endmodule
