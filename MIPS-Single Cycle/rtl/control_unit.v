module control_unit(
    input [5:0] opcode,
    output reg regdst,
    output reg alusrc,
    output reg memtoreg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg jump,
    output reg [1:0]aluop
    );
    always @(*) begin
    regdst=0;
    alusrc=0;
    memtoreg=0;
    regwrite=0;
    memread=0;
    memwrite=0;
    branch=0;
    jump=0;
    aluop=2'b00;
    case(opcode)
    //R-type
    6'b000000 : begin
    regdst=1;
    regwrite=1;
    aluop=2'b10;
    end
    //LW
    6'b100011 : begin
    alusrc=1;
    memtoreg=1;
    regwrite=1;
    memread=1;
    end  
    //SW  
    6'b101011 : begin
    alusrc=1;
    memwrite=1;
    end
    //BEQ
    6'b000100 : begin
    branch=1;
    aluop=2'b01;
    end
    //addi
    6'b001000 : begin
    alusrc=1;
    regwrite=1;
    end
    //j
    6'b000010 : begin
    jump=1;
    end
    default: begin
    end
    endcase
    end
endmodule
