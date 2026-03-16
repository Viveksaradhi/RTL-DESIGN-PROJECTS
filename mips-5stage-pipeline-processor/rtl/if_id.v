module if_id(
    input clk,reset,write_enable,
    input flush,
    input [31:0] instruction_in,
    input [31:0] pc4_in,
    output reg [31:0] instruction_out,
    output reg [31:0] pc4_out
    );
    parameter NOP = 32'b00000000000000000000000000000000;
   always @(posedge clk or posedge reset) begin
    if(reset) begin
    instruction_out<=NOP;
    pc4_out<=NOP;
    end
    else if(flush) begin
    instruction_out<=NOP;
    pc4_out<=NOP;
    end
    else if(write_enable)begin
    instruction_out<=instruction_in;
    pc4_out<=pc4_in;
    end
    end
endmodule
