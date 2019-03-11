`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2018 03:43:07 PM
// Design Name: 
// Module Name: ReLU_kernel
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


module Relu_kernel #(
    parameter BITWIDTH = 8,
    parameter THRESSHOLD = 0
    )
    (
    input signed [BITWIDTH - 1:0] data,
    output signed [BITWIDTH - 1:0] result
    );
    
    assign result = data > THRESSHOLD ? data : THRESSHOLD;

endmodule