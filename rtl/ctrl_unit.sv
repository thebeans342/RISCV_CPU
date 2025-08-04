module ctrl_unit (
    input   logic [31:0]    instr,
    input   logic           EQ,
    output  logic           PCsrc,
    output  logic [2:0]     ALUctrl,
    output  logic           ALUsrc,
    output  logic [1:0]     ImmSrc,
    output  logic           RegWrite,
    output logic            MemWrite
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
        ALUctrl = 3'b000;
        MemWrite = 0;

        case (op)
            // load (I-type)
            7'b0000011: begin 
                RegWrite = 1;
                ImmSrc = 2'b00; 
                ALUsrc = 1;
                ALUctrl = funct3;
                MemWrite = 0; 
            end
            
            // store (S-type)
            7'b0100011: begin 
                ImmSrc = 2'b01; 
                ALUsrc = 1;
                ALUctrl = funct3;
                MemWrite = 1; // Store operation writes to memory
            end
            
            // R-type
            7'b0110011: begin
                RegWrite = 1; 
                ALUsrc = 0;
                MemWrite = 0; // R-type does not write to memory

                case(funct3)
                    3'b000: begin // add, sub
                        ALUctrl = (funct7 == 7'b0000000) ? 3'b000 : 3'b001;
                    end
                    3'b111: begin // and
                        ALUctrl = 3'b010;
                    end
                    3'b110: begin // or
                        ALUctrl = 3'b011;
                    end
                    3'b100: begin // xor
                        ALUctrl = 3'b100;
                    end
                    default: begin
                        ALUctrl = 3'b000;
                    end
                endcase
            end
            
            // I-type instructions (e.g., ADDI)
            7'b0010011: begin // addi and other I-type arithmetic
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUsrc = 1;
                MemWrite = 0; // I-type does not write to memory
                // funct3 = 3'b000 for addi
                ALUctrl = funct3; 
            end

            // Branch instructions (B-type)
            7'b1100011: begin 
                RegWrite = 0; 
                ImmSrc = 2'b10;
                ALUsrc = 0; 
                MemWrite = 0; // Branch instructions do not write to memory
                
                case (funct3)
                    3'b000: begin // beq
                        PCsrc = EQ;
                        ALUctrl = 3'b000; // ALU needs to perform subtract for comparison
                    end
                    3'b001: begin // bne
                        PCsrc = !EQ;
                        ALUctrl = 3'b000; // ALU needs to perform subtract for comparison
                    end
                    // Add other branch instructions here
                    default: begin
                        PCsrc = 0;
                        ALUctrl = 3'b000;
                    end
                endcase
            end

            // jalr
            7'b1100111: begin 
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUsrc = 1;
                PCsrc = 1;
                ALUctrl = 3'b000;
                MemWrite = 0; // jalr does not write to memory
            end

            default: begin
                // All signals remain at their default values
            end
        endcase
    end
endmodule
