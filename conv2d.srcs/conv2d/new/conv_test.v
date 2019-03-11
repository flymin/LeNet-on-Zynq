`timescale 1ns / 1ps

module conv_test();

    reg clk = 0;
    reg clken = 0;
    reg [32*4*4*1 - 1:0] data;
    reg [32*3*3*1*1 - 1:0] fW;
    reg [32*1 - 1:0] fB = 31'b0;
    wire [64 - 1:0] out1;
    wire [64 - 1:0] out2;
    wire [64 - 1:0] out3;
    wire [64 - 1:0] out4;
    
    wire [64*4-1 : 0] out;
    
    assign {out4, out3, out2, out1} = out;
    conv2d #(
        .BITWIDTH(32),
    
        .DATAWIDTH(4),
        .DATAHEIGHT(4),
        .CHANNEL1(1),         //channel shared by input and kernel
    
        .FILTERHEIGHT(3),
        .FILTERWIDTH(3),
        .FILTERBATCH(1),      //how many filter to cal every cycle
    
        .STRIDEHEIGHT(1),
        .STRIDEWIDTH(1),
    
        .PADDINGENABLE(0)
    )
    conv(
        .clk(clk),
        .clken(clken),
        .data(data),
        .filterWeight(fW),
        .filterBias(fB),
        .result(out)
    );
    
    initial begin
        #100;
        clken = 1;
        data[31:0] = 1;
        data[63:32] = 2;
        data[95:64] = 3;
        data[127:96] = 4;
        data[32*5 - 1:32*4] = 5;
        data[32*6 - 1:32*5] = 6;
        data[32*7 - 1:32*6] = 7;
        data[32*8 - 1:32*7] = 8;
        data[32*9 - 1:32*8] = 9;
        data[32*10 - 1:32*9] = 10;
        data[32*11 - 1:32*10] = 11;
        data[32*12 - 1:32*11] = 12;
        data[32*13 - 1:32*12] = 13;
        data[32*14 - 1:32*13] = 14;
        data[32*15 - 1:32*14] = 15;
        data[32*16 - 1:32*15] = 16;
        
        fW[32*1 - 1: 32*0] = 9;
        fW[32*2 - 1: 32*1] = 8;
        fW[32*3 - 1: 32*2] = 7;
        fW[32*4 - 1: 32*3] = 6;
        fW[32*5 - 1: 32*4] = 5;
        fW[32*6 - 1: 32*5] = 4;
        fW[32*7 - 1: 32*6] = 3;
        fW[32*8 - 1: 32*7] = 2;
        fW[32*9 - 1: 32*8] = 1;
        # 100;
        
    end
    
    always #5 begin
        clk = ~clk;
    end
    
endmodule