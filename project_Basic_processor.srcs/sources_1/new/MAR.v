`timescale 1ns / 1ps


module MAR(
    input clk,
    input rst,
    input wire [11:0] addr_in,
    input wire load_MAR,      // will be loaded when F1+F6+F10+F14+F24+F17+F20+F27+F47
   
    output reg [11:0] addr_out
    );
    
        
    always @(posedge clk or posedge rst )begin 
        if(rst)
            addr_out <= 12'b0;
        else if (load_MAR)
            addr_out <= addr_in;      
     end
endmodule
