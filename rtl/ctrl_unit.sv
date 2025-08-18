module ctrl_unit (
    input   logic [31:0]    instr,
    input   logic           EQ,
    output  logic           PCsrc,
    output  logic           ALUsrc,
    output  logic [2:0]     ImmSrc,
    output  logic           RegWrite,
    output  logic           MemWrite,
    output  logic [1:0]     ALUOp,
    output  logic [1:0]     ResultSrc, 
    output  logic           is_JALR
);

    logic [6:0] op;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign op     = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];

    always_comb begin
        // Default values for all signals
        RegWrite = 0;
        ALUsrc = 0;
        ImmSrc = 0;
        PCsrc = 0;
        MemWrite = 0;
        ALUOp = 2'b00; 
        is_JALR = 0;
        ResultSrc = 0;

        case (op)
            // load (I-type)
            7'b0000011: begin 
                RegWrite = 1;
                ImmSrc = 3'b000; 
                ALUsrc = 1;
                MemWrite = 0; 
                ALUOp = 2'b00; // Load operation uses ALU for address calculation
                ResultSrc = 1;
            end
            
            // store (S-type)
            7'b0100011: begin 
                ImmSrc = 3'b001; 
                ALUsrc = 1;
                MemWrite = 1; // Store operation writes to memory
                ALUOp = 2'b00; // Store operation uses ALU for address calculation
            end
            
            // R-type
            7'b0110011: begin
                RegWrite = 1; 
                ALUsrc = 0;
                MemWrite = 0; // R-type does not write to memory
                ALUOp = 2'b10; // R-type operations use ALU for computation

            end
            
            // I-type instructions (e.g., ADDI)
            7'b0010011: begin // addi and other I-type arithmetic
                RegWrite = 1;
                ImmSrc = 3'b000;
                ALUsrc = 1;
                MemWrite = 0; // I-type does not write to memory
                ALUOp = 2'b10; // I-type operations use ALU for computation
            end

            // Branch instructions (B-type)
            7'b1100011: begin 
                RegWrite = 0; 
                ImmSrc = 3'b010;
                ALUsrc = 0; 
                MemWrite = 0; // Branch instructions do not write to memory
                ALUOp = 2'b01; // Branch operations use ALU for comparison
                
                case (funct3)
                    3'b000: begin // beq
                        PCsrc = EQ;
                    end
                    3'b001: begin // bne
                        PCsrc = !EQ;
                    end
                    default: begin
                        PCsrc = 0;
                    end
                endcase
            end

            // jalr
            7'b1100111: begin 
                RegWrite = 1;
                ImmSrc = 3'b100;
                ALUsrc = 1;
                PCsrc = 1;
                MemWrite = 0; // jalr does not write to memory
                is_JALR = 1;
                ResultSrc = 2'b10; // jalr uses PC + 4 as result source
            end

            //jal
            7'b1101111: begin
                RegWrite = 1;
                ImmSrc = 3'b100;
                ALUsrc = 1;
                PCsrc = 1;
                MemWrite = 0;
                is_JALR = 0;
                ResultSrc = 2'b10; // jal uses PC + 4 as result source
            end
        endcase
    end
endmodule
