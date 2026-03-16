    
            module pipeline_processor(
               input clk,reset,
               output [31:0] pc_debug,
               output [31:0] alu_result_debug,
               output [31:0] memory_data_debug,
               output [1:0] forwardingA_debug,forwardingB_debug,
               output pcwrite_debug,if_id_write_debug,flush_idex_debug,
               output [31:0] instruction_ID,instruction_EX,instruction_MEM,instruction_WB,instruction_IF
               );
            wire [31:0] pc_out;
            wire [31:0] next_pc;
            wire [31:0] pc4_out;
            wire [31:0] instruction;
            wire [31:0] instruction_out;
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
            wire [31:0] readdata1_out;
            wire [31:0] readdata2_out;
            wire regdst_out,alusrc_out,memtoreg_out,regwrite_out,memread_out,memwrite_out,branch_out;
            wire memread_out1,memwrite_out1,regwrite_out1,memtoreg_out1;
            wire [1:0] aluop_out;
            wire  [4:0] rs_out,rt_out,rd_out;
            wire [31:0] ext_imm_out;
            wire [5:0] funct_out;
            wire [4:0] shamt_out;
            wire [31:0] alu_result_out;
            wire [31:0] write_data_out;
            wire [31:0] destination_reg_out,destination_reg_out1;
            wire regwrite_out2,memtoreg_out2;
            wire [31:0] memory_data_out,alu_result_out1;
            wire [31:0] pc4_out1;
            wire flush_ifid;
            wire flush_idex;
            wire [1:0]forwardingA,forwardingB;
            wire [31:0] alu_input_A,alu_input_B;
            wire if_id_write,flush_IDEX,pcwrite;
             pc uut1(
             .clk(clk),
             .reset(reset),
             .pcwrite(pcwrite),
             .current_int(pc_out),
             .next_int(pc_final)
             );
             
             instruction_memory uut2(
              .address(pc_out),
              .instruction(instruction)
             );
             
             if_id uut3(
             .clk(clk),
             .reset(reset),
             .flush(flush_ifid),
             .write_enable(if_id_write),
             .instruction_in(instruction),
             .pc4_in(next_pc),
             .instruction_out(instruction_out),
             .pc4_out(pc4_out)
             );
             
             register_file uut4(
                .clk(clk),
                .regwrite(regwrite_out2),
                .read_reg1(rs),
                .read_reg2(rt),
                .write_reg(write_reg),
                .write_data(write_data),
                .read_data1(read_data1),
                .read_data2(read_data2)
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
        
          
        id_ex uut7(
          .clk(clk),
          .reset(reset),
          .instruction_in(instruction_out),
          .flush(flush_idex),
          .readdata1_in(readdata1),
          .readdata2_in(readdata2),
          .rs_in(rs),   
          .rt_in(rt),
          .rd_in(rd),
          .funct_in(funct),
          .shamt_in(shamt),
          .ext_imm_in(ext_imm),
          .regdst_in(regdst),
          .alusrc_in(alusrc),
          .memtoreg_in(memtoreg),
          .memwrite_in(memwrite),
          .regwrite_in(regwrite),
          .memread_in(memread),
          .branch_in(branch),
          .aluop_in(aluop),
          .pc4_in(pc4_out),
          .readdata1_out(readdata1_out),
          .readdata2_out(readdata2_out),
          .rs_out(rs_out),
          .rt_out(rt_out),
          .rd_out(rd_out),
          .ext_imm_out(ext_imm_out),
          .regdst_out(regdst_out),
          .alusrc_out(alusrc_out),
          .memtoreg_out(memtoreg_out),
          .memwrite_out(memwrite_out),
          .regwrite_out(regwrite_out),
          .memread_out(memread_out),
          .branch_out(branch_out),
          .aluop_out(aluop_out),
          .funct_out(funct_out),
          .shamt_out(shamt_out),
          .pc4_out(pc4_out1),
          .instruction_out(instruction_EX)
          );
           alu_controller uut8(
           .aluop(aluop_out),
           .funct(funct_out),
           .alucontrol(alucontrol)
           );
          
          ALU_32bits uut9(
          .A(alu_input_A),
          .B(alu_input_b),
          .CS(alucontrol),
          .shamt(shamt_out),
          .result(alu_result),
          .zero(zero)
           );
           
          ex_mem uut10(
          .clk(clk),
          .reset(reset),
          .instruction_in(instruction_EX),
          .alu_result_in(alu_result),      
          .write_data_in(readdata2_out),
          .destination_reg_in(write_reg),
          .memread_in(memread_out),
          .memwrite_in(memwrite_out),
          .regwrite_in(regwrite_out),
          .memtoreg_in(memtoreg_out),
          .alu_result_out(alu_result_out),
          .write_data_out(write_data_out),
          .destination_reg_out(destination_reg_out),
          .memread_out(memread_out1),
          .memwrite_out(memwrite_out1),
          .regwrite_out(regwrite_out1),
          .memtoreg_out(memtoreg_out1),
          .instruction_out(instruction_MEM)
          
        );
         data_memory uut11(
         .clk(clk),
         .memread(memread_out1),
         .memwrite(memwrite_out1),
         .address(alu_result_out),
         .writedata(write_data_out),
         .read_data(memory_data)
         );
         mem_wb uut12(
         .clk(clk),
         .reset(reset),
         .instruction_in(instruction_MEM),
         .memory_data_in(memory_data),
         .alu_result_in(alu_result_out),
         .destination_reg_in(destination_reg_out),
         .regwrite_in(regwrite_out1),
         .memtoreg_in(memtoreg_out1),
         .memory_data_out(memory_data_out),
         .alu_result_out(alu_result_out1),
         .destination_reg_out(destination_reg_out1),
         .regwrite_out(regwrite_out2),
         .memtoreg_out(memtoreg_out2),
         .instruction_out(instruction_WB)
         );
         hazard_detection uut13(
         .memread_out(memread_out),
         .rt_out(rt_out),
         .rs(rs),
         .rt(rt),
         .pcwrite(pcwrite),
         .if_id_write(if_id_write),
         .flush_IDEX(flush_IDEX)
         );
         
         forwarding_unit uut14(
         .rs_out(rs_out),
         .rt_out(rt_out),
         .destination_reg_out(destination_reg_out),
         .regwrite_out1(regwrite_out1),
         .destination_reg_out1(destination_reg_out1),
         .regwrite_out2(regwrite_out2),
         .forwardingA(forwardingA),
         .forwardingB(forwardingB)
         );

          //pc adder
        assign next_pc=pc_out+32'd4;    
        
        
        //outputs
        assign pc_debug=pc_out;
        assign instruction_IF=instruction;
        assign alu_result_debug = alu_result_out1;
        assign memory_data_debug = memory_data_out;
        assign forwardingA_debug=forwardingA;
        assign forwardingB_debug=forwardingB;
        assign pcwrite_debug=pcwrite;
        assign flush_idex_debug=flush_idex;
        assign if_id_write_debug = if_id_write;
        assign instruction_ID = instruction_out;
       
        //instruction extraction
        
        assign opcode=instruction_out[31:26];
        assign rs=instruction_out[25:21];
        assign rt=instruction_out[20:16];
        assign rd=instruction_out[15:11];
        assign shamt=instruction_out[10:6];
        assign funct=instruction_out[5:0];
        assign immediate=instruction_out[15:0];
        assign target=instruction_out[25:0]; 
        
        
        
        //branch    
        assign branch_taken= branch_out& zero;
        //flush(control hazard)
        assign flush_ifid=branch_taken;
        assign flush_idex=branch_taken | flush_IDEX;
        
        assign branch_address=pc4_out1+(ext_imm_out<<2);
        assign pc_branch=(branch_taken)? branch_address : next_pc;
       
        //jump 
        assign jump_address={pc4_out[31:28],target,2'b00};
        //pc final
        assign pc_final=(jump)? jump_address : pc_branch;
        //reddst muxs
        assign write_reg=(regdst_out)? rd_out:rt_out;
        //mentoreg muxs
        assign write_data =(memtoreg_out2)? memory_data_out :alu_result_out1;
        //alusrc mux
        assign alu_input_b=(alusrc_out)? ext_imm_out :alu_input_B;
        
        //forwarding muxes
        assign alu_input_A=(forwardingA==2'b00)? readdata1_out :
                           (forwardingA==2'b10)? alu_result_out:
                           (forwardingA==2'b01)? write_data :
                                              readdata1_out;
                                         
       assign alu_input_B=(forwardingB==2'b00)? readdata2_out :
                          (forwardingB==2'b10)? alu_result_out:
                          (forwardingB==2'b01)? write_data :
                                             readdata2_out;               
       
     
      
        endmodule
