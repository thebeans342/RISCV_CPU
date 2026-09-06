`include "def.sv"

module branch_predictor (
    input logic clk,
    input logic rst,

    // current PC at fetch stage
    input logic [31:0] PC_fetch,
    // PC address if branch/jump condition is treu
    input logic [31:0] address,
    // true branch result
    input logic [31:0] actual_branch,

    output logic [31:0] predicted_branch
);  

    // global history register
    logic [1:0] history_table [0:31];

    logic [31:0] history;

    //index of the pattern history table
    logic [31:0] GHT_index;

    assign GHT_index = PC_fetch ^ history;

    logic [1:0] next_state;

    // output the corresponding prediction from the index
    logic prediction;

    logic hit;

        //update the FSM for the corresponding index
    branch_predict_fsm branch_predictor_fsm(
        .clk(clk),
        .rst(rst),
        .hit(hit)
        .prev_state(prev_state),
        .curr_state(curr_state),
        .taken(taken)
    );


    always_ff @(posedge clk) begin
        history <= {history[30:0], hit};
        history_table[GHT_index] <= curr_state;
        predicted_branch <= taken ? address : PC_fetch; 
    end

    always_comb begin
        hit = (address == actual_branch) ? 1 : 0;
    end


endmodule

