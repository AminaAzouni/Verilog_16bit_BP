`timescale 1ns / 1ps


module E_FF(
    input wire clk,
    input wire rst,
    input wire carry_in,   //this is the carry_s of ALU
    input wire clr_E,   // function control the clear F32
    input wire load_E,  // F34 E<- ~E
    output reg E   //the carry_e of alu
    
    );
    
    always @(posedge clk or posedge rst)begin
        if(rst)
            E<= 1'b0;
            
        else if (clr_E)
            E <= 1'b0;
            
        else if (load_E)   //Toggle E
            E <= ~E;
            
        else //// Default behavior: Load carry_in if no other control signal is active
            E <= carry_in;
    end
endmodule
