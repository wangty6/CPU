`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:16 04/14/2016 
// Design Name: 
// Module Name:    DataMem 
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

module DataMem(
input [31:0]DataAddr,                        // 内存地址
input [31:0]DataIn,                          // 将要存入内存的数据
input DataMemRW,                             // 内存读写控制
output reg [31:0]DataOut                     // 内存读数据输出端
);
   reg [7:0] Mem[63: 0];
	
	initial  begin                            // 初始化内存
	end
	
	always @(DataMemRW or DataAddr or DataIn)
		#2
		if (DataMemRW) begin                   // sw
			{Mem[DataAddr + 3], Mem[DataAddr + 2], Mem[DataAddr + 1], Mem[DataAddr + 0]} = DataIn;
		end
		else begin                             // lw
			DataOut = {Mem[DataAddr + 3], Mem[DataAddr + 2], Mem[DataAddr + 1], Mem[DataAddr]};
		end

endmodule