`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2026 09:39:08 AM
// Design Name: 
// Module Name: echo_contoller
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


module echo_contoller(
   input rx,clk,reset,
   output tx
   );
 wire [7:0] rx_data;
wire rdy;
wire busy;

reg rdy_clr;
reg tx_start;
reg [7:0] tx_data;
   
uart_reciever rx1(
    .clk(clk),
    .rst(reset),
    .rx(rx),
    .rdy_clr(rdy_clr),
    .rdy(rdy),
    .data_out(rx_data)
);

uart tx1(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .data_in(tx_data),
    .tx(tx),
    .busy(busy)
);

always @(posedge clk) begin
    if(reset) begin
        tx_start <= 0;
        rdy_clr  <= 0;
        tx_data <=8'h00;
    end
    else begin
        tx_start <= 0;
        rdy_clr  <= 0;

        if(rdy && !busy) begin
            tx_data  <= rx_data;
            tx_start <= 1'b1;
            rdy_clr  <= 1'b1;
        end
    end
end
endmodule
