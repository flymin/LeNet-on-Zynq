`timescale 1ns / 1ps

module ReLU_test();

    reg clk = 0;
    reg clken = 0;
    reg [32*2*2*1 - 1:0] data;
    wire [32 - 1:0] out1;
    wire [32 - 1:0] out2;
    wire [32 - 1:0] out3;
    wire [32 - 1:0] out4;
    
    wire [32*4-1 : 0] out;
    
    assign {out4, out3, out2, out1} = out;
    ReLU #(
        .BITWIDTH(32),
    
        .DATAWIDTH(4),
        .DATAHEIGHT(4),
        .CHANNEL(1)         //channel shared by input and kernel
    )
    relu(
        .clk(clk),
        .clken(clken),
        .data(data),
        .result(out)
    );
    
    initial begin
        #100;
        clken = 1;
        data[31:0] = -1;
        data[63:32] = 2;
        data[95:64] = -3;
        data[127:96] = 4;
        # 100;
        
    end
    
    always #5 begin
        clk = ~clk;
    end
    
endmodule