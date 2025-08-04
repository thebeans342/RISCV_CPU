module extend(
    input   logic [31:0] instr,
    input   logic [1:0] ImmSrc,
    output  logic [31:0] ext_instr
);

    always_comb begin
        case (ImmSrc)
            2'b00: begin // I-type
                ext_instr = {{20{instr[31]}}, instr[31:20]};
            end
            2'b01: begin // S-type
                ext_instr = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
            2'b10: begin // B-type
                ext_instr = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            end
            2'b11: begin // U-type
                ext_instr = {instr[31:12], 12'b0};
            end
            default: begin
                ext_instr = 32'b0; // Default case to avoid latches
            end
        endcase
    end

endmodule
