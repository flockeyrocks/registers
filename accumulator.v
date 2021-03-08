`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2021 10:27:11 PM
// Design Name: 
// Module Name: accumulator
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


module accumulator
    #(parameter N=4)(
    input [N-1:0] x,
    input add_n,
    input clk,
    input in,
    input reset_n,
    output DP,
    output [6:0] bcd,
    output [7:0] AN
    );
    
    wire [N-1:0]D;
    wire load;
    reg[N-1:0] y, Q_reg, Q_next;
    
   adder_subtractor addsub(
    .x(x),
    .y(y),
    .add_n(add_n),
    .s(D)
    );
  
  button debounce(
    .clk(clk),
    .in(in),
    .out(load)
    );
  always @(posedge clk, negedge reset_n)
  begin
    if(!reset_n)
        Q_reg <= 1'b0;
    else
        Q_reg <= Q_next;
  end
  
  always @(load,D)
  begin
    if (load)
        begin
            Q_next = D;
            y = Q_reg;
        end
    else
        begin
            Q_next = Q_reg;
            y = Q_reg;
        end
  end
    
    hex2sseg convert(
        .hex(Q_next),
        .sseg(bcd)
    );
    
    assign AN = 8'b11111110;
    assign DP = 1'b0;
    
endmodule
