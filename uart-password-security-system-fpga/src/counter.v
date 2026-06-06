module counter(
    input clk,reset,increment,clear_count,
    output reg attempts_done
    );
reg [1:0]count;

always@(posedge clk or posedge reset) begin
if(reset) 
count<=0;
else if(count==2 && increment || clear_count==1) 
count<=0;
else if(increment)
count<=count+1;
end


always@(*) begin
attempts_done=(count==2 && increment);
end
endmodule
