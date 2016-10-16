`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:55 04/14/2016 
// Design Name: 
// Module Name:    Instmem 
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

module Instmem(
input [31:0] pc,
input InsMemRW,
output [31:0] inst);
	reg [7:0] mem[100:0];
	
	initial begin
		$readmemb("instmemfile.txt", mem);
	end
	assign inst = InsMemRW ? 0 : {mem[pc], mem[pc + 1], mem[pc + 2], mem[pc + 3]};  //输出pc对应的指令
endmodule
