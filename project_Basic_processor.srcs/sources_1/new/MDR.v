`timescale 1ns / 1ps



module MDR(
    input clk,
    input rst,
    input wire [15:0] data_in,
    input wire load_MDR,      // control load by F2+F7+F11+F15+F18+F21+F24+F28+F29+F48
    
    output reg [15:0] data_out
    );
        
    always @(posedge clk or posedge rst) begin
        if(rst)
            data_out <= 16'b0;
        else if(load_MDR)
            data_out <= data_in;
            
     end
endmodule
