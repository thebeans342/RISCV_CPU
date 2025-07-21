module instr_mem #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8
)
    input logic PC,
    input logic rst,
    //input logic [ADDR_WIDTH-1:0] wr_addr,
    input logic [ADDR_WIDTH-1:0] rd_addr,
    input logic [DATA_WIDTH-1:0] din,   
    output logic [DATA_WIDTH-1:0] dout
);
    logic [DATA_WIDTH-1:0] ram_array [(2**ADDR_WIDTH) - 1:0];

    always_ff @(posedge PC) begin
        // if (wr_en == 1'b1) begin
        //     ram_array[wr_addr] <= din;
        if (rd_en == 1'b1) begin
            dout <= ram_array[rd_addr];
    end
endmodule