module ctrl_unit (
    input   logic [31:0] instr,
    input   logic EQ,
    output  logic RegWrite,
    output  logic ALUctrl,
    output  logic ALUsrc,
    output  logic ImmSrc,
    output  logic PCcsrc 
)
