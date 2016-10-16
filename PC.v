`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:02 04/14/2016 
// Design Name: 
// Module Name:    PC 
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

module PC(
input clk,
input [31:0] pc,                                                 // 当前的pc指向的位置
input [31:0] Banch,                                              // 指令偏移量
input [1:0] PCSrc, 
input PCWre,                                             // 控制信号
input [31:0] rs_out,
input [25:0] addr,
output reg [31:0] nextpc);                                       // 下一个pc的值
	/*always @ (posedge clk) begin
		if (PCWre) begin
			nextpc = pc + 4;
			nextpc = (PCSrc) ? {Banch[29:0], 2'b00} + nextpc: nextpc;
		end
	end*/
	reg [31:0] _nextpc;
	always @ (*) begin
		case (PCSrc)
			2'b00: _nextpc = pc + 4;
			2'b01: _nextpc = pc + 4 + {Banch[29:0], 2'b00};
			2'b10: _nextpc = rs_out;
			2'b11: _nextpc = {pc[31:28], addr, 2'b00};
		endcase
	end
	
	always @ (negedge clk) begin
		if (PCWre)	
			nextpc = _nextpc;
	end
endmodule