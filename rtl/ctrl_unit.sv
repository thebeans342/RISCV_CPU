module ctrl_unit (
    input   logic [31:0]    instr,
    input   logic           EQ,
    output  logic           PCsrc,
    //output  logic ResultSrc,
    //output  logic MemWrite,
    output  logic [2:0]     ALUctrl,
    output  logic           ALUsrc,
    output  logic [1:0]     ImmSrc,
    output  logic           RegWrite
);

    logic [6:0] op;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign op     = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];

    always_comb begin
        case (op)
            //ALUop == 00
            7'b0000011: begin // load
                RegWrite = 1;
                ImmSrc = 2'b00; 
                ALUsrc = 1;
                PCsrc = 0;
                ALUctrl = funct3;
            end
            //ALUop == 00
            7'b0100011: begin // store
                RegWrite = 0;
                ImmSrc = 2'b01; 
                ALUsrc = 1;
                PCsrc = 0;
                ALUctrl = funct3;
            end
            //ALUop == 10
            7'b0110011: begin // R-type
                RegWrite = 1; 
                ImmSrc = 2'b00; 
                ALUsrc = 0;
                PCsrc = 0;

                case(funct3)
                    3'b000: begin // add
                        ALUctrl = (funct7 == 7'b0000000) ? 3'b000 : 3'b001; // add or sub
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
                    default: begin // other R-type operations
                        ALUctrl = '0; // No operation
                    end
                endcase
            end
            //ALUop == 01
            7'b1100011: begin // beq
                RegWrite = 0; 
                ImmSrc = 2'b10;
                ALUsrc = 0; 
                PCsrc = EQ; // PC source depends on equality check
                ALUctrl = funct3;
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
