
module timers(
   input start_timer,clk,reset,
   output  timer_done
    );
parameter lock_time=500_000_000;
reg [31:0]counter;

always @(posedge clk or posedge reset) begin

if(reset)  
counter<=0;


else begin
if(start_timer) begin
if( counter!=lock_time-1)
counter<=counter+1;
end
else
counter<=0;
end
end


assign timer_done=(counter==lock_time-1 && start_timer);

endmodule

