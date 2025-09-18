`include "def.sv"

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
                ALUctrl = `ADD_ALUCTRL;
            end
            2'b01:  // b-type
                case (funct3)
                    `BEQ_FUNCT3: ALUctrl = 4'b0001; // beq
                    `BNE_FUNCT3: ALUctrl = 4'b0001; // bne
                    `BLT_FUNCT3: ALUctrl = 4'b1000; // blt
                    `BGE_FUNCT3: ALUctrl = 4'b1000; // bge
                    `BLTU_FUNCT3: ALUctrl = 4'b1001; // bltu
                    `BGEU_FUNCT3: ALUctrl = 4'b1001; // bgeu
                    default: ALUctrl = 4'b000; // default to add
                endcase
            2'b10: begin // S-type
                case (funct3)
                    `ADDSUB_FUNCT3: 
                        case ({opcode[5], funct7[5]}) 
                            2'b00: ALUctrl = 4'b0000; //add
                            2'b01: ALUctrl = 4'b0000; //add
                            2'b10: ALUctrl = 4'b0000; //add
                            2'b11: ALUctrl = 4'b0001; // sub
                            default: ALUctrl = 4'b010; // default to and
                        endcase
                    `SLL_FUNCT3: ALUctrl = 4'b0101; // sll
                    `SLT_FUNCT3: ALUctrl = 4'b1000; // slt
                    `SLTU_FUNCT3: ALUctrl = 4'b1001; // sltu
                    `XOR_FUNCT3: ALUctrl = 4'b0100; // xor
                    `SR_FUNCT3: 
                        case (funct7) 
                            7'b0: ALUctrl = 4'b0110; // srl
                            7'b0010000: ALUctrl = 4'b0111; // sra
                        endcase
                    `OR_FUNCT3: ALUctrl = 4'b0011; // or
                    `AND_FUNCT3: ALUctrl = 4'b0010; // and

                endcase
            end
            default: begin
                ALUctrl = 4'b000; // Default case to avoid latches
            end
        endcase
    end

endmodule
