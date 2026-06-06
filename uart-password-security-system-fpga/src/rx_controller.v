module rx_controller(
   input clk,reset,rdy,buzzer,
   input [7:0] data_out,
   output reg [15:0] password,
   output reg password_valid,update_enable
   );
   reg [1:0] count;
   always @(posedge clk or posedge reset) begin
   if(reset) begin
   password<=0;
   password_valid<=0;
   count<=0;
   end
   
   else begin
   update_enable<=0;
   password_valid<=0;
      
      if(rdy) begin
      if(data_out=="u" || data_out=="U") begin
      update_enable<=1;
      count<=0;
      end
      else if(data_out>="0" && data_out<="9" && !buzzer)  begin
      
      case(count)
      0: password[15:12] <= data_out[3:0];
      1: password[11:8]  <= data_out[3:0];
      2: password[7:4]   <= data_out[3:0];
      3: password[3:0]   <= data_out[3:0];
      endcase

      if(count==3) begin
      password_valid<=1'b1;
      count<=0;
      end
      else
      count<=count+1;
      end
      end
      
   end
end
endmodule

