`include "def.sv"

module branch_predictor (
    input logic clk,
    input logic rst,

    input logic [31:0] pc,
    input logic [31:0] address,
    input logic [31:0] actual_branch,

    output logic hit,
    output logic predicted_branch
);  

    logic [31:0] history [31:0];
    

    typedef enum logic [1:0] {
        STRONGLY_NOT_TAKEN = 2'b00,
        WEAKLY_NOT_TAKEN = 2'b01,
        WEAKLY_TAKEN = 2'b10,
        STRONGLY_TAKEN = 2'b11
    } my_state;

    my_state curr_state, next_state;

    always @(posedge clk, negedge rst) begin
        if(rst) 
            next_state <= STRONGLY_NOT_TAKEN;
        else
            next_state <= curr_state;
    end

    always_comb begin
        hit = 
    end

    always_comb begin
        case (state) 
            STRONGLY_NOT_TAKEN: next_state = taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
            WEAKLY_NOT_TAKEN: next_state = taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
            WEAKLY_TAKEN: next_state = taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
            STRONGLY_TAKEN: next_state = taken ? STRONGLY_TAKEN : WEAKLY_TAKEN; 
        endcase

    end
endmodule