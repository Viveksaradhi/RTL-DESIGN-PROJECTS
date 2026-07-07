`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 05:54:31 AM
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart(
   input clk,reset,tx_start,
   input [7:0] data_in,
   output tx,busy
   );
   wire baud_tick;
   wire serial_out;
   wire load,shift_enable,tx_line;
   wire data_active;
   reg tx_start_d;
   wire tx_pulse,baud_enable;
   
   always @(posedge clk) begin
   tx_start_d<=tx_start;
   end
   
   //baud generator
    baudrate bg(
    .clk(clk),
    .reset(reset),
    .enable(baud_enable),
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
   .tx_start(tx_pulse),
   .load(load),
   .data_active(data_active),
   .shift_enable(shift_enable),
   .tx_line(tx_line),
   .busy(busy),
   .baud_enable(baud_enable)
   );
 assign tx_pulse=(tx_start & ~tx_start_d);
 assign  tx=(data_active)?serial_out :tx_line;
   
endmodule


//9600 baud rate genarator
module baudrate(
  input clk,reset,enable,
  output reg baud_tick
  );
  parameter n=10417;
  reg [$clog2(n)-1:0] counter;
  always @(posedge clk) begin
  if(reset || !enable) begin
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
      output reg load,shift_enable,tx_line,busy,data_active,baud_enable
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
      else
      bitcount<=bitcount;
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
      busy=0;
      next_state = state;
      data_active=0;
      baud_enable=0;
      case(state)
      idle: begin if(tx_start & !busy) begin
            load=1;
            next_state=start;
            end
            else
            next_state=idle;
            end
      start: begin tx_line=0;busy=1;
             baud_enable=1;
             if(baudrate)
             next_state=data;
             else
             next_state=start;
             end
      data: begin  busy=1;data_active=1;
            baud_enable=1;
            if(baudrate) begin
            shift_enable=1;
            if(bitcount==7)
            next_state=stop; 
            else
            next_state=data;
            end
            else
            next_state = state;
            end
            
      stop: begin tx_line=1; busy=1;
                  baud_enable=1;
                  if(baudrate)
                  next_state=idle;
                  else
                  next_state=stop;
            end 
      endcase
      end
     
      endmodule

