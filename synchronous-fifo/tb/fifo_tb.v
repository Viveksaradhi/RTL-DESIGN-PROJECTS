`timescale 1ns / 1ps

module fifo_tb;
    reg reset,clk,write_enable,read_enable,cs;
    reg [31:0] data_in;
    wire[31:0] data_out;
    wire empty,full;
    
fifo_sync uut(.reset(reset), .clk(clk), .write_enable(write_enable), .read_enable(read_enable), .cs(cs),
 .data_in(data_in), .data_out(data_out), .empty(empty), .full(full));
 
initial clk=0;
always #5 clk=~clk;
initial begin
$monitor("time=%0t reset=%b write=%b read=%b data_in=%h data_out=%h empty=%b full=%b",
$time, reset, write_enable, read_enable, data_in, data_out, empty, full);


reset=1;
cs=0;
write_enable=0;
read_enable=0;
data_in=1;

#20;
reset=0;
cs=1;

#10 write_enable = 1; data_in = 32'hA1;
#10 data_in = 32'hA2;
#10 data_in = 32'hA3;
#10 data_in = 32'hA4;

write_enable = 0;

#10 read_enable = 1;
#10;
#10;
#10;

read_enable = 0;

write_enable=1;
repeat(10) begin
#10 data_in= $random;
end
write_enable=0;

read_enable=1;
repeat(10) begin
#10;
end

read_enable=0;

#50 $finish;
 end   
endmodule
