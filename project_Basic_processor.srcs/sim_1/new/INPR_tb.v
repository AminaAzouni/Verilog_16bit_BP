`timescale 1ns / 1ps

module INPR_tb();

    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] INPR_din;
    reg load_INPR;
    wire [7:0] INPR_out;

    // Instantiate the DUT (Device Under Test)
    INPR uut (
        .clk(clk),
        .rst(rst),
        .INPR_din(INPR_din),
        .load_INPR(load_INPR),
        .INPR_out(INPR_out)
    );
    
   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulation control
    initial begin
        // GTKWave setup
        $dumpfile("INPR_tb.vcd");
        $dumpvars(0, INPR_tb);

        // Initial state
        rst = 1;
        INPR_din = 8'b00000000;
        load_INPR= 1'b0;
        
        #10 rst = 0;  
        #10 load_INPR = 1'b1;     
        INPR_din = 8'b10101010;  // Apply input
        
        #20;
        load_INPR= 1'b0;  
        
        #10 load_INPR= 1'b1;
        INPR_din = 8'b11001100;  // Change input again
        #10 load_INPR= 1'b0;
        #10 rst = 1;          // Assert reset again
        
        #10 rst = 0;          // Deassert reset
        #10 INPR_din = 8'b11110000;  // New data wuithout load enable .. should remain 00

        #10;
    end

endmodule
