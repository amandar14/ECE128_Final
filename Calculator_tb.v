`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 02:17:28 PM
// Design Name: 
// Module Name: Calculator_tb
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


module Calculator_tb( );
    reg [3:0] a, b;
    reg [2:0] op;
    wire [6:0] cathode;
    wire [3:0] anode;
    reg clk;
    
    Calculator uut(clk, a, b, op, cathode, anode);
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 0;
//        a = 3;
//        b = 2;
//        op = 0;//add
//        #12000
//        a = 7;
//        b = 5;
//        op = 1;//subtract
//        #12000
//        a = 15;
//        b = 8;
//        op = 2;//multiply
//        #12000
//        a = 10;
//        b = 2;
//        op = 3;//divide
//        #12000
//        a = 1;
//        b = 1;
//        op = 4;//and
//        #12000
//        a = 0;
//        b = 1;
//        op = 5;//or
//        #12000
        a = 0;
        b = 1;
        op = 6;//xor
        #12000
        a = 1;
        b = 0;
        op = 7;//not
    end
endmodule
