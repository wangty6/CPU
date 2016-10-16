`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:52 04/14/2016 
// Design Name: 
// Module Name:    Select_32 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Select_32(                   // 32位选择器
input en,                           // 选择信号
input [31:0] A, B,
output [31:0] out);
	assign out = (en == 0) ? A : B;  // 选择信号为0时输出A，否则输出B
endmodule
