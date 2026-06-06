module comparator(
    input[15:0] entered_password,
    input [15:0]stored_password,
    output reg match);
    
 always @(*) begin
 
 match= (entered_password==stored_password);
 end
endmodule

