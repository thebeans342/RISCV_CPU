module memory_pipeline (
    input logic clk,
    input logic rst,

    input logic [31:0] ALUResultM,
    input logic [31:0] RDM,
    input logic [4:0] RdM,
    input logic [31:0] PCPlus4M,
    input logic RegWriteM,

    output logic [31:0] ALUResultW,
    output logic [31:0] ReadDataW,
    output logic [4:0] RdW,
    output logic [31:0] PCPlus4W,
    output logic RegWriteW
);

    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ALUResultW <= 0;
            ReadDataW <= 0;
            RdW <= 0;
            PCPlus4W <= 0;
            RegWriteW <= 0;

        end else if (clk) begin
            ALUResultW <= ALUResultM;
            ReadDataW <= RDM;
            RdW <= RdM;
            PCPlus4W <= PCPlus4M;
            RegWriteW <= RegWriteM;
        end
    end

endmodule
