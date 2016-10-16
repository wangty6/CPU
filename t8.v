`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:12:10 05/16/2016
// Design Name:   CPU
// Module Name:   C:/Users/Tianyu/Desktop/School/CPU_single/t8.v
// Project Name:  CPU_single
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t8;

	// Inputs
	reg clk;
	reg setpc;
	reg [31:0] pcset;

	// Outputs
	wire [31:0] pc;
	wire [31:0] inst;
	wire [31:0] rs_out;
	wire [31:0] rt_out;
	wire zero;
	wire PCWre;
	wire ALUSrcB;
	wire ALUM2Reg;
	wire RegWre;
	wire InsMemRW;
	wire DataMemRW;
	wire WrRegData;
	wire IRWre;
	wire [1:0] ExtSel;
	wire [1:0] PCSrc;
	wire [1:0] RegOut;
	wire [2:0] ALUop;
	wire [31:0] ALUout;
	wire [2:0] q;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.setpc(setpc), 
		.pcset(pcset), 
		.pc(pc), 
		.inst(inst), 
		.rs_out(rs_out), 
		.rt_out(rt_out), 
		.zero(zero), 
		.PCWre(PCWre), 
		.ALUSrcB(ALUSrcB), 
		.ALUM2Reg(ALUM2Reg), 
		.RegWre(RegWre), 
		.InsMemRW(InsMemRW), 
		.DataMemRW(DataMemRW), 
		.WrRegData(WrRegData), 
		.IRWre(IRWre), 
		.ExtSel(ExtSel), 
		.PCSrc(PCSrc), 
		.RegOut(RegOut), 
		.ALUop(ALUop), 
		.ALUout(ALUout), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		setpc = 1;
		pcset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		forever #5 clk = ~clk;
	end
      
endmodule

