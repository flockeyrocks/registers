`timescale 1ns / 1ps

module reg_file
    #(parameter N = 7, BITS = 4)(
    input [N - 1:0] address_w, address_r,
    input [BITS - 1:0] data_w,
    input clk,
    input WE,
    output [BITS - 1:0] data_r
    );
    
    wire [2**N:0] addr_w, addr_r;
    
    //determine 128 bit data address from 7 bit input
    decoder_generic write_address (
        .w(address_w),
        .en(WE),
        .y(addr_w)
    );
    
    //determine 128 bit read address from 7 bit input
    decoder_generic read_address (
        .w(address_r),
        .en(1),
        .y(addr_r)
    );
    
    
    //only 1 bit of data address will be active
    //for loop through all values and apply data_w to that address of toBuffer
    //toBuffer goes to tri-state buffer for read
    genvar k;
    generate
        for (k = 0; k < 2 ** N; k = k + 1)
        begin
            wire[BITS-1:0] toBuffer; 
            simple_register_load #(BITS) loader(
            .clk(clk),
            .load(addr_w[k]),
            .I(data_w),
            .Q(toBuffer)
            );
            
            //only 1 bit of read address will be active
            //tristate buffer allows value to pass if enable is 1
            //otherwise its in high impedance state
            assign data_r = addr_r[k] ? toBuffer : {(N-1){1'bz}};
        end
    endgenerate
    
endmodule
