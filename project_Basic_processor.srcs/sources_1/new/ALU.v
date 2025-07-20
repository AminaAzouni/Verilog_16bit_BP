`timescale 1ns / 1ps


module ALU(
    input wire [15:0] a,   // from AC
    input wire [15:0] b,   //from MDR
    input wire [2:0] sel_op,  
    input wire carry_e,
    
    output reg [15:0] alu_result,   
    output reg carry_s
    );
    
    reg [16:0] result_ext;
     
    always @(*)begin
        carry_s = 0;
        result_ext = 17'b0;
        
        case(sel_op)
        
            3'b000: begin
                alu_result = a & b;
                carry_s = 0 ;
            end
            
            3'b001: begin 
                result_ext = a + b + carry_e;
                alu_result = result_ext[15:0];
                carry_s = result_ext[16];
            end
            
            3'b010: begin
                alu_result = ~a;
                carry_s = 0;
            end
            
            3'b011: begin 
                alu_result = a - 1;
                carry_s = (a == 0) ? 1 :0;
            end
            
            3'b100: begin 
                alu_result = b - 1;
                carry_s = (b == 0) ? 1 :0;
            end
            
            3'b101: begin 
                alu_result = b;
                carry_s = 0;
            end
            
            3'b110: begin 
                result_ext = a + 1;
                alu_result = result_ext[15:0];
                carry_s = result_ext[16];
            end
            
            3'b111: begin 
                alu_result = 16'b0;  //MAZ remise a zero
                carry_s = 0;
            end
            
            default : begin
                alu_result = b;
                carry_s = 0;
            end
         endcase
     end
endmodule
