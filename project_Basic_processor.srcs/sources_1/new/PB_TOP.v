`timescale 1ns / 1ps



module PB_TOP(
    input wire clk,
    input wire rst, 
    input wire [7:0] data_in_INRP, //external data
    input wire input_ready, output_ready,
    input wire set_en,
    output wire [7:0] data_out_OUTR //to external devices 
    );
    //internal signal 
    wire load_RI;
    wire [15:0] MDR_in;
    wire [15:0] MDR_out;
    wire [11:0] MAR_in;
    wire [11:0] MAR_out;
    wire [1:0] control_MAR;
    wire [1:0] control_MDR;
    wire [15:0] RI_instruction;
    wire [15:0] rd_RAM;
    wire [11:0] pc_out;
    wire [15:0] ac_out;
    wire [15:0] alu_out;
    wire load_MDR;
    wire load_pc;
    wire inc_pc;
    wire load_MAR;
    wire rd_en;
    wire wr_en;
    wire sel_source;
    wire load_ac;
    wire S0, S1, S2, S3, S4, S5, S6;
    wire [2:0] sel_op;   //for ALU Operations
    wire clr_E;
    wire load_E;
    wire Rs, Re;
    wire FGI, FGO;
    wire [7:0] data_out_INPR;
 
    // control function signals 
    wire F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, F25,
               F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48, F49;
               
               
    //assignement 
    assign load_pc = F23 | F24;   
    assign inc_pc = F2              //INCpc= F2+F26+F30.MDR+F38.AC(1)+F39.AC(1)+F40.AC+F41.E+F45.FGI+F46.FGO+F48
              | F26 
              | (F30 && (MDR_out == 16'b0)) 
              | (F38 && ~ac_out[0] == 1'b0) 
              | (F39 && ac_out[0] == 1'b1) 
              | (F40 && (ac_out == 16'b0)) 
              | (F41 && ~Rs) 
              | (F45 && FGI == 1'b1) 
              | (F46 && FGO == 1'b1) 
              | F48;
              
    assign load_RI = F3;    
    assign load_MDR = F2 | F7 | F11 | F15 | F18 | F21 | F24 | F28 | F29 | F48;          
    assign load_MAR = F1 | F6 | F10 | F14 | F24 | F17 | F20 | F27 | F47;
    assign rd_en = F1 | F6 | F7 | F14 | F17 | F27 | F47;
    assign wr_en = F22 | F25 | F30;
    
    assign sel_source = F43;
    assign load_ac = F12 | F43 | F31 | F33 | F35 | F36 | F15 | F19 | F37 | F49 ;
    assign S2 = F36 | F19 | F37 | F31 | F49;
    assign S3 = F37 | F31 | F35 | F33;
    assign S4 = F31 | F19 | F35 | F15 | F49;
    assign sel_op = {S2, S3, S4};
    assign clr_E = F32;
    assign load_E = F34;
    
    assign S0= F6 | F10 | F14 | F17 | F20 | F24 | F27;
    assign S1 = F1 | F47 | F10 | F14 | F17 | F20 | F24 | F27;  
    //assign S0 = F6;
    //assign S1 = F1 | F47; 
    assign control_MAR = {S0, S1};
           
           
    assign S5= F21 | F2 | F7 | F11 | F15 | F18 | F28 | F48;
    assign S6= F24 | F2 | F7 | F11 | F15 | F18 | F28 | F48;
    //assign S5= F21;
    //assign S6= F24;
    assign control_MDR = {S5, S6};  
    
    //instantiation  
    Mux #(.width(16)) MDR_mux(
         .a({4'b0000, pc_out}), .b(ac_out), .c(rd_RAM), .sel(control_MDR), .mux_out(MDR_in));
        
        
    MDR MDR_inst(
        .clk(clk), .rst(rst), .data_in(MDR_in), .load_MDR(load_MDR), .data_out(MDR_out));
    
    RI RI_inst(
        .clk(clk), .rst(rst), .Load_RI(load_RI), .RI_in(MDR_out), .instruction(RI_instruction));
    
    PC PC_inst(
        .clk(clk), .rst(rst), .pc_in(MDR_out[11:0]), .load_pc(load_pc), .INC_pc(inc_pc), .pc_out(pc_out)); 
        
    Mux #(.width(12)) MAR_mux(
         .a(pc_out), .b(RI_instruction[11:0]), .c(MDR_out[11:0]), .sel(control_MAR), .mux_out(MAR_in));
       
    MAR MAR_inst(
        .clk(clk), .rst(rst), .addr_in(MAR_in), .load_MAR(load_MAR), .addr_out(MAR_out));   
    
    RAM RAM_inst(
        .clk(clk), .rst(rst), .addr(MAR_out), .data(MDR_out), .RD(rd_en), .WR(wr_en), .read_data(rd_RAM));  
        
    AC AC_inst(
        .clk(clk), .rst(rst), .INRP_in(data_out_INPR), .ac_in(alu_out), .sel_source(sel_source), .load_ac(load_ac), .AC_out(ac_out));
        
    ALU ALU_inst(
        .a(ac_out), .b(MDR_out), .sel_op(sel_op), .alu_result(alu_out), .carry_e(Re), .carry_s(Rs));
    
    E_FF E_inst(
        .clk(clk), .rst(rst), .carry_in(Rs), .clr_E(clr_E), .load_E(load_E), .E(Re));

            
    DFF FGI_FF(.clk(clk), .rst(rst), .clr(F43), .D(input_ready), .q(FGI));   //// FGI :set quand input_ready /  rst quand instruction INP exécutée (F43)
            
    INPR INPR_inst(
        .clk(clk), .rst(rst), .load_INPR(input_ready && F43), .INPR_din(data_in_INRP), .INPR_out(data_out_INPR)); //input_ready && F43 is generally necessary for INPR To prevent loading stale data
    
    DFF FGO_FF(.clk(clk), .rst(rst), .clr(F44), .D(output_ready), .q(FGO)); //FGO set si output  ready to  recive new data and rst si F44 
        
    OUTR OUTR_inst(
        .clk(clk), .rst(rst), .load_OUTR(F44), .OUTR_in(ac_out[15:8]), .OUTR_out(data_out_OUTR)); //F44 q7ID6c2t0 OUTR<-AC(9-16) ,FGO= 0

    
        ControlUnit CU(
        .H(clk), .rst(rst), .Di_in(MDR_out), .instruction(RI_instruction), .set_en(set_en),
        .F1(F1), .F2(F2), .F3(F3), .F4(F4), .F5(F5), .F6(F6), .F7(F7), .F8(F8), .F9(F9), .F10(F10),
        .F11(F11), .F12(F12), .F13(F13), .F14(F14), .F15(F15), .F16(F16), .F17(F17), .F18(F18), .F19(F19), .F20(F20),
        .F21(F21), .F22(F22), .F23(F23), .F24(F24), .F25(F25), .F26(F26), .F27(F27), .F28(F28), .F29(F29), .F30(F30),
        .F31(F31), .F32(F32), .F33(F33), .F34(F34), .F35(F35), .F36(F36), .F37(F37), .F38(F38), .F39(F39), .F40(F40),
        .F41(F41), .F42(F42), .F43(F43), .F44(F44), .F45(F45), .F46(F46), .F47(F47), .F48(F48), .F49(F49));
endmodule
