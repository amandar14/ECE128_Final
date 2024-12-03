`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:56:20 PM
// Design Name: 
// Module Name: Operations
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

module operation(input [2:0] op, input [3:0] a, b, output reg [7:0] result);
    //wires for multiplier
    reg [3:0] m0;
    reg [4:0] m1;
    reg [5:0] m2;
    reg [6:0] m3;
    reg [7:0] s1,s2,s3;
    
    always @(*) begin
        case (op)
            0: begin
                // +
                result = a + b;
            end
            1: begin
                // -
                result = a - b;
            end
            2: begin
                // *
                assign m0 = {4{a[0]}} & b[3:0];
                assign m1 = {4{a[1]}} & b[3:0];
                assign m2 = {4{a[2]}} & b[3:0];
                assign m3 = {4{a[3]}} & b[3:0];
                
                assign s1 = m0 + (m1 << 1);
                assign s2 = s1 + (m2 << 2);
                assign s3 = s2 + (m3 << 3);
                assign result = s3;
            end
            3: begin
                // divide
                result = a / b;
            end
            4: begin
                // &
                result = a & b;
            end
            5: begin
                // |
                result = a | b;
            end
            6: begin
                // ^
                result = a ^ b;
            end
            7: begin
                // ~
                result = ~a;
            end
        endcase
    end
endmodule

//module mult(a,b,p);
//    input [3:0] a,b;
//    output [7:0] p;
    
//    wire [3:0] m0;
//    wire [4:0] m1;
//    wire [5:0] m2;
//    wire [6:0] m3;
//    wire [7:0] s1,s2,s3;
    
//    assign m0 = {4{a[0]}} & b[3:0];
//    assign m1 = {4{a[1]}} & b[3:0];
//    assign m2 = {4{a[2]}} & b[3:0];
//    assign m3 = {4{a[3]}} & b[3:0];
    
//    assign s1 = m0 + (m1 << 1);
//    assign s2 = s1 + (m2 << 2);
//    assign s3 = s2 + (m3 << 3);
//    assign p = s3;
//endmodule