module extend(
    input   logic [31:0] instr,
    input   logic ImmSrc,
    output  logic [31:0] ext_instr
);

    always_comb begin
        if (ImmSrc) begin
            //I type
            ext_instr = {{20{instr[31]}}, instr[31:20]}; 
        end else begin
            // S type
            ext_instr = {20'b0, instr[31:20]}; 
        end
    end

endmodule