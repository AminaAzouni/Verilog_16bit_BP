`timescale 1ns / 1ps

module CU_tb();

    // Inputs
    reg H;
    reg rst;
    reg [15:0] Di_in;
    reg [15:0] instruction;
    reg set_en;

    // Outputs
    wire F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20;
    wire F21, F22, F23, F24, F25, F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38;
    wire F39, F40, F41, F42, F43, F44, F45, F46, F47, F48, F49;
    
      wire [1:0] FR_conct; // FR_conct internal signal ({F, R})
      wire [3:0] ti_test;       // ti internal signal
      wire [7:0] Qi_test;       // Qi (opcode decode) internal signal
      wire I_test;              // I bit internal signal
      wire F_test, R_test;   



    // Instantiate the Unit Under Test (UUT)
    ControlUnit uut (
        .H(H),
        .rst(rst),
        .Di_in(Di_in),
        .instruction(instruction),
        .set_en(set_en),
        .F1(F1), .F2(F2), .F3(F3), .F4(F4), .F5(F5), .F6(F6), .F7(F7), .F8(F8), .F9(F9), .F10(F10),
        .F11(F11), .F12(F12), .F13(F13), .F14(F14), .F15(F15), .F16(F16), .F17(F17), .F18(F18), .F19(F19), .F20(F20),
        .F21(F21), .F22(F22), .F23(F23), .F24(F24), .F25(F25), .F26(F26), .F27(F27), .F28(F28), .F29(F29), .F30(F30),
        .F31(F31), .F32(F32), .F33(F33), .F34(F34), .F35(F35), .F36(F36), .F37(F37), .F38(F38), .F39(F39), .F40(F40),
        .F41(F41), .F42(F42), .F43(F43), .F44(F44), .F45(F45), .F46(F46), .F47(F47), .F48(F48), .F49(F49)
    );
    
    
      assign FR_conct = uut.FR_conct;
      assign ti_test       = uut.ti;
      assign Qi_test       = uut.Qi;
      assign I_test        = uut.I;
      assign F_test        = uut.F;
      assign R_test        = uut.R;
      
        
   initial begin
        H = 0;
        forever #5 H = ~H;
    end  

    initial begin
            $dumpfile("CU_tb.vcd");
            $dumpvars(0, CU_tb);
            
            H = 0;
            rst = 1;         
            Di_in = 16'h0000;
            instruction = 16'h0000;
            set_en = 0;     
           
       
            #10 rst = 0;    
            #10 set_en = 1;  // Enable S_FF to allow ti to increment
            
            // Set the instruction for ADD with I=1
            instruction = 16'hF080; 
            Di_in = 16'hF080;
            
        

            #300; 
              
          end
    
endmodule
