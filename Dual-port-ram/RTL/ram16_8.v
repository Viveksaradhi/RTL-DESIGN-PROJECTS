`timescale 1ns / 1ps
module ram16_8 #(
  parameter data_width = 8,
  parameter addr_width = 4,
  parameter depth = 16
)(
  input clk0, clk1,
  input rst,

  input [data_width-1:0] din_a,
  input [addr_width-1:0] addr_a,
  input we_a, re_a,
  output reg [data_width-1:0] dout_a,

  input [data_width-1:0] din_b,
  input [addr_width-1:0] addr_b,
  input we_b, re_b,
  output reg [data_width-1:0] dout_b
);

  reg [data_width-1:0] mem[0:depth-1];
  integer i;
  
  // Port A
  always @(posedge clk0) begin
    if (rst) 
    dout_a<=0;
    else 
    begin
      if (we_a)
        mem[addr_a] <= din_a;
        
      if (re_a)
        dout_a <= mem[addr_a];
    end
  end

  // Port B
  always @(posedge clk1) begin
    if (rst) 
    dout_b<=0;
    else begin
      if (we_b) 
        mem[addr_b] <= din_b;
        
      if (re_b)
        dout_b <= mem[addr_b]; // read input data of port-A from Port-B 
    end
  end

endmodule

