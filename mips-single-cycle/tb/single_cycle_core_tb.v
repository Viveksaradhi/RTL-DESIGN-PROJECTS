`timescale 1ns / 1ps

    module single_cycle_core_tb;
        reg clk,reset;
        wire  [31:0] pc_debug;
        wire  [31:0] instruction_debug;
        
    single_cycle_core uut(
          .clk(clk),
          .reset(reset),
          .pc_debug(pc_debug),
          .instruction_debug(instruction_debug)
          );
         initial begin  $monitor ("Time=%0t PC=%h Instruction=%h", $time, pc_debug, instruction_debug); end
           initial clk=0;
           always #5 clk=~clk;
           initial begin
           reset=1;
           #20;
           @(posedge clk);
           reset=0;
           repeat(20) @(posedge clk);
           
           $display("/n Register REsults:");
           $display("$t0=%d", uut.uut3.registers[8]);
           $display("$t1=%d", uut.uut3.registers[9]);
           $display("$t2=%d", uut.uut3.registers[10]);
           $display("$t3=%d", uut.uut3.registers[11]);
           $display("$t4=%d", uut.uut3.registers[12]);
           $display("$t5=%d", uut.uut3.registers[13]);
           $display("$t6=%d", uut.uut3.registers[14]);
           $display("$t7=%d", uut.uut3.registers[15]);
           $display("$s0=%d", uut.uut3.registers[16]);
           $display("$s1=%d", uut.uut3.registers[17]);
           $display("$s2=%d", uut.uut3.registers[18]);
           $display("Menory[0] =%d", uut.uut8.memory[0]);
           $display("Menory[4] =%d", uut.uut8.memory[4]);
           $finish;
          
           end  
    endmodule
