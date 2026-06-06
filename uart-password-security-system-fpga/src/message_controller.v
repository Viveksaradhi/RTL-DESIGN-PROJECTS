   
    module message_contoller(
        input clk,reset,start_msg,busy,
        input [2:0] select_msg,
        output reg msg_done,tx_start,
        output reg [7:0] msg  
        );
        parameter idle =3'b000,
                  send =3'b001,
                  busy_high =3'b010,
                  busy_low  =3'b011,
                  done =3'b100;
        reg [2:0] state,next_state; 
        reg [3:0] index=0;
        reg [5:0] max_length;
        //load message
        always @(*) begin
        case(select_msg)
    
        3'b000: max_length=10;
        
        3'b001: max_length=7;
        
        3'b010: max_length=7;
        
        3'b011: max_length=19;
        
        3'b100: max_length=21;
        
        3'b101: max_length=17;
        
        3'b110: max_length=17;
        
        3'b111: max_length=21;
        
        default :max_length = 0;
    
        endcase
        end
    
        //sequencal block
        always @(posedge clk or posedge reset) begin
          if(reset) 
          state<=idle;
          else begin
          state<=next_state;
          end 
          end     
          
        always @(*) begin
        next_state=state;
        case(state) 
        
        idle :begin
        if(start_msg)
        next_state=send; 
        else
        next_state=idle;
        end
        
        send : begin
        next_state=busy_high;
        end
        
        busy_high : begin
        if(!busy)
        next_state=busy_high;
        else
        next_state=busy_low;
        end
        
        busy_low : begin
        if(busy)
        next_state=busy_low;
        else if(index==max_length)
        next_state=done;
        else
        next_state=send;
        end
        
        done : begin
        next_state=idle;
        end
        
        default :next_state=idle;
        endcase
        end
        
        always @(posedge clk or posedge reset) begin
        if(reset)  begin
        msg_done<=1'b0;
        tx_start<=1'b0;
        index<=0;
        msg<=8'h00;
        end
        
        else begin
        msg_done<=1'b0;
        tx_start<=1'b0;
        
        case(state) 
    
       send : begin
    
            case(select_msg)
    
            3'b000: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "S";
                    3: msg <= "U";
                    4: msg <= "C";
                    5: msg <= "C";
                    6: msg <= "E";
                    7: msg <= "S";
                    8: msg <= "S";
                    9: msg <= 8'h0D;
                    10: msg <= 8'h0A;
                endcase
            end
    
            3'b001: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "F";
                    3: msg <= "A";
                    4: msg <= "I";
                    5: msg <= "L";
                    6: msg <= 8'h0D;
                    7: msg <= 8'h0A;
                endcase
            end
    
            3'b010: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "L";
                    3: msg <= "O";
                    4: msg <= "C";
                    5: msg <= "K";
                    6: msg <= 8'h0D;
                    7: msg <= 8'h0A;
                endcase
            end
            
              3'b011: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "p";
                    3: msg <= "a";
                    4: msg <= "s";
                    5: msg <= "s";
                    6: msg <= "w";
                    7: msg <= "o"; 
                    8: msg <= "r";
                    9: msg <= "d";
                    10: msg <= " ";
                    11: msg <= "u";
                    12: msg <= "p";
                    13: msg <= "d"; 
                    14: msg <= "a";
                    15: msg <= "t";
                    16: msg <= "e"; 
                    17: msg <= "d";
                    18: msg <= 8'h0D;
                    19: msg <= 8'h0A;
                endcase
            end
    
            3'b100: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "e";
                    3: msg <= "n";
                    4: msg <= "t";
                    5: msg <= "e";
                    6: msg <= "r";
                    7: msg <= " "; 
                    8: msg <= "o";
                    9: msg <= "l";
                    10: msg <= "d";
                    11: msg <= " ";
                    12: msg <= "p";
                    13: msg <= "a"; 
                    14: msg <= "s";
                    15: msg <= "s";
                    16: msg <= "w"; 
                    17: msg <= "o";
                    18: msg <= "r";
                    19: msg <= "d";
                    20: msg <= 8'h0D;
                    21: msg <= 8'h0A;
                endcase
            end
             3'b101: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "w";
                    3: msg <= "r";
                    4: msg <= "o";
                    5: msg <= "n";
                    6: msg <= "g";
                    7: msg <= " ";
                    8: msg <= "p";
                    9: msg <= "a"; 
                    10: msg <= "s";
                    11: msg <= "s";
                    12: msg <= "w"; 
                    13: msg <= "o";
                    14: msg <= "r";
                    15: msg <= "d";
                    16: msg <= 8'h0D;
                    17: msg <= 8'h0A;
                endcase
            end
              3'b110: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "e";
                    3: msg <= "n";
                    4: msg <= "t";
                    5: msg <= "e";
                    6: msg <= "r";
                    7: msg <= " "; 
                    8: msg <= "p";
                    9: msg <= "a"; 
                    10: msg <= "s";
                    11: msg <= "s";
                    12: msg <= "w"; 
                    13: msg <= "o";
                    14: msg <= "r";
                    15: msg <= "d";
                    16: msg <= 8'h0D;
                    17: msg <= 8'h0A;
                endcase
            end
            
            3'b111: begin
                case(index)
                    0: msg <= 8'h0D;
                    1: msg <= 8'h0A;
                    2: msg <= "e";
                    3: msg <= "n";
                    4: msg <= "t";
                    5: msg <= "e";
                    6: msg <= "r";
                    7: msg <= " "; 
                    8: msg <= "n";
                    9: msg <= "e";
                    10: msg <= "w";
                    11: msg <= " ";
                    12: msg <= "p";
                    13: msg <= "a"; 
                    14: msg <= "s";
                    15: msg <= "s";
                    16: msg <= "w"; 
                    17: msg <= "o";
                    18: msg <= "r";
                    19: msg <= "d";
                    20: msg <= 8'h0D;
                    21: msg <= 8'h0A;
                endcase
            end
    
    
    
            endcase
    
            tx_start <= 1'b1;
        end
    
        busy_low : begin
        if(!busy && index!=max_length)
        index<=index+1;
        end
        
        done : begin
        msg_done<=1'b1;
        index<=0;
        end
        
        endcase
        end
        end
    endmodule

