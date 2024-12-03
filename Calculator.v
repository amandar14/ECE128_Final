`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:57:47 PM
// Design Name: 
// Module Name: Calculator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Calculator(input clk,
    input [3:0] a, b,
    input [2:0] op,
    output [6:0] cathode,
    output [3:0] anode);
            
    wire [15:0] bcd_in;
    wire [3:0] digit;
    wire ready;
    wire [7:0] result;
    reg [2:0] op_reg;
    
    always @(posedge clk)
    begin
        op_reg <= op;
    end
    
    operation uut1(op_reg, a, b, result);
    bin2bcd uut2(clk, 1, {4'b0, result}, bcd_in, ready);
    Seven_Seg_Decoder uut3(digit, cathode);
    Anode_Gen uut4(clk, bcd_in, 1, digit, anode);
endmodule
