module data_mem #(
    DATA_WIDTH = 32,
    MEM_WIDTH = 8
) (
    input   logic clk,
    input   logic wen,
    input   logic ResultSrc,
    input   logic [DATA_WIDTH-1:0] addr,
    input   logic [DATA_WIDTH-1:0] write_data,
    output  logic [DATA_WIDTH-1:0] read_data
);

    logic [MEM_WIDTH-1:0] mem [2**17-1:0];

    // initial begin
    //     $display("Loading data into data memory...");
    //     $readmemh("../rtl/data.hex", mem, 8'h10, 8'h1F);
    // end

    always_comb begin
        read_data = ResultSrc ? {mem[addr+3], mem[addr+2], mem[addr+1],mem[addr]} : addr;
    end

    always_ff @(negedge clk) begin
        if (wen && ResultSrc) begin
            // Write data to memory
            mem[addr] <= write_data[7:0];
            mem[addr+1] <= write_data[15:8];
            mem[addr+2] <= write_data[23:16];   
            mem[addr+3] <= write_data[31:24];
        end
    end

    //assign read_data = mem[addr];
endmodule
