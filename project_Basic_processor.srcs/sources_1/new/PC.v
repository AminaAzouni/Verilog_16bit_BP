`timescale 1ns / 1ps


module PC(
    input wire clk,
    input wire rst,
    input wire [11:0] pc_in,   //MDR[addr] out
    input wire load_pc,   //if =1 load pc from the output of MDR (MDR_out) F23 + F24
    input wire INC_pc,    //increment pc by 1 if   F2+ F26 +F30 +F38+ F39+ F40 + F41 + F45 + F46 +F48
    output reg [11:0] pc_out     // Vers MDR and Vers MAR
    
    );
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            pc_out <= 12'b0;
        end
        else begin 
            if (load_pc) begin 
                pc_out <= pc_in;
            end
            else if (INC_pc) begin
                pc_out <= pc_out + 1;
            end
         end
     end
       
endmodule
