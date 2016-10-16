`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:57 04/09/2016 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
input clk,
input setpc,
input [31:0] pcset,
output reg [31:0] pc,
output [31:0] inst, rs_out, rt_out,
output zero,
output PCWre, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, WrRegData, IRWre,
output [1:0] ExtSel, PCSrc, RegOut,
output [2:0] ALUop,
output [31:0] ALUout,
output [2:0] q
    );
	 wire [4:0] rs, rt, rd, Rd;
	 wire [5:0] op;
	 wire [15:0] imm_16;
	 wire [31:0] wd, Wd, imm_32, Rt_out, nextpc, DataOut, d_inst, d_rs_out, d_rt_out, d_wd, d_Wd, WWd;
	 wire [25:0] addr;
	 
	 Instmem instmem(pc, InsMemRW, inst);
	 
	 IR ir(clk, IRWre, inst, d_inst);
	 
	 assign op = d_inst[31:26];     // 把指令中的操作码等信息从指令中分离出来
	 assign rs = d_inst[25:21];
	 assign rt = d_inst[20:16];
	 assign rd = d_inst[15:11];
	 assign imm_16 = d_inst[15:0];
	 assign addr = d_inst[25:0];
	 
	 
	 Control control(clk, op, zero, ALUop, PCSrc, RegOut, ExtSel, PCWre, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, WrRegData, IRWre, q);
	 Select_5 select_RegOut(RegOut, 5'b11111, rt, rd, Rd);
	 Regfile regfile(rs, rt, Rd, WWd, RegWre, clk, rs_out, rt_out);
	 D da(clk, rs_out, d_rs_out);
	 D db(clk, rt_out, d_rt_out);
	 Extend extend(ExtSel, imm_16, imm_32);
	 Select_32 select_ALUSrcB(ALUSrcB, d_rt_out, imm_32, Rt_out);
	 ALU alu(d_rs_out, Rt_out, ALUop, zero, wd);
	 D dwd(clk, wd, d_wd);
	 DataMem datamem(d_wd, d_rt_out, DataMemRW, DataOut);
	 Select_32 select_ALUM2Reg(ALUM2Reg, wd, DataOut, Wd);
	 D dWd(clk, Wd, d_Wd);
	 Select_32 select_WrRegData(WrRegData, pc + 4, d_Wd, WWd);
	 assign ALUout = d_Wd;
	 PC next(clk, pc, imm_32, PCSrc, PCWre, rs_out, addr, nextpc);
	 
	 always @ (nextpc) begin   // 每当nextpc改变的时候将pc赋值为nextpc
		pc <= nextpc;
	 end
	 always @ (setpc) begin    // pc清零信号处理
		if (setpc) begin
				pc = pcset;
				//setpc = 0;
			end
	 end
endmodule
