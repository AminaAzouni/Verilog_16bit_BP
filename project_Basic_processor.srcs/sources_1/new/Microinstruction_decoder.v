`timescale 1ns / 1ps


module MicroInstruction_decoder(
    input wire [11:0] D,   //extruct the instruction comes from MDR  for IRR and IES instruction 
    input wire I,  //for IES instructions
    input wire [7:0] q,
    input wire [1:0] c,   //c0, c1, c2, c3
    input wire [3:0] t,   //t0, t2, t2, t3 clk sig
    output wire F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, F25,
               F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48, F49          
    );
    
    // Intermediate cycle flags based on c
    wire c0, c1, c2, c3;
    
    assign c0 = (c == 2'b00);  // read cycle
    assign c1 = (c == 2'b01);  // indirect cycle
    assign c2 = (c == 2'b10);  // execution cycle
    assign c3 = (c == 2'b11);  // interrupt cycle
    
      
    wire q0 = (q == 8'b00000001);
    wire q1 = (q == 8'b00000010);
    wire q2 = (q == 8'b00000100);
    wire q3 = (q == 8'b00001000);
    wire q4 = (q == 8'b00010000);
    wire q5 = (q == 8'b00100000);  // <== FIXED
    wire q6 = (q == 8'b01000000);
    wire q7 = (q == 8'b10000000);

    wire not_I = ~I;   //for IRR instructions
    //cycle de lecture
    assign F1  = c0 & t[0];
    assign F2  = c0 & t[1];
    assign F3  = c0 & t[2];
    assign F4  = c0 & t[3] & (~q7 & I);
    assign F5  = c0 & t[3] & (q7 | not_I);
    
    //cycle indirect 
    assign F6  = c1 & t[0];
    assign F7  = c1 & t[1];
    assign F8  = c1 & t[2];
    assign F9  = c1 & t[3];
    
    //IRM
    assign F10 = c2 & t[0] & q0;
    assign F11 = c2 & t[1] & q0;
    assign F12 = c2 & t[2] & q0;
    assign F13 = c2 & t[3];
    
    assign F14 = c2 & t[0] & q1;
    assign F15 = c2 & t[1] & q1;
    assign F16 = c2 & t[2] & q1;
    
    assign F17 = c2 & t[0] & q2;
    assign F18 = c2 & t[1] & q2;
    assign F19 = c2 & t[2] & q2;
    
    assign F20 = c2 & t[0] & q3;
    assign F21 = c2 & t[1] & q3;
    assign F22 = c2 & t[2] & q3;
    
    assign F23 = c2 & t[0] & q4;
    
    assign F24 = c2 & t[0] & q5;
    assign F25 = c2 & t[1] & q5;
    assign F26 = c2 & t[2] & q5;
    
    assign F27 = c2 & t[0] & q6;
    assign F28 = c2 & t[1] & q6;
    assign F29 = c2 & t[2] & q6;
    assign F30 = c2 & t[3] & q6;
    
    //IRR
    assign F31 = c2 & t[0] & q7 & D[11] & not_I;   
    assign F32 = c2 & t[0] & q7 & D[10] & not_I;
    assign F33 = c2 & t[0] & q7 & D[9] & not_I;
    assign F34 = c2 & t[0] & q7 & D[8] & not_I;
    assign F35 = c2 & t[0] & q7 & D[7] & not_I;
    assign F36 = c2 & t[0] & q7 & D[6] & not_I;
    assign F37 = c2 & t[0] & q7 & D[5] & not_I;
    
    assign F38 = c2 & t[0] & q7 & D[4] & not_I;
    assign F39 = c2 & t[0] & q7 & D[3] & not_I;
    assign F40 = c2 & t[0] & q7 & D[2] & not_I;
    assign F41 = c2 & t[0] & q7 & D[1] & not_I;
    assign F42 = c2 & t[0] & q7 & D[0] & not_I;
    
    // IES

    assign F43 = c2 & t[0] & q7 & D[11] & I;
    assign F44 = c2 & t[0] & q7 & D[10] & I;
    assign F45 = c2 & t[0] & q7 & D[9] & I;
    assign F46 = c2 & t[0] & q7 & D[8] & I;
    
    assign F47 = c2 & t[0] & q7 & D[7] & I;
    assign F48 = c2 & t[1] & q7 & D[7] & I;
    assign F49 = c2 & t[2] & q7 & D[7] & I;
endmodule
