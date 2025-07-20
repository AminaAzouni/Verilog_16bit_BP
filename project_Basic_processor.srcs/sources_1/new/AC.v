`timescale 1ns / 1ps



module AC(
    input wire clk,
    input wire rst,
    input wire [7:0] INRP_in,
    input wire [15:0] ac_in,   //alu_out or INPR reg
    input wire sel_source,  // when F43 (INP instruction)
    input wire load_ac,      // when load_ac= F12+F43+F31+F33+F35+F36+F16+F19+F37+F49
    output reg [15:0] AC_out // AC has 3 destinations: ALU, MDR, and OUTR
   
    );

    
    always @(posedge clk or posedge rst) begin 
        if (rst) begin
            AC_out <= 16'b0;
        end 
        else if (load_ac) begin 
            if (sel_source == 1'b1) begin
                AC_out <= {AC_out[15:8], INRP_in};
            end else begin 
                AC_out <= ac_in;  // Load the full 16-bit value from ALU
            end
         end
    end
endmodule
