`timescale 1ns / 1ps

module PC_tb();
    reg clk;
    reg rst;
    reg [11:0] pc_in; 
    reg load_pc; 
    reg INC_pc;
    wire [11:0] pc_out;
    
    
    PC dut(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .load_pc(load_pc),
        .INC_pc(INC_pc),
        .pc_out(pc_out));
        
   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin 
    
        // dump file for GTKWave waveform viewing
        $dumpfile("PC_tb.vcd");
        $dumpvars(0, PC_tb); 
        
        rst =1; 
        load_pc = 0;
        INC_pc = 0;
        pc_in = 12'h000;
            
        #10 rst=0;
        
        load_pc = 0;
        pc_in = 12'h00A;
        INC_pc = 0;
        
        #10 load_pc = 1;
        #10 load_pc = 0;
        
        
        #10 INC_pc = 1;     
        #30 INC_pc = 0;  //wait and then incr pc 3 time
        
        #10 pc_in = 12'h015;
        
        load_pc = 1;
        
        #10 load_pc = 0;
        #10 INC_pc = 1;
        #10 INC_pc = 0;  
         
   end
    
endmodule
