`timescale 1ns / 1ps

module DFF_tb;

    // Testbench signals
    reg D;
    reg clk;
    reg rst;
    wire q;

    DFF uut (
        .D(D),
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    // Clock generation: 10ns period (50 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
   
        D = 0;
        rst = 1;   
        #10 D = 1;
        
        #10 rst = 0;
        #10 D = 0;
        #10 D = 1;
        #10 D = 1;
        #10 D = 0;
     
        #20 $finish; // End simulation
    end

endmodule
