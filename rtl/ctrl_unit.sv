module ctrl_unit (
    input   logic [31:0] instr,
    input   logic EQ,
    output  logic PCsrc,
    output  logic ResultSrc,
    output  logic MemWrite,
    output  logic [2:0] ALUctrl,
    output  logic ALUsrc,
    output  logic [1:0] ImmSrc,
    output  logic RegWrite
);

    logic [6:0] op;
    logic [2:0] funct3;
    logic funct7;

    assign op     = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[30];

    always_comb begin
        case (op)
            7'b0110011: begin // R-type
                RegWrite = 1;
                ALUsrc = 0;
                ImmSrc = 0;
                PCsrc = 0;
                ALUctrl = funct3; // Use funct3 for ALU control
            end
            7'b0000011: begin // Load
                RegWrite = 1;
                ALUsrc = 1;
                ImmSrc = 1; // Immediate source for load
                PCsrc = 0;
                ALUctrl = funct3; // Use funct3 for ALU control
            end
            7'b0100011: begin // Store
                RegWrite = 0; // No write back for store
                ALUsrc = 1;
                ImmSrc = 1; // Immediate source for store
                PCsrc = 0;
                ALUctrl = funct3; // Use funct3 for ALU control
            end
            default: begin // Default case, no operation
                RegWrite = 0;
                ALUsrc = 0;
                ImmSrc = 0;
                PCsrc = 0;
                ALUctrl = '0; // No operation
            end
        endcase
    end

endmodule
