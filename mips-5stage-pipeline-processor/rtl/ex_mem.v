module ex_mem(
    input clk,reset,
    input [31:0] alu_result_in,instruction_in,
    input [31:0] write_data_in,
    input [4:0] destination_reg_in,
    input memread_in,memwrite_in,regwrite_in,memtoreg_in,
    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,instruction_out,
    output reg [4:0]  destination_reg_out,
    output reg memread_out,memwrite_out,regwrite_out,memtoreg_out
    );
    
    
    always @(posedge clk or posedge reset) begin
    if(reset) begin
    alu_result_out<=0;
    write_data_out<=0;
    destination_reg_out<=0; 
    memread_out<=0;
    memwrite_out<=0;
    regwrite_out<=0;
    memtoreg_out<=0;
    instruction_out<=0;
    end
    else begin
    alu_result_out<=alu_result_in;
    write_data_out<=write_data_in;
    destination_reg_out<=destination_reg_in; 
    memread_out<=memread_in;
    memwrite_out<=memwrite_in;
    regwrite_out<=regwrite_in;
    memtoreg_out<=memtoreg_in;
    instruction_out<=instruction_in;
    end
    end
endmodule
