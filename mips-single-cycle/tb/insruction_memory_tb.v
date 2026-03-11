`timescale 1ns / 1ps

module insruction_memory_tb;
    reg [31:0] address;
    wire [31:0] instruction;
instruction_memory uut(
     .address(address),
     .instruction(instruction)
     );
     initial begin
     address=4;
     #10;
     address=8;
     #10;
     address=16;
     #10;
     address=40;
     #10;
     $finish;
     end
endmodule
