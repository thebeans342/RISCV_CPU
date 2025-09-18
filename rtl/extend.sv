`include "def.sv"

module extend(
    input   logic [31:0] instr,
    input   logic [2:0] ImmSrc,
    output  logic [31:0] ext_instr
);

    always_comb begin
        case (ImmSrc)
            `IMM_I: ext_instr = {{20{instr[31]}}, instr[31:20]}; // I-type
            `IMM_S: ext_instr = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
            `IMM_B: ext_instr = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
            `IMM_U: ext_instr = {instr[31:12], {12{1'b0}}}; // U-type
            `IMM_J: ext_instr = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0}; // J-type
            default: ext_instr = 32'h0; // Default case for safety
        endcase
    end

endmodule
