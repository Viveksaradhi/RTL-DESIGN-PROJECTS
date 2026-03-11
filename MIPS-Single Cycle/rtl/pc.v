module pc(
    input [31:0] next_int,
    input clk,reset,
    output reg [31:0] current_int
    );
    always @(posedge clk) begin
    if(reset)
    current_int<=0;
    else
    current_int<=next_int;
    end
endmodule
