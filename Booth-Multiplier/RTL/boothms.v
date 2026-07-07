`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2026 09:24:07 AM
// Design Name: 
// Module Name: boothms
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


module boothms(
    input clk,reset,
    input signed [3:0]M,Q,
    output reg [7:0]y
    );
    reg signed [4:0]A;
    reg signed [4:0] m;
    reg signed [3:0] q;
    reg signed [9:0] temp;
    reg [2:0]n;
    reg q0;
    reg [2:0] state,next_state;
    parameter s0=3'b000,
              s1=3'b001,
              s2=3'b010,
              s3=3'b011,
              s4=3'b100,
              s5=3'b101,
              s6=3'b110;
    always@( posedge clk or posedge reset) begin
   //state upadation 
    if(reset)
    state<=s0;
    else
    state<=next_state;
    
    end
    //combinational block 
    always @(*) begin
        next_state = state; 
        case(state)
            s0: next_state = s1;
            s1: begin 
                if ({q[0], q0} == 2'b01)       
                next_state = s3; 
                else if ({q[0], q0} == 2'b10)  
                next_state = s4;
                else                           
                next_state = s2;
            end
            
            s2: next_state = s5;
            s3: next_state = s2; 
            s4: next_state = s2;
                        
            s5: begin 
                if (n == 1) next_state = s6;
                else        next_state = s1; 
            end
            
            s6: next_state = s0;
            
            default: next_state = s0;
        endcase
    end
    //math logic    
    always@(posedge clk or posedge reset) begin
    if (reset) begin
    A  <= 0;
    m  <= 0;
    q  <= 0;
    q0 <= 0;
    n  <= 0;
    y  <= 0;
    end
    else begin
    case(state)
    s0 : begin
    m<={M[3],M};
    q<=Q;
    A<=5'b00000;
    n<=4;
    q0<=1'b0;
    end
    s2: begin
    A<={A[4],A[4:1]};
    q<={A[0],q[3:1]};
    q0<=q[0];
    end
    s3 : begin
    A <= $signed(A) + $signed(m);
    end
    s4 : begin
    A <= $signed(A) - $signed(m);
    end
    s5: begin
    n<=n-1;
    end
    s6: begin
    y<={A[3:0],q};
    end
    default : begin  y<=0; end
    endcase
    end
    end
endmodule
