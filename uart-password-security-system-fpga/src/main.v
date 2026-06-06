//inputs and outputs

module main(
   input clk,reset,rx,
   output tx,buzzer
    );
 //reg 
reg [15:0]stored_password=16'h2222;
reg msg_start_d;
reg update_mode_uart,wait_new_password;

wire match,start_timer,timer_done,attempts_done,increment;
wire [1:0]out;
wire tx_start,start_msg,msg_start_pulse,msg_done,busy;
wire [7:0] msg;
wire rdy_clr,rdy;
wire [7:0] data_out;
wire [15:0] password;
wire password_valid;
wire update_request;
wire clear_count;

// moudule instences
comparator  uut1(
.entered_password(password),
.stored_password(stored_password),
.match(match) );

fsm uut2(
.clk(clk),
.reset(reset),
.enter(password_valid),
.match(match),
.timer_done(timer_done),
.attempts_done(attempts_done),
.update_mode(update_mode_uart),
.msg_done(msg_done),
.increment(increment),
.start_timer(start_timer),
.buzzer(buzzer),
.out(out),
.start_msg(start_msg),
.clear_count(clear_count)
);

counter uut3(
.clk(clk),
.reset(reset),
.clear_count(clear_count),
.increment(increment),
.attempts_done(attempts_done));

timers uut4(
.clk(clk),
.reset(reset),
.start_timer(start_timer),
.timer_done(timer_done)
);
message_contoller uut5(
.clk(clk),
.reset(reset),
.start_msg(msg_start_pulse),
.busy(busy),
.select_msg(out),
.msg_done(msg_done),
.tx_start(tx_start),
.msg(msg)
);

uart uut6(
.clk(clk),
.reset(reset),
.tx_start(tx_start),
.data_in(msg),
.tx(tx),
.busy(busy)
);

uart_reciever uut7(
.clk(clk),
.rst(reset),
.rx(rx),
.rdy_clr(rdy_clr),
.rdy(rdy),
.data_out(data_out)
);
 rx_controller uut8(
 .clk(clk),
 .reset(reset),
 .rdy(rdy),
 .buzzer(buzzer),
 .data_out(data_out),
 .password(password),
 .update_enable(update_request),
 .password_valid(password_valid)
 );

// ready clear for uart reciver
assign rdy_clr = rdy;

// start msg pulse
always@(posedge clk) begin
msg_start_d<=start_msg;
end

assign msg_start_pulse=start_msg & ~msg_start_d;


//update password 
always @(posedge clk or posedge reset) begin
if(reset) begin
  update_mode_uart <= 1'b0;
  wait_new_password <= 1'b0;
end
else begin
if(update_request)
  update_mode_uart <= 1'b1;
// Verify old password
if(update_mode_uart && !wait_new_password && password_valid) begin

if(match)
  wait_new_password <= 1'b1;
else begin
  update_mode_uart <= 1'b0;
  wait_new_password <= 1'b0;
end
end
// Receive new password
if(wait_new_password && password_valid) begin
  stored_password <= password;
  update_mode_uart <= 1'b0;
  wait_new_password <= 1'b0;
end
end
end


endmodule

