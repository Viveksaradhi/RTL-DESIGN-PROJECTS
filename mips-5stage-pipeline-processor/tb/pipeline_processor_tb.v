`timescale 1ns / 1ps

 module pipeline_processor_tb;
        reg clk,reset;
        wire  [31:0] pc;
        wire [31:0] instruction_IF,instruction_ID,instruction_EX,instruction_MEM,instruction_WB;
        wire [31:0] alu_result;
        wire [31:0] memory_data;
        wire [1:0] forwardingA,forwardingB;
        wire pcwrite,flush_idex,if_id_write;
        integer cycle;
        
    pipeline_processor uut(     
          .clk(clk),
          .reset(reset),
          .pc_debug(pc),
          .instruction_IF(instruction_IF),
          .instruction_ID(instruction_ID),
          .instruction_EX(instruction_EX),
          .instruction_MEM(instruction_MEM),
          .instruction_WB(instruction_WB),
          .alu_result_debug(alu_result),
          .memory_data_debug(memory_data),
          .forwardingA_debug(forwardingA),
          .forwardingB_debug(forwardingB),
          .pcwrite_debug(pcwrite),
          .if_id_write_debug(if_id_write),
          .flush_idex_debug(flush_idex)
          );
          always@ (posedge clk) begin  
          $display("Cycle=%0d PC=%h | IF=%h ID=%h EX=%h MEM=%h WB=%h | ALU=%h MEMDATA=%h | frwA=%b frwB=%b pcwrite=%b flush=%b ifid=%b",
                             cycle, pc, instruction_IF, instruction_ID, instruction_EX, instruction_MEM, instruction_WB,
                             alu_result, memory_data, forwardingA, forwardingB, pcwrite, flush_idex, if_id_write);  end
           
           initial begin clk=0; cycle=0; end
           always #5 clk=~clk;
           always @(posedge clk) begin
           if(reset)
           cycle<=0;
           else
           cycle<=cycle+1;
           end
           always @(posedge clk) begin
           if(instruction_IF == 32'hFFFFFFFF) begin
           $display("HALT detected. Simulation stopping.");
           $finish;
           end
           end

           initial begin
           reset=1;         
           #20;
           @(posedge clk); 
           reset=0;
           end  
    endmodule
