module ForwardAE_mux (
    input logic [1:0] ForwardAE,
    input logic [31:0] RD1E,
    input logic [31:0] ALUResultM,
    input logic [31:0] ResultW,
    output logic [31:0] ALUop1
);

    always_comb begin
        case (ForwardAE)
            2'b00: ALUop1 = RD1E; // No forwarding
            2'b01: ALUop1 = ResultW; // Forward from Writeback stage
            2'b10: ALUop1 = ALUResultM; // Forward from Memory stage
            default: ALUop1 = RD1E; // Default case
        endcase
    end
endmodule
