module instr_mem #(
    parameter ADDR_WIDTH = 12,
    parameter DATA_WIDTH = 32,
    parameter MEM_WIDTH = 8
)(
    input logic rst,
    //input logic [ADDR_WIDTH-1:0] wr_addr,
    input logic [DATA_WIDTH-1:0] rda,
    //input logic [DATA_WIDTH-1:0] din,   
    output logic [DATA_WIDTH-1:0] dout
);
    logic [MEM_WIDTH-1:0] ram_array [(2**ADDR_WIDTH) - 1:0];

    initial begin
        $display("Loading RAM");
        $readmemh("../rtl/program.hex", ram_array);
        $display("RAM loaded successfully");
    end

    assign dout = {ram_array[rda+3], ram_array[rda+2], ram_array[rda+1], ram_array[rda]};

endmodule
