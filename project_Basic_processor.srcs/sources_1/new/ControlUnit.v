`timescale 1ns / 1ps

module ControlUnit(
    input wire H,  //global clk
    input wire rst, //global rst for FLipFLops(F, R, FGI, FGO, S)
    input wire [15:0] Di_in,         //this is the MDR output its the input of RI
    input wire [15:0] instruction,     // instruction from RIand it will be extracted 
    input wire set_en,
    output wire F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, F25,
               F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48, F49
    );
    
    //internal sig
    wire [11:0] Di;      // this will be came from MDR(extructed) not RI 
    wire I;
    wire [2:0] op;
    wire [7:0] Qi;
    wire [3:0] ti;
    wire F_sig;  
    wire R_sig;  
    wire S_sig; //output of S ff
    wire S_rst; // control s rst by F42
    //wire set;   // this is the output of AND gate 
    wire F, R; //output of F & R flip flop
    wire [1:0] FR_conct;
    wire R_rst;
    wire F_rst;
    wire exe_done;
    
    //extracting field from instruction 
    assign I = instruction[15];
    assign op= instruction[14:12];
    assign Di= Di_in[11:0]; //assign the di sig to the MDR output 12 LSB
    
    assign F_sig = (F5 | F9) | F ;
    assign R_sig = F4 | R;
    assign FR_conct= {F, R}; //2to4DCD input and it output is Ci
    //assign set_en = H & S_sig  & ~rst;   //only goes high when set_en=1
    assign exe_done =  F13 | F26 | F16 | F19 | F22 | F23 | F26 | F30 | F49 | F31 | F32 | F33 | F34 | F35 | F36 | F37 | F38 | F39 | F40 | F41| F42 | F43 | F44 | F45 | F46;
    reg exe_done_d;
    
    
    always @(posedge H or posedge rst) begin
        if (rst)
            exe_done_d <= 1'b0;
        else
            exe_done_d <= exe_done;
    end
    
   
    //instantiate components     
    DCD3to8 DCD_Qi(
        .op(op), .Qout(Qi));
               
    DFF F_FF (
        .clk(H), .rst(rst), .clr(exe_done), .D(F_sig), .q(F));
        
    DFF R_FF (
        .clk(H), .rst(rst), .clr(F9 | exe_done), .D(R_sig), .q(R)); 
                    
    DFF S_FF(
        .clk(H), .rst(rst), .clr(F42), .D(set_en), .q(S_sig));  
          
    Shift_reg_ti Reg_ti(
        .clk(H), .rst(rst), .En(S_sig), .exe_done(exe_done_d), .t(ti));
        
   // control function generation 
   MicroInstruction_decoder Control_Funct(
        .D(Di), .I(I), .q(Qi), .c(FR_conct), .t(ti), 
        .F1(F1), .F2(F2), .F3(F3), .F4(F4), .F5(F5), .F6(F6), .F7(F7), .F8(F8), .F9(F9), .F10(F10),
        .F11(F11), .F12(F12), .F13(F13), .F14(F14), .F15(F15), .F16(F16), .F17(F17), .F18(F18), .F19(F19), .F20(F20),
        .F21(F21), .F22(F22), .F23(F23), .F24(F24), .F25(F25), .F26(F26), .F27(F27), .F28(F28), .F29(F29), .F30(F30),
        .F31(F31), .F32(F32), .F33(F33), .F34(F34), .F35(F35), .F36(F36), .F37(F37), .F38(F38), .F39(F39), .F40(F40),
        .F41(F41), .F42(F42), .F43(F43), .F44(F44), .F45(F45), .F46(F46), .F47(F47), .F48(F48), .F49(F49));
   
endmodule
