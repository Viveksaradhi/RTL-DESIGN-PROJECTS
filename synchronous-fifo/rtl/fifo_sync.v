
module fifo_sync (
    input reset,clk,write_enable,read_enable,cs,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output empty,full
    );
   parameter N=8;
   parameter A= $clog2(N);
   
   reg [31:0] fifo [0:N-1];
   reg [A:0] write_pointer=0;
   reg [A:0] read_pointer=0;
   
 //write logic
 always @(posedge clk or posedge reset) begin
 if(reset)
 write_pointer<=0;
 else if(cs && write_enable && !full)
 write_pointer<=write_pointer+1'b1; 
 end
 
 always @(posedge clk ) begin
 if(cs && write_enable && !full)
 fifo[write_pointer[A-1:0]]<=data_in;
 end

 
 
 //read logic
 always @(posedge clk or posedge reset) begin
 if(reset)
 read_pointer<=0;
 else if(cs && read_enable && !empty)
 read_pointer<=read_pointer+1'b1; 
 end
 
 always @(posedge clk or posedge reset) begin
 if(reset)
 data_out<=0;
 else if(cs && read_enable && !empty)
 data_out<=fifo[read_pointer[A-1:0]];
 end
 
 //empty logic
 assign empty=(read_pointer==write_pointer);
 
 //full logic
 assign full=(read_pointer=={~write_pointer[A],write_pointer[A-1:0]});
endmodule
