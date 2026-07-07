`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2026 12:22:47 PM
// Design Name: 
// Module Name: ping_pong_controller
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

module ping_pong_controller(
    //system clock and active low asychronous reset
    input clk,rst_n,
    //producer interface
    input prod_valid ,//high when producer has vaild data to write
    input [7:0] prod_data,//8-bit incoming data
    output reg prod_ready, //high if controller can accept data
    //consumer interface
    input cons_ready, //high when consumer wants to read  a byte
    output reg [7:0] cons_data,//8-bit outgoing data
    output reg cons_valid,//high if data on cons_data is vaild
    //status and error flags
    output reg active_buffer,//0=writing to ping (buffer 0) ,1=writing to pong (buffer 1)
    output reg err_overrun ,//system error:producer overrun unread buffer
    output reg err_underrun //systern error:consumer read an unready buffer
    );
    // two buffer registers
    reg[7:0] buffer_0 [0:3];
    reg[7:0] buffer_1 [0:3];
    //read  and  write pointers
    reg [1:0] wr_ptr,rd_ptr;
    //empty and full flags for two buffers
    reg buf0_full,buf1_full;
    reg buf0_empty,buf1_empty;
    //read buffer for consumer read operation
    reg read_buffer;
    
    always @(posedge clk or negedge rst_n) begin
    //reset logic
    if(!rst_n) begin
     wr_ptr<=0;
     rd_ptr<=0;
     buf0_empty<=1;
     buf1_empty<=1;
     buf0_full<=0;
     buf1_full<=0;
     prod_ready<=1;
     cons_valid<=0;
     active_buffer<=0;
     read_buffer<=1;
     err_overrun<=0;
     err_underrun<=0; 
    end //reset end
    else begin
    // overrun recovery
    if(err_overrun) begin
      if(buf0_empty || buf1_empty) begin
      err_overrun<=0;
      prod_ready<=1;
      end//if(buf0_empty || buf1_empty) end
      end// if(err_overrun) end
    
    
        //producer write logic
    if(prod_valid && prod_ready && !err_overrun) begin
    //write data into active buffer
    if(!active_buffer) 
    buffer_0[wr_ptr]<=prod_data;
    else
    buffer_1[wr_ptr]<=prod_data;
    
    //write pointer updater and status 
    if(wr_ptr==3) begin
       //for buffer 0
       if(!active_buffer) begin
         buf0_full<=1;
         buf0_empty<=0;
         //overun case
         if(!buf1_empty) begin
         err_overrun<=1;
         prod_ready<=0;
         end//if(!buf1_empty) end
         else begin
         active_buffer<=1;
         wr_ptr<=0;
         end//else end
         //iniciating read buffer after coming from two empty buffers
         if(!buf0_full && !buf1_full)
         read_buffer <= 0;
         end//if(!active_buffer) end
       //for buffer 1
       else begin
       buf1_full<=1;
       buf1_empty<=0;
       //overrun case
       if(!buf0_empty) begin
         err_overrun<=1;
         prod_ready<=0;
         end//  if(!buf0_empty)  end
         else begin
         active_buffer<=0;
         wr_ptr<=0;
         end//else end
         //iniciating read buffer after coming from two empty buffers
         if(!buf0_full && !buf1_full)
         read_buffer <= 1;
         end //else end
         end// if(wr_ptr==3) end
       else 
       wr_ptr<=wr_ptr+1;
    end// else end
 end//if(prod_valid && prod_ready && !err_overrun)
   // underrun recovery
    if(err_underrun) begin
      if(buf0_full || buf1_full)
      err_underrun<=0;
      end //if(err_underrun) end
  //consumer read logic 
  if(cons_ready && !err_underrun) begin
  //for buffer 1
  if(read_buffer==1) begin
  
   if(buf1_full) begin
   cons_data<=buffer_1[rd_ptr];
   cons_valid<=1;
   
    if(rd_ptr==3) begin
      rd_ptr<=0;
      buf1_empty<=1;
      buf1_full<=0;
      
       if(buf0_full)
       read_buffer <= 0;
       //invalid data case
       else 
       cons_valid <= 0;
    end//if(rd_ptr==3) end
    else 
    rd_ptr<=rd_ptr+1;    
   end //if(buf1_full) end
   //underrun case
   else begin
   err_underrun <= 1;
   cons_valid <= 0;
    end//else end
 end//if(read_buffer==1) end
  //for buffer 0
  else begin
 
  if(buf0_full) begin
  cons_data<=buffer_0[rd_ptr];
  cons_valid<=1;
    if(rd_ptr==3) begin
      rd_ptr<=0;
      buf0_empty<=1;
      buf0_full<=0;
       if(buf1_full) 
        read_buffer<= 1;
        //invalid data case
       else 
       cons_valid <= 0;
     end //if(rd_ptr==3) end
     else
     rd_ptr<=rd_ptr+1;
     end //if(buf0_full) end
    //underrun case 
   else begin
   err_underrun <= 1;
   cons_valid <= 0;
    end //else end
    end //else
   end//reset else end
end //always end
endmodule
