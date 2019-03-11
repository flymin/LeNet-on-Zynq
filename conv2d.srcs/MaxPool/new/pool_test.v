`timescale 1ns / 1ps

module pool_test();

    reg clk = 0;
    reg clken = 0;
    reg [32*4*4*1 - 1:0] data;
    wire [32 - 1:0] out1;
    wire [32 - 1:0] out2;
    wire [32 - 1:0] out3;
    wire [32 - 1:0] out4;
    
    wire [32*4-1 : 0] out;
    
    assign {out4, out3, out2, out1} = out;
    Max_pool #(
        .BITWIDTH(32),
    
        .DATAWIDTH(4),
        .DATAHEIGHT(4),
        .CHANNEL(1),         //channel shared by input and kernel
    
        .KHEIGHT(2),
        .KWIDTH(2)
    )
    pool(
        .clk(clk),
        .clken(clken),
        .data(data),
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
        # 100;
        
    end
    
    always #5 begin
        clk = ~clk;
    end
    
endmodule