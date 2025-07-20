`timescale 1ns / 1ps


module DCD3to8(
    input [2:0] op,
    output [7:0] Qout
    );
    
    assign Qout = 8'b00000001 << op;
     
endmodule
