`timescale 1ns / 1ps

module Full_test();

    reg clk = 0;
    reg clken = 0;
    reg [32*4 - 1:0] data;
    reg [32*4*3*1*1 - 1:0] W;
    reg [32*3 - 1:0] B = 31'b0;
    wire [64 - 1:0] out1;
    wire [64 - 1:0] out2;
    wire [64 - 1:0] out3;
    
    wire [64*3-1 : 0] out;
    
    assign {out3, out2, out1} = out;
    FullConnect #(
        .BITWIDTH(32),
    
        .LENGTH(4),
        .OUTLEN(3)
    )
    fullconnect(
        .clk(clk),
        .clken(clken),
        .data(data),
        .weight(W),
        .bias(B),
        .result(out)
    );
    
    initial begin
        #100;
        clken = 1;
        data[31:0] = 1;
        data[63:32] = 2;
        data[95:64] = 3;
        data[127:96] = 4;
       
        W[32*1 - 1: 32*0] = 9;
        W[32*2 - 1: 32*1] = -8;
        W[32*3 - 1: 32*2] = 7;
        W[32*4 - 1: 32*3] = -6;
        W[32*5 - 1: 32*4] = 5;
        W[32*6 - 1: 32*5] = -4;
        W[32*7 - 1: 32*6] = -3;
        W[32*8 - 1: 32*7] = 2;
        W[32*9 - 1: 32*8] = -1;
        W[32*10 - 1: 32*9] = 2;
        W[32*11 - 1: 32*10] = -3;
        W[32*12 - 1: 32*11] = 4;
//        W[32*13 - 1: 32*12] = -5;
//        W[32*14 - 1: 32*13] = 6;
//        W[32*15 - 1: 32*14] = -7;
//        W[32*16 - 1: 32*15] = 8;
        
        # 100;
        
    end
    
    always #5 begin
        clk = ~clk;
    end
    
endmodule