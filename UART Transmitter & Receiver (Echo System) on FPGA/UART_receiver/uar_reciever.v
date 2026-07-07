`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2026 07:12:27 AM
// Design Name: 
// Module Name: uar_reciever
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


module uart_reciever(input clk,rst,rx,rdy_clr,output reg  rdy,output reg [7:0] data_out);

//fsm states
parameter RX_STATE_START	= 2'b00,
          RX_STATE_data_out = 2'b01,
          RX_STATE_STOP		= 2'b10;

reg [1:0] state;
reg [3:0] sample;
reg [3:0] index;
reg [7:0] temp;
wire clk_en;

baudrate_rx uut1(.clk(clk),.reset(rst),.clk_en(clk_en));  
  
always @(posedge clk) begin
      if(rst) begin
        rdy <= 0;
        data_out <= 0; 
        state<=RX_STATE_START;
        sample<=0;
        index<=0;
        temp<=0;
    end
    
    else begin
	if (rdy_clr) 
		    rdy <= 0;
	if (clk_en) begin
		case (state)
		RX_STATE_START: begin
			if (!rx || sample != 0)
				sample <= sample + 1'b1;

			if (sample == 7) begin
				state <= RX_STATE_data_out;
				index <= 0;
				sample <= 0;
				temp <= 0;  
			end
		end
	
		RX_STATE_data_out: begin
			sample <= sample + 1'b1;
			if (sample == 8) 
				temp[index] <= rx;
		    if(sample ==15) begin
		        sample<=0;
		       if(index ==7)
				state <= RX_STATE_STOP;
			else
				index <= index + 1;
			end
			
		end
		RX_STATE_STOP: begin
			if (sample == 15 ) begin
				state <= RX_STATE_START;
				data_out <= temp;
				rdy <= 1'b1;
				sample <= 0;
			end else begin
				sample <= sample + 1'b1;
			end
		end
		default: begin
			state <= RX_STATE_START;
		end
		endcase
	end
end
end

endmodule

//baudrate generator
module baudrate_rx(
  input clk,reset,
  output reg clk_en
  );
  parameter n=651;
  reg [$clog2(n)-1:0] counter;
  always @(posedge clk) begin
  if(reset) begin
  counter<={$clog2(n){1'b0}};
  clk_en<=0;
  end
  else if(counter==n-1) begin
  counter<=0;
  clk_en<=1; 
  end
  else begin
  counter<=counter+1;
  clk_en<=0;
  end
  end
  endmodule