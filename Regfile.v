`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:51:30 04/14/2016 
// Design Name: 
// Module Name:    Regfile 
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

module Regfile(rs,rt,rd,wd,RegWre,clk,rs_out,rt_out);
	input 	[4:0]	rs,rt,rd;                             // �����ź�
	input 	[31:0] 	wd;
	input		RegWre,clk;
	output 	[31:0] 	rs_out, rt_out;
	reg 	[31:0] 	register [31:1];                      // 1��31�żĴ�����0�żĴ���Ϊ0
	initial begin
	end
	always @(negedge clk)
		begin
			$display("rd %b", rd);
			$display("wd %b", wd);
			if ((rd != 0) && (RegWre == 1))                // ��rdд����
			register[rd] = wd;
		end
	assign rs_out = (rs == 0)? 0 : register[rs];         // ��rs�Ĵ����ж�������
	assign rt_out = (rt == 0)? 0 : register[rt];         // ��rt�Ĵ����ж�������
endmodule
