

`include "../QPU/QPU_defines.v"
`include "tb_define.v"

`timescale 10ns/10ps

module tb_exu_decode();

      //////////////////////////////////////////////////////////////
  // The IR stage to Decoder
  reg  [`QPU_INSTR_SIZE-1:0] i_instr;
  reg  [`QPU_PC_SIZE-1:0] i_pc;
  reg  i_prdt_taken; 
  
  //////////////////////////////////////////////////////////////
  // The Decoded Info-Bus

  wire dec_rs1x0;
  wire dec_rs2x0;
  wire dec_rs1en;
  wire dec_rs2en;
  wire dec_rdwen;
  wire [`QPU_RFIDX_REAL_WIDTH-1:0] dec_rs1idx;
  wire [`QPU_RFIDX_REAL_WIDTH-1:0] dec_rs2idx;
  wire [`QPU_RFIDX_REAL_WIDTH-1:0] dec_rdidx;
  wire [`QPU_DECINFO_WIDTH-1:0] dec_info;
  wire [`QPU_XLEN-1:0] dec_imm;
  wire [`QPU_PC_SIZE-1:0] dec_pc;  
  
  //Quantum instruction decode
  wire dec_new_timepoint;
  wire dec_need_qubitflag;
  wire dec_measure;
  wire dec_fmr;
  //Branch instruction decode
  wire dec_bxx;
  wire [`QPU_XLEN-1:0] dec_bjp_imm;

  
  initial
  begin
    #0 i_instr = `instr_LOAD;
    #0 i_pc = `QPU_PC_SIZE'b0;
    #0 i_prdt_taken = 1'b0;
    #2 i_instr = `instr_STORE;

    #5 i_instr = `instr_BEQ;
    #2 i_instr = `instr_BNE;
    #2 i_instr = `instr_BLT;
    #2 i_instr = `instr_BGT;

    #5 i_instr = `instr_ADDI;
    #2 i_instr = `instr_XORI;
    #2 i_instr = `instr_ORI;
    #2 i_instr = `instr_ANDI;

    #5 i_instr = `instr_ADD;
    #2 i_instr = `instr_XOR;
    #2 i_instr = `instr_OR;
    #2 i_instr = `instr_AND;

    #10 i_instr = `instr_QWAIT;
    #2 i_instr = `instr_FMR;
    #2 i_instr = `instr_SMIS;
    #2 i_instr = `instr_QI;
    #2 i_instr = `instr_measure;

    #5 i_instr = `instr_WFI;

    #2 i_instr = `SMIS_S6_010100;                         //1
    #2 i_instr = `SMIS_S7_101000;                         //2
    #2 i_instr = `SMIS_S8_100100;                         //3  
    #2 i_instr = `SMIS_S9_001100;                         //4
    #2 i_instr = `T0_H_S6_X90_S7;                         //5    
    #2 i_instr = `T1_CNOTS_S2_CNOTT_S3;                   //6
    #2 i_instr = `T2_Y90_S8;                              //7  
    #2 i_instr = `T1_MEASURE_S9;                          //8
    #2 i_instr = `QWAIT_30;                               //9    
    #2 i_instr = `ADDI_R1_R0_001100;                      //10
    #2 i_instr = `FMR_R2_S9;                              //11
    #2 i_instr = `BEQ_R1_R2_CASE2;                        //12  
    #2 i_instr = `T0_X90_S2;                              //13
    #2 i_instr = `QWAIT_1;                                //14
    #2 i_instr = `BEQ_R0_R0_NEXT;                         //15  
    #2 i_instr = `T0_H_S2;                                //16    
    #2 i_instr = `QWAIT_1;                                //17
    #2 i_instr = `T0_MEASURE_S2;                          //18  
    #2 i_instr = `QWAIT_30;                               //19

  end




  QPU_exu_decode test_exu_decode(
      .i_instr (i_instr),
      .i_pc (i_pc),
      .i_prdt_taken (i_prdt_taken),

      .dec_rs1x0(dec_rs1x0),
      .dec_rs2x0(dec_rs2x0),
      .dec_rs1en(dec_rs1en),
      .dec_rs2en(dec_rs2en),
      .dec_rdwen(dec_rdwen),
      .dec_rs1idx(dec_rs1idx),
      .dec_rs2idx(dec_rs2idx),
      .dec_rdidx(dec_rdidx),
      .dec_info(dec_info),
      .dec_imm(dec_imm),
      .dec_pc(dec_pc),

      .dec_new_timepoint(dec_new_timepoint),
      .dec_need_qubitflag(dec_need_qubitflag),
      .dec_measure(dec_measure),
      .dec_fmr(dec_fmr),

      .dec_bxx(dec_bxx),
      .dec_bjp_imm(dec_bjp_imm)
  );


endmodule
























