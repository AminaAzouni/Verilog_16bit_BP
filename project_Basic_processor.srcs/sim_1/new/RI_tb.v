`timescale 1ns / 1ps



module RI_tb();

  reg clk;
  reg rst;
  reg Load_RI;
  reg [15:0] RI_in;
  wire [15:0] instruction;

  RI uut (
    .clk(clk),
    .rst(rst),
    .Load_RI(Load_RI),
    .RI_in(RI_in),
    .instruction(instruction)
  );

   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

  initial begin
    //dump file for GTKWave waveform viewing
    $dumpfile("RI_tb.vcd");
    $dumpvars(0, RI_tb);  
    
    rst =1;
    Load_RI = 0;
    RI_in = 16'h0000;

    #10;
    rst = 0;
    
    RI_in = 16'hABCD;
    Load_RI = 1; 
    #10; 

    RI_in = 16'h1234;
    Load_RI = 0;
    #10;

    RI_in = 16'hDEAD;
    Load_RI = 1;
    #10;
  
  end
endmodule
