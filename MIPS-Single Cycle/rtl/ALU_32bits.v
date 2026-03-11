module ALU_32bits(
    input signed [31:0] A,
    input signed [31:0] B,
    input [3:0] CS,
    input [4:0] shamt,
    output reg [31:0] result,
    output zero
    );
    assign zero=(result==0);
    always @(*) begin
    case(CS) 
    4'b0000 : begin result=A&B;end
    4'b0001 : begin result=A|B;end
    4'b0010 : begin result=A+B;end
    4'b0110 : begin result=A-B;end
    4'b1000 : begin result=B<<shamt;end
    4'b1001 : begin result=B>>shamt;end
    4'b0111 : begin
               result =(A<B)? 32'd1:32'd0;
               end
    default : result=0;
    endcase
    end
endmodule
