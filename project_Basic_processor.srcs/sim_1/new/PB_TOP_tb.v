`timescale 1ns / 1ps

module PB_TOP_tb;

    reg clk;
    reg rst;
    reg [7:0] data_in_INRP;
    reg input_ready;
    reg output_ready;
    reg set_en;
    wire [7:0] data_out_OUTR;
    // Internal wires to tap F1–F49
    wire F1, F2, F3, F4, F5, F6, F7, F8, F9, F10;
    wire F11, F12, F13, F14, F15, F16, F17, F18, F19, F20;
    wire F21, F22, F23, F24, F25, F26, F27, F28, F29, F30;
    wire F31, F32, F33, F34, F35, F36, F37, F38, F39, F40;
    wire F41, F42, F43, F44, F45, F46, F47, F48, F49;
    wire [1:0] FR_conct;
    wire [1:0] control_MDR;
    wire [1:0] control_MAR;
    wire [15:0] alu_result;
    wire [15:0] data_out; 
    wire [2:0] sel_op;
    wire [11:0] addr_out;
    wire load_ac;
    wire load_MDR;
    wire load_MAR;
    wire [15:0]ac_in;
    wire [15:0] rd_RAM;
    wire [11:0]pc_out;
    // Instantiate the PB_TOP module
    PB_TOP uut (
        .clk(clk),
        .rst(rst),
        .data_in_INRP(data_in_INRP),
        .input_ready(input_ready),
        .output_ready(output_ready),
        .set_en(set_en),
        .data_out_OUTR(data_out_OUTR)
    );
    assign {F1, F2, F3, F4, F5, F6, F7, F8, F9, F10,
            F11, F12, F13, F14, F15, F16, F17, F18, F19, F20,
            F21, F22, F23, F24, F25, F26, F27, F28, F29, F30,
            F31, F32, F33, F34, F35, F36, F37, F38, F39, F40,
            F41, F42, F43, F44, F45, F46, F47, F48, F49, FR_conct, load_ac, alu_result, sel_op, data_out, addr_out, control_MDR, ac_in, rd_RAM, pc_out, control_MAR, load_MDR, load_MAR} =
            {uut.CU.F1, uut.CU.F2, uut.CU.F3, uut.CU.F4, uut.CU.F5, uut.CU.F6, uut.CU.F7, uut.CU.F8, uut.CU.F9, uut.CU.F10,
             uut.CU.F11, uut.CU.F12, uut.CU.F13, uut.CU.F14, uut.CU.F15, uut.CU.F16, uut.CU.F17, uut.CU.F18, uut.CU.F19, uut.CU.F20,
             uut.CU.F21, uut.CU.F22, uut.CU.F23, uut.CU.F24, uut.CU.F25, uut.CU.F26, uut.CU.F27, uut.CU.F28, uut.CU.F29, uut.CU.F30,
             uut.CU.F31, uut.CU.F32, uut.CU.F33, uut.CU.F34, uut.CU.F35, uut.CU.F36, uut.CU.F37, uut.CU.F38, uut.CU.F39, uut.CU.F40,
             uut.CU.F41, uut.CU.F42, uut.CU.F43, uut.CU.F44, uut.CU.F45, uut.CU.F46, uut.CU.F47, uut.CU.F48, uut.CU.F49, uut.CU.FR_conct, uut.load_ac, uut.ALU_inst.alu_result, uut.sel_op, uut.MDR_inst.data_out, uut.MAR_inst.addr_out, uut.control_MDR, uut.AC_inst.ac_in, uut.rd_RAM, uut.pc_out, uut.control_MAR, uut.load_MDR, uut.load_MAR};
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus
    initial begin
        // Monitor control signals
        $monitor("Time=%0t | F1=%b F2=%b F3=%b F4=%b F5=%b F6=%b F7=%b F8=%b F9=%b F10=%b\nF11=%b F12=%b F13=%b F14=%b F15=%b F16=%b F17=%b F18=%b F19=%b F20=%b\nF21=%b F22=%b F23=%b F24=%b F25=%b F26=%b F27=%b F28=%b F29=%b F30=%b\nF31=%b F32=%b F33=%b F34=%b F35=%b F36=%b F37=%b F38=%b F39=%b F40=%b\nF41=%b F42=%b F43=%b F44=%b F45=%b F46=%b F47=%b F48=%b F49=%b FR_conct=%02x \n load_ac=%b alu_result=%04x sel_op=%03x data_out=%04x addr_out=%03x \n control_MDR=%02x ac_in=%04x rd_RAM=%b pc_out=%03x control_MAR=%02x load_MDR=%b load_MAR=%b", 
            $time, 
            uut.F1, uut.F2, uut.F3, uut.F4, uut.F5, uut.F6, uut.F7, uut.F8, uut.F9, uut.F10,
            uut.F11, uut.F12, uut.F13, uut.F14, uut.F15, uut.F16, uut.F17, uut.F18, uut.F19, uut.F20,
            uut.F21, uut.F22, uut.F23, uut.F24, uut.F25, uut.F26, uut.F27, uut.F28, uut.F29, uut.F30,
            uut.F31, uut.F32, uut.F33, uut.F34, uut.F35, uut.F36, uut.F37, uut.F38, uut.F39, uut.F40,
            uut.F41, uut.F42, uut.F43, uut.F44, uut.F45, uut.F46, uut.F47, uut.F48, uut.F49, uut.CU.FR_conct, 
            uut.load_ac, uut.ALU_inst.alu_result, uut.sel_op, uut.MDR_inst.data_out, uut.MAR_inst.addr_out, 
            uut.control_MDR, uut.AC_inst.ac_in, uut.rd_RAM, uut.pc_out, uut.control_MAR, uut.load_MDR, uut.load_MAR  
        );

        // Initial values
        rst = 1;
        data_in_INRP = 8'h00;
        input_ready = 0;
        output_ready = 0;
        set_en = 0;

        #20;
        rst = 0;
        data_in_INRP = 8'h55;   // example input
        input_ready = 1;
        output_ready = 1;
        set_en = 1;

        
        #600; // let the simulation run for a while
    end 
    always @(posedge clk) begin

         $display("t=%0t | F1=%b F2=%b | PC=%h | MAR_in=%h | MDR_out=%h | RI=%h | AC=%h", 
             $time, F1, F2, pc_out, uut.MAR_in, uut.MDR_out, uut.RI_instruction, uut.ac_out);
    end

endmodule
