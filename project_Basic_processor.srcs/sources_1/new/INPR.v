`timescale 1ns / 1ps

module INPR(
    input wire clk,
    input wire rst,         
    input wire [7:0] INPR_din,         
    input wire load_INPR,
    output reg [7:0] INPR_out    // Data to AC[11:0]
);
//INPR should only load data from the external input when the input device is ready(input_ready=1)
    always @(posedge clk or posedge rst) begin
        if (rst)begin
            INPR_out <= 8'b0;
        end 
        else if (load_INPR)begin
            INPR_out <= INPR_din;
    
         end  //else INPR_out holds its current value
    end

endmodule
