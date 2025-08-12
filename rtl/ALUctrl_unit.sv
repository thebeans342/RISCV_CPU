module ALUctrl_unit (
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [1:0] ALUop,
    input logic [6:0] opcode,
    output logic [3:0] ALUctrl
);
    always_comb begin
        case (ALUop)
            2'b00: begin // lw, sw
                ALUctrl = 4'b000;
            end
            2'b01: begin // beq
                ALUctrl = 4'b001; 
            end
            2'b10: begin // S-type
                case (funct3)
                    3'b000: 
                        case ({opcode[5], funct7[5]}) 
                            2'b00: ALUctrl = 4'b0000; //add
                            2'b01: ALUctrl = 4'b0000; //add
                            2'b10: ALUctrl = 4'b0000; //add
                            2'b11: ALUctrl = 4'b0001; // sub
                            default: ALUctrl = 4'b010; // default to and
                        endcase
                    3'b001: ALUctrl = 4'b0101; // sll
                    3'b010: ALUctrl = 4'b1000; // slt
                    3'b011: ALUctrl = 4'b1001; // sltu
                    3'b100: ALUctrl = 4'b0100; // xor
                    3'b101: 
                        case ({opcode[5], funct7[5]}) 
                            2'b10: ALUctrl = 4'b0110; // srl
                            2'b11: ALUctrl = 4'b0111; // sra
                        endcase
                    3'b110: ALUctrl = 4'b0011; // or
                    3'b111: ALUctrl = 4'b0010; // and

                endcase
            end
            default: begin
                ALUctrl = 4'b000; // Default case to avoid latches
            end
        endcase
    end

endmodule
