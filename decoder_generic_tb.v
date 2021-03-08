`timescale 1ns / 1ps
module decoder_generic_tb();

    reg [2:0] w;
    reg en;
    wire [0:7] y;
    
    decoder_generic DUT(
    .w(w),
    .en(en),
    .y(y)
    );
    
    initial begin
    w=3'b000;
    en=1;
    #20
    w=3'b001;
    en=1;
    #20
    w=3'b010;
    en=1;
    #20
    w=3'b011;
    en=1;
    #20
    w=3'b100;
    en=1;
    #20
    w=3'b101;
    en=1;
    #20
    w=3'b110;
    en=1;
    #20
    w=3'b111;
    en=1;
    #20
    $finish;
    end

endmodule
