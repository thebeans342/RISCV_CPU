`include "def.sv"

module PCsrc_mux (
    input logic [6:0] opcode,
    input logic [2:0] funct3,

    input logic EQ,
    input logic ALUout,
    output logic PCsrc
);

    always_comb begin
        PCsrc = 0; // Default to not taking the branch
        case(opcode)
            `OPCODE_BRANCH: begin 
                case (funct3)
                    `BEQ_FUNCT3: PCsrc = EQ; //beq
                    `BNE_FUNCT3: PCsrc = !EQ; //bne
                    `BLT_FUNCT3: PCsrc = ALUout; //blt
                    `BGE_FUNCT3: PCsrc = !ALUout;//bge
                    `BLTU_FUNCT3: PCsrc = ALUout; //bltu
                    `BGEU_FUNCT3: PCsrc = !ALUout; //bgeu
                endcase  
            end
            `OPCODE_JALR: begin 
                PCsrc = 1;
            end
            `OPCODE_JAL: begin
                PCsrc = 1;
            end
            `OPCODE_AUIPC: begin
                PCsrc = 1;
            end
        endcase
    end
endmodule