module id_ex(
    input clk,reset,
    input flush,
    input [31:0] instruction_in,
    input [31:0] pc4_in,
    input [31:0] readdata1_in,readdata2_in,
    input [4:0] rs_in,rt_in,rd_in,
    input [31:0] ext_imm_in,
    input [5:0] funct_in,
    input regdst_in,alusrc_in,memtoreg_in,regwrite_in,memread_in,memwrite_in,branch_in,
    input [1:0] aluop_in,
    input [4:0] shamt_in,
    output reg [31:0] readdata1_out,readdata2_out,
    output reg [4:0] rs_out,rt_out,rd_out,
    output reg [31:0] ext_imm_out,
    output reg  regdst_out,alusrc_out,memtoreg_out,regwrite_out,memread_out,memwrite_out,branch_out,
    output reg [1:0] aluop_out,
    output reg [5:0]funct_out,
    output reg [31:0] pc4_out,instruction_out,
    output reg [4:0] shamt_out
    );
      always @(posedge clk or posedge reset) begin
    if(reset) begin
    readdata1_out<=0;
    readdata2_out<=0;
    rs_out<=0;
    rt_out<=0;
    rd_out<=0;
    funct_out<=0;
    ext_imm_out<=0;
    regdst_out<=0;
    alusrc_out<=0;
    memtoreg_out<=0;
    regwrite_out<=0;
    memread_out<=0;
    memwrite_out<=0;
    branch_out<=0;
    aluop_out<=0;
    shamt_out<=0;
    pc4_out<=0;
    instruction_out<=0;
    end
    else if(flush) begin
    instruction_out<=0; 
    regdst_out<=0;
    alusrc_out<=0;
    memtoreg_out<=0;
    regwrite_out<=0;
    memread_out<=0;
    memwrite_out<=0;
    branch_out<=0;
    aluop_out<=0;
    end
    else begin
    readdata1_out<=readdata1_in;
    readdata2_out<=readdata2_in;
    rs_out<=rs_in;
    rt_out<=rt_in;
    rd_out<=rd_in;
    funct_out<=funct_in;
    shamt_out<=shamt_in;
    ext_imm_out<=ext_imm_in;
    regdst_out<=regdst_in;
    alusrc_out<=alusrc_in;
    memtoreg_out<=memtoreg_in;
    regwrite_out<=regwrite_in;
    memread_out<=memread_in;
    memwrite_out<=memwrite_in;
    branch_out<=branch_in;
    aluop_out<=aluop_in;
    pc4_out<=pc4_in;
    instruction_out<=instruction_in;
    end
    end
endmodule
