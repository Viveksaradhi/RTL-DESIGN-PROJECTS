`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2026 10:44:12 AM
// Design Name: 
// Module Name: booths_tb
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


module booths_tb;
    reg clk,reset;
    reg [3:0]M,Q;
    wire [7:0]y;
    
    
boothms uut(
  .clk(clk),
  .reset(reset),
  .M(M),
  .Q(Q),
  .y(y)
  );
  
  initial clk=0;
  
  always #5 clk=~clk;
  initial begin
  M=4'b0001;
  Q=4'b1001;
  
  reset=1;
  #10  reset=0;
  #200 $finish;
  end
  initial begin 
  $monitor("$time=%0t A=%b ,q=%b ,y=%b",
            $time,uut.A,uut.q,y);
  end
endmodule
