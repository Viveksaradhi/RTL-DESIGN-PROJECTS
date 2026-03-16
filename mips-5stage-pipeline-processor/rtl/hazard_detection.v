
module hazard_detection(
    input memread_out,
    input [4:0]rt_out,
    input [4:0] rs,rt,
    output reg pcwrite,if_id_write,flush_IDEX
    );
    always @(*) begin
    if(memread_out && rt_out!=0 && ( rt_out==rs || rt_out==rt)) begin
     pcwrite=0;
     if_id_write=0;
     flush_IDEX=1;
     end 
   else begin 
   pcwrite=1;
   if_id_write=1;
   flush_IDEX=0;
   end
   end
endmodule
