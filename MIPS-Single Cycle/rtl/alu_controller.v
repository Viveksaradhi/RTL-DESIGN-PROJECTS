module alu_controller(
    input [1:0] aluop,
    input [5:0] funct,
    output reg [3:0] alucontrol
    );
   always @(*) begin
   alucontrol=4'b0010;
   case(aluop) 
   2'b00 : alucontrol=4'b0010;
   2'b01 : alucontrol=4'b0110;
   2'b10 : begin
   case(funct) 
   6'b100000: alucontrol=4'b0010;
   6'b100010: alucontrol=4'b0110;
   6'b100100: alucontrol=4'b0000;
   6'b100101: alucontrol=4'b0001;
   6'b101010: alucontrol=4'b0111;
   6'b000000: alucontrol=4'b1000;
   6'b000010: alucontrol=4'b1001;
   default: alucontrol=4'b0010;
   endcase
   end
   default: alucontrol=4'b0010;
   endcase
   end
endmodule
