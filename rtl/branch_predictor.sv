`include "def.sv"

module branch_predictor (
    input logic clk,
    input logic rst,

    input logic [31:0] PC,
    input logic [31:0] address,
    input logic [31:0] actual_branch,

    output logic hit,
    output logic predicted_branch
);  
    
    // global history register
    logic history [31:0];

    //index of the pattern history table
    logic GHT_index;

    assign GHT_index = PC ^ history;

    // output the corresponding prediction from the index
    logic prediction;

    
    always_ff @(posedge clk) begin
        history <= history[30:0] + hit;
        taken <= 
    end

    always_comb begin
        hit = (address == actual_branch) ? 1 : 0;
    end

endmodule
