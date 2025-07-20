`timescale 1ns / 1ps



module Shift_reg_ti(
    input wire clk,
    input wire rst,         // Global asynchronous reset (highest priority)
    input wire En,          // Enable for shifting
    input wire exe_done,   //halts shifting when instruction complete
    output reg [3:0] t
    );

    always @(posedge clk or posedge rst or posedge exe_done) begin
        if (rst) begin 
            t <= 4'b0001;
        end
        else if (exe_done) begin
           t <= 4'b0001;     
        end            
        else if (En) begin

           t <= {t[2:0], t[3]}; // Shift
        end
    end
endmodule
