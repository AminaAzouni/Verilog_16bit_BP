`timescale 1ns / 1ps



module DFF(
    input wire D, 
    input wire clk,
    input wire rst,
    input wire clr,
    output reg q
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            q <= 1'b0;
        end else if(clr) begin
            q <= 1'b0;   //CPU clears the flag, indicating it has consumed the data
        end else begin 
            q <= D;
        end
    end
  
endmodule
