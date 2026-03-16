module forwarding_unit(
    input [4:0] rs_out,rt_out,
    input [4:0]destination_reg_out,
    input regwrite_out1,
    input [4:0]destination_reg_out1,
    input regwrite_out2,
    output reg [1:0] forwardingA,forwardingB
    );
    /* 00 - register file
       10 - ex_mem alu result
       01 - mem_wb alu result
       */
    
   always@(*) begin
   //forwarding A
   if(regwrite_out1 && destination_reg_out!=0 && destination_reg_out==rs_out)
   forwardingA=2'b10;
   else if (regwrite_out2 && destination_reg_out1!=0 && destination_reg_out1==rs_out)
   forwardingA=2'b01;
   else 
   forwardingA=2'b00;
   
   //forwarding B
   if(regwrite_out1 && destination_reg_out!=0 && destination_reg_out==rt_out)
   forwardingB=2'b10;
   else if (regwrite_out2 && destination_reg_out1!=0 && destination_reg_out1==rt_out)
   forwardingB=2'b01;
   else 
   forwardingB=2'b00;
   end
  
endmodule
