// ------------------------------------------------------------
// Module: uart
// Description: UART transmitter supporting 8-bit data,
//              start and stop bits with configurable baud rate
// Author: Vivek Saradhi
// ------------------------------------------------------------

module uart(
   input clk,reset,tx_start,
   input [7:0] data_in,
   output tx
   );
   wire baud_tick;
   wire serial_out;
   wire load,shift_enable,tx_line;
   //baud generator
    baudrate bg(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick)
    );
    
   //shift register
   shift_register sr(
   .clk(clk),
   .reset(reset),
   .data_in(data_in),
   .load(load),
   .shift_enable(shift_enable),
   .serial_out(serial_out)
   );
   
   //fsm
   fsm_controller fc(
   .clk(clk),
   .reset(reset),
   .baudrate(baud_tick),
   .tx_start(tx_start),
   .load(load),
   .shift_enable(shift_enable),
   .tx_line(tx_line)
   );
   
 assign  tx=(shift_enable)?serial_out :tx_line;
   
endmodule


//19200 baud rate genarator
module baudrate(
  input clk,reset,
  output reg baud_tick
  );
  parameter n=2604;
  reg [$clog2(n)-1:0] counter;
  always @(posedge clk) begin
  if(reset) begin
  counter<={$clog2(n){1'b0}};
  baud_tick<=0;
  end
  else if(counter==n-1) begin
  counter<=0;
  baud_tick<=1; 
  end
  else begin
  counter<=counter+1;
  baud_tick<=0;
  end
  end
  endmodule
  
//shift register
module shift_register #(parameter m=8)
 (
 input clk,reset,load,shift_enable,
 input [m-1:0] data_in,
 output  serial_out
 );
 reg [m-1:0] piso;
 always @(posedge clk) begin    
 if(reset)
 piso<={m{1'b1}};
 else if(load)
 piso<=data_in;
 else if(shift_enable)
 piso<={1'b1,piso[m-1:1]}; 
 end 
 assign serial_out=piso[0];
 endmodule
 
 
 
     //fsm controller
     module fsm_controller(
      input clk,reset,
      input baudrate,tx_start,
      output reg load,shift_enable,tx_line
      );
     //fsm states
      parameter idle=2'b00,
                start=2'b01,
                data=2'b10,
                stop=2'b11;
      reg [1:0]next_state,state;
      reg [2:0]bitcount;
      
      
      //bitcounter
      always @(posedge clk) begin
      if(reset)
      bitcount<=0;  
      else if(state==start)
      bitcount<=0;
      else if(state==data && baudrate)
      bitcount<=bitcount+1;
      end
      
     
      //fsm 
      always @(posedge clk) begin
      if(reset) begin
      state<=idle;    
      end
      else 
        state<=next_state;
      end
      
      always @(*) begin
      load = 0;
      shift_enable = 0;
      tx_line = 1;
      next_state = state;
      case(state)
      idle: begin if(tx_start) begin
            load=1;
            next_state=start;
            end
            else
            next_state=idle;
            end
      start: begin tx_line=0;
             if(baudrate)
             next_state=data;
             else
             next_state=start;
             end
      data: begin 
            if(baudrate ) begin
            shift_enable=1;
            if(bitcount==7)
            next_state=stop; 
            else
            next_state=data;
            end
            else
            next_state = state;
            end
      stop: begin tx_line=1;
                  if(baudrate)
                  next_state=idle;
                  else
                  next_state=stop;
            end 
      endcase
      end
      endmodule
