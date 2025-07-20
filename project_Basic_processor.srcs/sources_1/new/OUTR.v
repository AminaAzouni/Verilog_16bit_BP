`timescale 1ns / 1ps

module OUTR(
    input wire clk,
    input wire rst,
    input wire load_OUTR,         
    input wire [7:0] OUTR_in,     
    output reg [7:0] OUTR_out                      
);
//It loads OUTR_in into OUTR_out on the positive clock edge only when load_OUTR is high. Otherwise, it holds its current value
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            OUTR_out <= 8'b0;
        end
        else if (load_OUTR) begin
                OUTR_out <= OUTR_in;          
        end
    end

endmodule
