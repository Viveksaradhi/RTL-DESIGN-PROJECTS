`timescale 1ns / 1ps

module sram_async_read(
    input clk,write_en,
    input [7:0] data_in,
    input [3:0] address,
    output [7:0] data_out
    );
	 reg [7:0] ram[0:15];
	 always@(posedge clk)begin
	 if(write_en) 
	 ram[address]<=data_in;
	 end
	 assign data_out=ram[address];
	 endmodule
