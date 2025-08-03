module extend(
    input   logic [31:0] instr,
    input   logic ImmSrc,
    output  logic [31:0] ext_instr
);

    always_comb begin
        ext_instr = ImmSrc ? {{20{instr[31]}}, instr[31:25], instr[11:7]} : {{20{instr[31]}}, instr[31:20]};
    end

endmodule
