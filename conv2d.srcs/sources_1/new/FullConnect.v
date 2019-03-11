`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2018 04:00:05 PM
// Design Name: 
// Module Name: FullConnect
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


module FullConnect #(
    parameter BITWIDTH = 8,
    parameter LENGTH = 25,
    parameter OUTLEN = 10
    )
    (
    input clk,
    input clken,
    input [BITWIDTH * LENGTH - 1 : 0] data,
    input [BITWIDTH * LENGTH * OUTLEN - 1 : 0] weight,
    input [BITWIDTH * OUTLEN - 1 : 0] bias,
    //output [BITWIDTH * 2 * OUTLEN - 1 : 0] result
    output reg [BITWIDTH * 2 * OUTLEN - 1 : 0] result
    );
    //reg [BITWIDTH * 2 * LENGTH * OUTLEN- 1:0] out;
    wire [BITWIDTH * 2 - 1:0] out [0:OUTLEN - 1][0:LENGTH - 1];
    wire signed [BITWIDTH - 1:0] biasArray[0:OUTLEN - 1];
    reg signed [BITWIDTH * 2 - 1:0] resultArray [0:OUTLEN - 1];
    wire [BITWIDTH * 2 * OUTLEN - 1 : 0] out2;
    genvar i, j;
    generate
        for(i = 0; i < OUTLEN; i = i + 1) begin
            assign biasArray[i] = bias[(i + 1) * BITWIDTH - 1: i * BITWIDTH];
            //assign result[(i + 1) * BITWIDTH * 2 - 1: i * BITWIDTH * 2] = resultArray[i];
            assign out2[(i + 1) * BITWIDTH * 2 - 1: i * BITWIDTH * 2] = resultArray[i];
        end
    endgenerate
    generate
        for(i = 0; i < OUTLEN; i = i + 1) begin
            for(j = 0; j < LENGTH; j = j + 1) begin
                Mult #(BITWIDTH) mult(  data[(j + 1) * BITWIDTH - 1:j * BITWIDTH], 
                                        weight[(j * OUTLEN + i) * BITWIDTH + BITWIDTH - 1 : (j * OUTLEN + i) * BITWIDTH], 
                                        out[i][j]);
            end
        end
    endgenerate
    integer sum, m, n;
    always @(*) begin
        for(m = 0; m < OUTLEN; m = m + 1) begin
            sum = 0;
            for(n = 0; n < LENGTH; n = n + 1) begin
                sum = sum + out[m][n];
            end
            sum = sum + biasArray[m];
            resultArray[m] = sum;
        end
    end
    always @(posedge clk) begin
        if(clken == 1) begin
            result = out2;
        end
    end
endmodule
