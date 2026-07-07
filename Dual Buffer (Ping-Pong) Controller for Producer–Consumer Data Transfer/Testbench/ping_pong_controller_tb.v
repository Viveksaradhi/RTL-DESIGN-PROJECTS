`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2026 02:28:36 PM
// Design Name: 
// Module Name: ping_pong_controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ping_pong_controller_tb;
reg clk,rst_n;
reg prod_valid;
reg [7:0] prod_data;
reg cons_ready;
wire prod_ready;
wire cons_valid;
wire [7:0] cons_data;
wire active_buffer,err_overrun,err_underrun;

ping_pong_controller uut(
.clk(clk),
.rst_n(rst_n),
.prod_valid(prod_valid),
.prod_data(prod_data),
.cons_ready(cons_ready),
.prod_ready(prod_ready),
.cons_valid(cons_valid),
.cons_data(cons_data),
.active_buffer(active_buffer),
.err_overrun(err_overrun),
.err_underrun(err_underrun)
);
initial clk=0;
always #5 clk=~clk;

initial begin
//reset 
rst_n = 0;
prod_valid = 0;
prod_data = 0;
cons_ready = 0;
#20 rst_n=1;
// test 1 - normal case
prod_valid=1;
prod_data=8'h11;
#10 prod_data=8'h22;
#10 prod_data=8'h33;
#10 prod_data=8'h44;
#10 prod_valid=0;
cons_ready=1;

#40 cons_ready=0;
prod_valid=1;
prod_data=8'h55;
#10 prod_data=8'h66;
#10 prod_data=8'h77;
#10 prod_data=8'h88;
#10 prod_valid=0;
cons_ready=1;
#40 cons_ready=0;
// test 2- underrun 
cons_ready=1;
#20 cons_ready=0;
// test 3- overrun
prod_valid=1;
prod_data=8'h11;
#10 prod_data=8'h22;
#10 prod_data=8'h33;
#10 prod_data=8'h44;
#10 prod_valid=0;
#10 prod_valid=1;
prod_data=8'h55;
#10 prod_data=8'h66;
#10 prod_data=8'h77;
#10 prod_data=8'h88;
#10 prod_valid=0;
#10 prod_valid=1;
#10 prod_data=8'h99;
#10 prod_data=8'hAA;
#10 prod_data=8'hBB;
#10 prod_data=8'hCC;
#10 prod_valid=0;
// test 4 continous read two buffer
cons_ready=1;
#80 cons_ready=0;
//test 5 Simultaneous Read and Write
prod_valid = 1;
prod_data  = 8'h11;
#10 prod_data = 8'h22;
#10 prod_data = 8'h33;
#10 prod_data = 8'h44;
#10;
cons_ready = 1;
prod_data  = 8'h55;
#10 prod_data = 8'h66;
#10 prod_data = 8'h77;
#10 prod_data = 8'h88;
#10;prod_valid=0;
#40;
cons_ready=0;
end 
initial begin
$monitor(
"time=%0t active=%0b read=%0b wr_ptr=%0d rd_ptr=%0d buf0_full=%0b buf1_full=%0b cons_data=%0d,cons_ready=%0b,prod_ready=%0b,cons_valid=%0b,err_underrun=%0b,err_overrun=%0b"
,$time,
active_buffer,
uut.read_buffer,
uut.wr_ptr,
uut.rd_ptr,
uut.buf0_full,
uut.buf1_full,
cons_data,
cons_ready,
prod_ready,
cons_valid,
err_underrun,
err_overrun
);
end
initial begin
#1000;
$finish;
end
endmodule
