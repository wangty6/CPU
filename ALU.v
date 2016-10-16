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
input [31:0] a,          // ��һ��������
input [31:0] b,          // �ڶ���������
input [2:0] ALUop,       // �����ź�
output zero,             // ���Ϊ0�ź�
output reg [31:0] ALUout // ALU������
    );

always @(a or b or ALUop) 
begin
	$display ("%b %b %b", ALUop, a, b);
	case (ALUop)
		3'b000:            // ��
			begin
				ALUout = a + b;
			end
		3'b001:            // ��
			begin
				ALUout = a - b;
			end
		3'b010:            // slt
			begin
				ALUout = a < b ? 32'b1 : 32'b0;
			end
		3'b011:            // ����
			begin
				ALUout = a >> b;
			end
		3'b100:            // ����
			begin
				ALUout = a << b;
			end
		3'b101:            // ��
			begin
				ALUout = a | b;
			end
		3'b110:            // ��
			begin
				ALUout = a & b;
			end
		3'b111:            // ���
			begin
				ALUout = (~a&b | ~b&a);
			end
		default: ALUout = 0;
	endcase
end
assign zero = (ALUout == 0);  // ���ź����
endmodule
