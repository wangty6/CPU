`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:17 04/14/2016 
// Design Name: 
// Module Name:    Extend 
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

module Extend(
input [1:0] ExtSel,                       // ÊÇ·ñ·ûºÅÀ©Õ¹ÐÅºÅ
input [15:0] imm_16,
output reg [31:0] imm_32);
	always @ (*)
		case (ExtSel)
			2'b00: imm_32 = {27'b0, imm_16[10:6]};
			2'b01: imm_32 = {16'b0, imm_16};
			2'b10: imm_32 = (imm_16[15] == 1) ? {16'hffff, imm_16} : {16'b0, imm_16}; 
			2'b11: imm_32 = 32'b0;
		endcase
endmodule
