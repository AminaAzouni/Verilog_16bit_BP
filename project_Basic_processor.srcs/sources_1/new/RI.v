`timescale 1ns / 1ps



module RI(
    input clk,rst,
    input wire Load_RI,  //Load_RI = F3
    input wire [15:0] RI_in,    //from MDR
    output reg [15:0] instruction  //to MAR and control unit 
    );
    
    always @(posedge clk or posedge rst) begin 
        if (rst)
            instruction <= 16'h0;
        else if (Load_RI)
            instruction <= RI_in;
    end
endmodule
