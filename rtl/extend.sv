//
module extend(
    input   logic [12:0] instr,
    input   logic ImmSrc,
    output  logic [31:0] ext_instr
);

    assign ext_instr = 32'(signed'(instr));

endmodule