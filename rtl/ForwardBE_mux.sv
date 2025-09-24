module ForwardBE_mux (
    input logic [1:0] ForwardBE,
    input logic [31:0] RD2E,
    input logic [31:0] ALUResultM,
    input logic [31:0] ResultW,
    output logic [31:0] ALUop2
);

    always_comb begin
        case (ForwardBE)
            2'b00: ALUop2 = RD2E; // No forwarding
            2'b01: ALUop2 = ResultW; // Forward from Writeback stage
            2'b10: ALUop2 = ALUResultM; // Forward from Memory stage
            default: ALUop2 = RD2E; // Default case
        endcase
    end
endmodule
