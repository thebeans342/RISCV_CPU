module data_mem #(
    DATA_WIDTH = 32
) (
    input   logic clk,
    input   logic wen,
    input   logic read_enable,
    input   logic [DATA_WIDTH-1:0] addr,
    input   logic [DATA_WIDTH-1:0] write_data,
    output  logic [DATA_WIDTH-1:0] read_data
);

    logic [DATA_WIDTH-1:0] mem [0:255];

    always_ff @(posedge clk) begin
        if (wen) begin
            // Write data to memory
            mem[addr] <= write_data;
        end
        else if (read_enable) begin
            read_data <= mem[addr];
        end
    end

    //assign read_data = mem[addr];
endmodule