`timescale 1ns / 1ps

module pc_tb;
    reg [31:0] next_int;
    reg clk,reset;
    wire [31:0] current_int;
 pc uut(
     .next_int(next_int),
     .clk(clk),
     .reset(reset),
     .current_int(current_int)
     );
     initial  clk=0;
     always #5 clk=~clk;
     initial begin
     reset=1;
     @(posedge clk);
     reset=0;
     $monitor("Time=%0t |reset=%b | next_int=%0d | current_int=%0d", $time,reset,next_int,current_int);
     next_int=8;
     @(posedge clk);
     if(current_int!=8)
     $display("Failed");
      next_int=12;
     @(posedge clk);    
     if(current_int!=12)
     $display("Failed");
     reset=1;
     @(posedge clk);
     if(current_int!=0)
     $display("Failed");
     $finish;
     end
    

endmodule
