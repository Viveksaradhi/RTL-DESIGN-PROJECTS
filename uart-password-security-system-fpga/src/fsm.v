
module fsm(
   input clk,reset,enter,match,timer_done,attempts_done,update_mode,msg_done,
   output reg increment,start_timer,buzzer,
   output reg [1:0]out,
   output reg start_msg,clear_count
   );
reg [2:0] state,next_state;
//fsm states 
parameter idle=3'b000,
          Input=3'b001,
          verify=3'b010,
          success=3'b011,
          fail=3'b100,
          lock=3'b101,
          update_verify=3'b110,
          update_Password=3'b111;
//sequencal block       
always @(posedge clk or posedge reset) begin
if(reset)
state<=idle;
else
state<=next_state;
end

//cimbinational block for next state
always@(*) begin
next_state=state;
case(state)

idle : begin
next_state=Input;
end

Input :begin
if(update_mode && enter)
next_state=update_verify;
else if(enter)
next_state=verify;
else
next_state=Input;
end

verify : begin
if(match)
next_state=success;
else if(attempts_done)
next_state=lock;
else
next_state=fail;

end

update_verify : begin
if(match)
next_state=update_Password;
else if(attempts_done)
next_state=lock;
else
next_state=fail;
end

update_Password : begin
if(enter)
next_state=Input;
else
next_state=update_Password;
end

success : begin
if(msg_done)
next_state=Input;
else
next_state=success;
end

fail : begin
if(msg_done)
next_state=Input;
else
next_state=fail;
end

lock : begin
if(timer_done)
next_state=Input;
else
next_state=lock;
end


default : next_state=idle;
endcase
end
//combinational block for output
always @(*) begin
start_timer=0;
increment=0;
buzzer=0;
start_msg=0;
clear_count=0;
out=2'b11;
case(state) 


verify : begin
if(!match)
increment=1'b1;
end

update_verify :begin
if(!match)
increment=1'b1;
end


success : begin
out= 2'b00;
start_msg=1'b1;
clear_count=1;
end

fail : begin
out= 2'b01;
start_msg=1'b1;
end

lock : begin
out= 2'b10;
start_msg=1'b1;
buzzer=1'b1;
start_timer=1'b1;
end
default : begin
start_timer=0;
increment=0;   
buzzer=0;
clear_count=0;
start_msg=0;
out=2'b11;
end
endcase
end
endmodule
