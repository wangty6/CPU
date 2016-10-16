`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:09 04/14/2016 
// Design Name: 
// Module Name:    Control 
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

module Control(
input clk,
input [5:0] op,                                                                     // 解析出来的操作
input zero,
output [2:0] ALUop, 
output [1:0] PCSrc, RegOut, ExtSel,
output PCWre, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, WrRegData, IRWre,
output reg [2:0] q
	);
	reg RST;
	wire add, addi, sub, ori, and_, or_, move, sw, lw, beq, halt, sll, slt, j, jr, jal;                    // 分别选择出各个指令
	assign add = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
   assign sub = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0];
   assign addi = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
   assign or_ = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
   assign and_ = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & op[0];
   assign ori = ~op[5] & op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
	assign sll = ~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
   assign move = op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
	assign slt = op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0];
   assign sw = op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
   assign lw = op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & op[0];
   assign beq = op[5] & op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
	assign j = op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
	assign jr = op[5] & op[4] & op[3] & ~op[2] & ~op[1] & op[0];
	assign jal = op[5] & op[4] & op[3] & ~op[2] & op[1] & ~op[0];
   assign halt = op[5] & op[4] & op[3] & op[2] & op[1] & op[0];
	
	assign ALUop[2] = sll | or_ | ori | and_;                                                 // ALU控制信号的逻辑表达式
	assign ALUop[1] = slt | and_;
	assign ALUop[0] = beq | sub | or_ | ori;
                                                          // 控制信号输出
   assign ALUSrcB = addi | ori | sw | lw | sll;
   assign ALUM2Reg = lw;
   assign InsMemRW = 0;
	assign WrRegData = ~jal;
	assign PCSrc[1] = jr | j | jal;
	assign PCSrc[0] = (zero & beq) | j | jal;
	assign RegOut[1] = add | sub | or_ | and_ | move | slt | sll;
	assign RegOut[0] = addi | ori | lw;
	assign ExtSel[1] = addi | lw | sw | beq;
	assign ExtSel[0] = ori;
	
	assign IRWre = ~q[2] & ~q[1] & q[0];
	assign PCWre = (~q[2] & ~q[1] & ~q[0] & ~halt);
	assign RegWre = (q[2] & q[1] & q[0]) | (q[2] & ~q[1] & ~q[0]) | jal;
	assign DataMemRW = sw && (~q[2] & q[1] & q[0]);
	
	initial begin
		RST = 1;
		q = 3'b000;
	end;
	
	
	/*always @(posedge clk) begin
		$display ("%b", op);
		$display ("%b", q);
		q = q + 1;
		if ((j | jal | jr | halt) && (q == 2))
			q = 0;
		if ((beq) && (q == 3))
		   q = 0;
		if ((add | sub | addi | or_ | and_ | ori | move | slt | sll | sw) && (q == 4))
			q = 0;
		if ((lw) && (q == 5))
			q = 0;
   end
	*/
	always @(posedge clk) begin
		$display ("op %b\n", op);
		$display ("%b->", q);
		if (q == 3'b000) begin
			q = 3'b001;
		end
		else if (q == 3'b001 && (add | sub | addi | or_ | and_ | ori | move | slt | sll)) begin
			q = 3'b110;
		end
		else if (q == 3'b110) begin
			q = 3'b111;
		end
		else if (q == 3'b111) begin
			q = 3'b000;
		end
		else if (q == 3'b001 && (j | jal | jr | halt)) begin
			q = 3'b000;
		end
		else if (q == 3'b001 && beq) begin
			q = 3'b101;
		end
		else if (q == 3'b101) begin
			q = 3'b000;
		end
		else if (q == 3'b001 && (lw | sw)) begin
			q = 3'b010;
		end
		else if (q == 3'b010) begin
			q = 3'b011;
		end
		else if (q == 3'b011 && lw) begin
			q = 3'b100;
		end
		else if (q == 3'b100) begin
			q = 3'b000;
		end
		else if (q == 3'b011 && sw) begin
			q = 3'b000;
		end
		if ((RST == 1) && (~q[2] & ~q[1] & q[0])) begin
			$display ("FUCK YOU");
			q = 3'b000;
			RST = 0;
		end
		$display ("%b", q);
	end
		
	
	
endmodule
