`timescale 1ns / 1ps

module reg_file_application
    #(parameter N = 7, BITS = 4) (
    input [N - 1:0] address,
    input [BITS - 1:0] data_w,
    input clk,
    input WE,
    input choose,
    output [6:0] bcd,
    output [7:0] AN,
    output DP
    );
    
    reg [N - 1:0] address_w, address_r, address_w_next, address_r_next;
    wire [BITS - 1:0] bin;
    
    always @(posedge clk)
    begin
        address_r <= address_r_next;
        address_w <= address_w_next;
    end
    always @(choose, address, address_r, address_w)
    
    begin
        address_r_next = address_r;
        address_w_next = address_w;
        case(choose)
            0 : address_w_next = address;
            1 : address_r_next = address;
        endcase
    end
    
        
     reg_file register (
        .address_w(address_w),
        .address_r(address_r),
        .data_w(data_w),
        .clk(clk),
        .WE(WE),
        .data_r(bin)
     );
     
     hex2sseg convert (
        .hex(bin),
        .sseg(bcd)
     );
     
     assign AN=8'b11111110;
     assign DP = 0;
    
endmodule
