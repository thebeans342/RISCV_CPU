module ALUctrl_MUX #(
    DATA_WIDTH = 32
) (
    input   logic [DATA_WIDTH-1:0]  in0,
    input   logic [DATA_WIDTH-1:0]  in1,
    input   logic                   ALUctrl,
    output  logic [DATA_WIDTH-1:0]  ALUout,
    output  logic EQ
);
    assign out = ALUsrc ? in1 : in0;

endmodule