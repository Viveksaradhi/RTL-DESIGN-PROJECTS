`timescale 1ns / 1ps

module register_file_tb;
    reg clk,regwrite;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;  
    integer i;  
register_file uut(
  .clk(clk),
  .regwrite(regwrite),
  .read_reg1(read_reg1),
  .read_reg2(read_reg2),
  .write_reg(write_reg),
  .write_data(write_data),
  .read_data1(read_data1),
  .read_data2(read_data2)
  );
  initial clk=0;
  always #5 clk=~clk;
  initial begin
  regwrite=0;
  read_reg1=0;
  read_reg2=0; write_reg=0; write_data=0;
  $monitor("Time=%0t | regwrite=%b | read_reg1=%0d | read_reg2=%0d | write_reg=%0d | write_data=%0d | read_data1=%0d | read_data2=%0d",$time,
                 regwrite,read_reg1,read_reg2,write_reg,write_data,read_data1,read_data2);
   for(i=0;i<32;i=i+1) begin 
   if(i<27) begin
   regwrite=1;
   write_reg=i;
   write_data=i+10;
   end
   else if(i>26) begin
    regwrite=0;
   write_reg=i;
   write_data=i+10;
   end
   @(posedge clk);
   if(i>0 && i<20)begin
   read_reg1=i;
   read_reg2=i-1;
   end
   else if(i>19)begin 
   read_reg1=i;
   read_reg2=i; 
   end
   end
  end
endmodule
