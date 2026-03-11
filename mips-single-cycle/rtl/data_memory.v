module data_memory(
    input clk,
    input memread,
    input memwrite,
    input [31:0] address,
    input [31:0] writedata,
    output [31:0] read_data
    );  
    reg [31:0] memory [255:0];
    assign read_data = (memread)? memory[address[31:2]]:32'b0;
    
    always @(posedge clk) begin
     if(memwrite)
     memory[address[31:2]]<=writedata;
    end
endmodule
