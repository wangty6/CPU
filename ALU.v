`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:46 04/14/2016 
// Design Name: 
// Module Name:    ALU 
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

 module ALU(
input [31:0] a,          // 第一个操作数
input [31:0] b,          // 第二个操作数
input [2:0] ALUop,       // 控制信号
output zero,             // 结果为0信号
output reg [31:0] ALUout // ALU结果输出
    );

always @(a or b or ALUop) 
begin
	$display ("%b %b %b", ALUop, a, b);
	case (ALUop)
		3'b000:            // 加
			begin
				ALUout = a + b;
			end
		3'b001:            // 减
			begin
				ALUout = a - b;
			end
		3'b010:            // slt
			begin
				ALUout = a < b ? 32'b1 : 32'b0;
			end
		3'b011:            // 右移
			begin
				ALUout = a >> b;
			end
		3'b100:            // 左移
			begin
				ALUout = a << b;
			end
		3'b101:            // 或
			begin
				ALUout = a | b;
			end
		3'b110:            // 且
			begin
				ALUout = a & b;
			end
		3'b111:            // 异或
			begin
				ALUout = (~a&b | ~b&a);
			end
		default: ALUout = 0;
	endcase
end
assign zero = (ALUout == 0);  // 零信号输出
endmodule
