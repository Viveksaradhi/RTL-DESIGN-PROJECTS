`timescale 1ns / 1ps

module ALU_32bits_tb;
    reg signed [31:0]A;    
    reg signed [31:0]B;
    reg [3:0]CS;
    wire [31:0]result;
    wire zero;
    integer i,j,k;
    ALU_32bits uut (
        .A(A),
        .B(B),
        .CS(CS),
        .result(result),
        .zero(zero)
        );
     initial begin
       
       $monitor("Time=%0t | A=%0d B=%0d  | result=%0d zero=%b", $time,A,B,$signed(result),zero);
       for(i=0;i<5;i=i+1) begin
       CS=i;
       $display("CS=%b",CS);
       for(j=-2;j<3;j=j+1) begin
        for(k=-2;k<3;k=k+1) begin
        A=j;
        B=k;
        #50;
        end
       end
      end
      $finish;
     end
     
    
endmodule
