module instr_mem #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input logic rst,
    //input logic [ADDR_WIDTH-1:0] wr_addr,
    input logic [ADDR_WIDTH-1:0] rd_addr,
    //input logic [DATA_WIDTH-1:0] din,   
    output logic [DATA_WIDTH-1:0] dout
);
    logic [DATA_WIDTH-1:0] ram_array [(2**ADDR_WIDTH) - 1:0];

    assign dout = ram_array[rd_addr];

endmodule
