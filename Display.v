`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:55:12 PM
// Design Name: 
// Module Name: Lab_Modules
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

module bin2bcd(input clk, en, [11:0] bin_in, output reg [15:0] bcd_out, output reg ready);
    parameter IDLE      = 0;
    parameter SETUP     = 1;
    parameter ADD       = 2;
    parameter SHIFT     = 3;
    parameter DONE      = 4;
    
    reg [27:0] bcd_data;
    reg busy = 0;
    reg [3:0] state=IDLE;
    reg [3:0] sh_counter;
    
    initial
        begin
            bcd_out = 0;
        end
    
    always @(posedge clk) begin
        if (en) begin
            if (~busy) begin
                bcd_data <= {16'b0, bin_in};
                state <= SETUP;
                bcd_out = bcd_out;
            end
        end
        
        if (ready) begin
            bcd_out <= bcd_data[27:12];
        end
        
        case(state)
            IDLE: begin
                ready <= 0;
                busy <= 0;
                sh_counter <= 0;
                end
            SETUP: begin
                busy <= 1;
                state <= ADD;
                end
            ADD: begin
                if (bcd_data[27:24] > 4)
                    bcd_data[27:24] = bcd_data[27:24] + 3;
                if (bcd_data[23:20] > 4)
                    bcd_data[23:20] = bcd_data[23:20] + 3;
                if (bcd_data[19:16] > 4)
                    bcd_data[19:16] = bcd_data[19:16] + 3;
                if (bcd_data[15:12] > 4)
                    bcd_data[15:12] = bcd_data[15:12] + 3;
                state <= SHIFT;
                end
            SHIFT: begin
                sh_counter <= sh_counter + 1;
                bcd_data <= bcd_data << 1;
                if (sh_counter >= 11)
                    begin
                        sh_counter <= 0;
                        state <= DONE;
                    end
                else
                    state <= ADD;
            end
            DONE: begin
                ready <= 1;
                busy <= 0;
                state <= IDLE;
            end
        endcase
    end
endmodule

module Anode_Gen(input clk, input [15:0] BCD_in, input en, output reg [3:0]digit, output reg [3:0]anode_o);
    reg [9:0] g_count = 0;
    reg [3:0] anode;
    
    initial begin
        anode = 4'b1110;
    end

    always @(posedge clk) //counter
     begin //shift register instead of decoder
            g_count <= g_count+1;
          
            if(en && g_count>=10'd1023)
                begin
                    anode_o <= anode;
                    anode <= {anode[0], anode[3:1]};
                    case (anode)
                        4'b1110: digit <= BCD_in[3:0];
                        4'b1101: digit <= BCD_in[7:4];
                        4'b1011: digit <= BCD_in[11:8];
                        4'b0111: digit <= BCD_in[15:12];
                        default: digit <= 4'bxxxx;
                    endcase;
                end
    end
endmodule


module Seven_Seg_Decoder(input [3:0]x, output reg [6:0]seg);
    always @(*)
        begin
            case (x)
                0: seg = 7'b1000000;
                1: seg = 7'b1111001;
                2: seg = 7'b0100100;
                3: seg = 7'b0110000;
                4: seg = 7'b0011001;
                5: seg = 7'b0010010;
                6: seg = 7'b0000010;
                7: seg = 7'b1111000;
                8: seg = 7'b0000000;
                9: seg = 7'b0010000;
                default: seg = 7'b1111111;
            endcase;
        end
endmodule