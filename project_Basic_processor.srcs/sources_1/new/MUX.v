
`timescale 1ns / 1ps



module Mux #(parameter width = 12)(      // 12bit for MAR, can be 16bit for selecting MDR input 
    input wire [width-1:0] a,
    input wire [width-1:0] b,
    input wire [width-1:0] c,
    input wire [1:0] sel,
    output reg [width-1:0] mux_out
    );
    
    always @(*)begin
        case(sel)
            2'b01: mux_out= a;
            2'b10: mux_out= b;
            2'b11: mux_out= c;
            default: mux_out= {width{1'b0}};

         endcase
     end
endmodule