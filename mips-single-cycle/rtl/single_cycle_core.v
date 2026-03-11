module single_cycle_core(
    input clk,reset,
    output [31:0]pc_debug,
    output [31:0]instruction_debug
    );
    wire [31:0] pc_out;
    wire [31:0] next_pc;
    wire [31:0] instruction;
    wire [5:0] opcode;
    wire [4:0] rs,rt,rd;
    wire [5:0] funct;
    wire [4:0] shamt;
    wire [15:0] immediate;
    wire [25:0] target;
    wire [31:0] alu_input_b;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [4:0] write_reg;
    wire [31:0] write_data;
    wire [31:0] alu_result; 
    wire zero;
    wire [31:0] ext_imm;
    wire regdst, alusrc, memtoreg, regwrite, memread, memwrite, branch, jump;
    wire [1:0] aluop;
    wire [3:0] alucontrol;
    wire [31:0] memory_data;
    wire branch_taken;
    wire [31:0] branch_address;
    wire [31:0] pc_branch;
    wire [31:0] jump_address;
    wire [31:0] pc_final;
   
   
    pc uut1(
     .clk(clk),
     .reset(reset),
     .current_int(pc_out),
     .next_int(pc_final)
     );
     
     instruction_memory uut2(
      .address(pc_out),
      .instruction(instruction)
     );
     
     
     register_file uut3(
        .clk(clk),
        .regwrite(regwrite),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
        );
        
        
      ALU_32bits uut4(
      .A(read_data1),
      .B(alu_input_b),
      .CS(alucontrol),
      .shamt(shamt),
      .result(alu_result),
      .zero(zero)
      );
      
      
      sign_extend uut5(
      .imm(immediate),
      .ext_imm(ext_imm)
      );
     
    control_unit uut6(
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
    
    
    alu_controller uut7(
     .aluop(aluop),
     .funct(funct),
     .alucontrol(alucontrol)
     );
     
     
    data_memory uut8(
     .clk(clk),
     .memread(memread),
     .memwrite(memwrite),
     .address(alu_result),
     .writedata(read_data2),
     .read_data(memory_data)
     );
     
     //pc adder
    assign next_pc=pc_out+32'd4;    
     
    assign pc_debug=pc_out;
    assign instruction_debug=instruction;
    
    //instruction extraction
    
    assign opcode=instruction[31:26];
    assign rs=instruction[25:21];
    assign rt=instruction[20:16];
    assign rd=instruction[15:11];
    assign shamt=instruction[10:6];
    assign funct=instruction[5:0];
    assign immediate=instruction[15:0];
    assign target=instruction[25:0]; 
    
    //branch    
    assign branch_taken= branch & zero;
    assign branch_address=next_pc+(ext_imm<<2);
    assign pc_branch=(branch_taken)? branch_address : next_pc;
    
    //jump 
    assign jump_address={next_pc[31:28],target,2'b00};
    //pc final
    assign pc_final=(jump)? jump_address : pc_branch;
    //reddst muxs
    assign write_reg=(regdst)? rd:rt;
    //mentoreg muxs
    assign write_data =(memtoreg)? memory_data :alu_result;
    //alusrc mux
    assign alu_input_b=(alusrc)? ext_imm :read_data2;
    
endmodule
