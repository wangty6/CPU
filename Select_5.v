`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:37 04/14/2016 
// Design Name: 
// Module Name:    Select_5 
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

module Select_5(                    // 5位选择器
input [1:0] en,                           // 选择信号
input [4:0] in0, in1, in2,
output reg [4:0] out);
	always @ (*)
		case (en)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: ;
		endcase
endmodule
