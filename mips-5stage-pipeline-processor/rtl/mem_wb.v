
module mem_wb(
   input clk,reset,
   input [31:0] memory_data_in,
   input [31:0] alu_result_in,instruction_in,
   input [4:0] destination_reg_in,
   input regwrite_in,memtoreg_in,
   output reg [31:0] memory_data_out,
   output reg [31:0] alu_result_out,instruction_out,
   output reg [4:0] destination_reg_out,
   output reg regwrite_out,memtoreg_out
    );
    always @(posedge clk or posedge reset) begin
    if(reset) begin
    memory_data_out<=0;
    alu_result_out<=0;
    destination_reg_out<=0;
    regwrite_out<=0;
    memtoreg_out<=0;
    instruction_out<=0;
    end
    else begin
    memory_data_out<=memory_data_in;
    alu_result_out<=alu_result_in;
    destination_reg_out<=destination_reg_in;
    regwrite_out<=regwrite_in;
    memtoreg_out<=memtoreg_in;
    instruction_out<=instruction_in;
    end
    end
endmodule
