`timescale 1ns / 1ps

module RAM(
    input wire clk,
    input wire rst,
    input wire [11:0] addr,
    input wire [15:0] data,
    input wire RD,  // controlled by F2+F7+F11+F15+F18+F28+F48
    input wire WR,  // controlled by F22+F25+F30
    output reg [15:0] read_data 
);
    
    reg [15:0] mem [0:4095];  // 12-bit address: 4096 locations 
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            read_data <= 16'b0;
        end else begin
        
            if (WR) begin
                mem[addr] <= data;
            end
            // read_data will appear one clock cycle after the RD signal is asserted and addr is stable at the rising edge of the clock.
            if (RD) begin
                read_data <= mem[addr];
            end 

        end
    end   

    initial begin
        // Load instructions
        mem[12'h000] = 16'hA100; // LDA 0x100
        mem[12'h001] = 16'h9101; // ADD 0x101
        mem[12'h002] = 16'hF400; // OUT
        mem[12'h003] = 16'h7001; // HLT
       //mem[12'h000] = 16'hF080; // LDA 0x100
        // Load data
       mem[12'h100] = 16'h0010; // Value 10h
       mem[12'h101] = 16'h0005; // Value 05h
        //mem[12'h080] = 16'h0101;  // M(0x080) = 0x0101 (pointer)
        //mem[12'h101] = 16'h0033;  // M(0x0101) = 0x0033 (actual value to load to AC)
    end
endmodule
