`timescale 1ns / 1ps

module demux_2x1_nbit
#(parameter N = 2)(
    input [N-1:0] x, 
    input [7:0] y,
    input s,
    output reg [7:0] f
    );
    
    //if op_sel[1]==0, select add_sub and concatenate to make result 8 bits
    //if op_sel[1]==1, select multiplier
    always@(*)
        begin
        case(s)
        0:f={{4{0}},x};
        1:f=y;
        endcase
    end
    
endmodule
