module data_mem #(
    DATA_WIDTH = 32,
    MEM_WIDTH = 8
) (
    input   logic clk,
    input   logic wen,
    input   logic [1:0] ResultSrc,
    input   logic [2:0] funct3,
    input   logic [DATA_WIDTH-1:0] addr,
    input   logic [DATA_WIDTH-1:0] write_data,
    input   logic [DATA_WIDTH-1:0] PC_out,
    output  logic [DATA_WIDTH-1:0] read_data
);

    logic [MEM_WIDTH-1:0] mem [2**17-1:0];

    initial begin
        $display("Loading data into data memory...");
        $readmemh("../rtl/program.hex", mem, 17'h10000, 17'h1FFFF);
    end

    always_comb begin
        case (ResultSrc)
            2'b00: read_data = addr;
            2'b01: 
                case(funct3)
                    3'b000: read_data = {{24{mem[addr][7]}}, mem[addr]}; // lb
                    3'b001: read_data = {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]}; // lh
                    3'b010: read_data = {mem[addr+3], mem[addr+2], mem[addr+1],mem[addr]}; //lw
                    3'b100: read_data = {24'b0, mem[addr]}; // lbu
                    // 3'b100: //lbu
                    //     case (addr[1:0])
                    //         2'b00: read_data = {24'b0, mem[addr][7:0]};
                    //         2'b01: read_data = {24'b0, mem[addr][15:8]};
                    //         2'b10: read_data = {24'b0, mem[addr][23:16]};
                    //         2'b11: read_data = {24'b0, mem[addr][31:24]};
                    //     endcase
                    3'b101: read_data = {16'b0, mem[addr+1], mem[addr]}; // lhu
                endcase
            2'b10: read_data = PC_out + 4;
        endcase
    end

    always_ff @(negedge clk) begin
        if (wen) begin
            $display("Writing to memory at %h: %h", addr, write_data); // Debugging output
            // Write data to memory
            case (funct3)
                3'b000: begin //sb
                    mem[addr] <= write_data[7:0];
                    $display("Writing to memory at %h: %h", addr, write_data[7:0]); // Debugging output
                end
                    
                3'b001: begin //sh
                    mem[addr] <= write_data[7:0];
                    mem[addr+1] <= write_data[15:8];
                    $display("Writing to memory at %h: %h", addr, write_data[15:0]); // Debugging output
                end

                3'b010: begin //sw
                    mem[addr] <= write_data[7:0];
                    mem[addr+1] <= write_data[15:8];
                    mem[addr+2] <= write_data[23:16];   
                    mem[addr+3] <= write_data[31:24];
                end
            endcase
        end
    end

endmodule
