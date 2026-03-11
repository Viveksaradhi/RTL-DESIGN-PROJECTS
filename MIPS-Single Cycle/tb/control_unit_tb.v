`timescale 1ns / 1ps


module control_unit_tb;
    reg [5:0] opcode;
    wire regdst;
    wire alusrc;
    wire memtoreg;
    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire jump;
    wire [1:0]aluop;
    
control_unit uut(
    .opcode(opcode),
    .regdst(regdst),
    .alusrc(alusrc),
    .memtoreg(memtoreg),
    .regwrite(regwrite),
    .memread(memread),
    .memwrite(memwrite),
    .branch(branch),
    .jump(jump),
    .aluop(aluop)
    );
    initial begin 
    opcode=6'b000000;
    #10;
    opcode=6'b100011;
    #10;
    opcode=6'b101011;
    #10;
    opcode=6'b000100;
    #10;
    opcode=6'b001000;
    #10;
    opcode=6'b000010;
    #10;
    $finish;
    end
endmodule
