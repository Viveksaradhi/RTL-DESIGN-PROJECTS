`timescale 1ns / 1ps

module uart_tb;
 reg clk,reset,tx_start;
 reg [7:0] data_in;
 wire tx;
 uart uut(
 .clk(clk),
 .reset(reset),
 .tx_start(tx_start),
 .data_in(data_in),
 .tx(tx)
 );
 initial clk=0;
 always #10 clk=~clk;
 initial begin
 $monitor("time=%t  , reset=%b , tx_start=%b ,data_in=%b , tx=%b", $time ,reset,tx_start,data_in,tx);
 
 reset=1;
 tx_start=0;
 data_in=0;
 
 #40;
 reset=0;
 #40;
 tx_start=1;
 data_in=8'b10010011;
 
 #20;
 tx_start=0;
 #2000000;
 
 
 $finish;
 end
endmodule
