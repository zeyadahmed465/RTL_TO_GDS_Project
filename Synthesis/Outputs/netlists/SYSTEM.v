/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Sep 22 15:57:43 2023
/////////////////////////////////////////////////////////////


module tx_controller ( Data_Valid, PAR_EN, ser_done, CLK, RST, ser_en, mux_sel, 
        busy );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, CLK, RST;
  output ser_en, busy;
  wire   n6, n7, n8, n9, n1, n2, n3, n4, n5;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  OAI21X2M U3 ( .A0(n7), .A1(n2), .B0(n9), .Y(mux_sel[1]) );
  NAND2X2M U4 ( .A(n2), .B(n3), .Y(n9) );
  OAI21X2M U5 ( .A0(current_state[2]), .A1(current_state[0]), .B0(n9), .Y(
        mux_sel[0]) );
  NAND2X2M U6 ( .A(current_state[1]), .B(n4), .Y(n7) );
  INVX2M U7 ( .A(current_state[0]), .Y(n2) );
  INVX2M U8 ( .A(current_state[2]), .Y(n4) );
  INVX2M U9 ( .A(current_state[1]), .Y(n3) );
  OAI33X2M U10 ( .A0(n2), .A1(current_state[2]), .A2(current_state[1]), .B0(n7), .B1(ser_done), .B2(current_state[0]), .Y(ser_en) );
  OAI221X1M U11 ( .A0(n9), .A1(n4), .B0(current_state[2]), .B1(n2), .C0(n7), 
        .Y(busy) );
  OAI31X1M U12 ( .A0(n5), .A1(current_state[0]), .A2(n7), .B0(n1), .Y(
        next_state[1]) );
  INVX2M U13 ( .A(ser_en), .Y(n1) );
  NOR3X2M U14 ( .A(n8), .B(current_state[2]), .C(current_state[0]), .Y(
        next_state[0]) );
  AOI32X1M U15 ( .A0(ser_done), .A1(current_state[1]), .A2(PAR_EN), .B0(
        Data_Valid), .B1(n3), .Y(n8) );
  NOR2X2M U16 ( .A(n6), .B(n7), .Y(next_state[2]) );
  AOI21X2M U17 ( .A0(ser_done), .A1(n5), .B0(current_state[0]), .Y(n6) );
  INVX2M U18 ( .A(PAR_EN), .Y(n5) );
endmodule


module Parity_Calc ( CLK, RST, PAR_EN, PAR_TYP, P_DATA, busy, Data_Valid, 
        par_bit );
  input [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, busy, Data_Valid;
  output par_bit;
  wire   n1, n2, n3, n4, n5, n6, n7;

  DFFRQX2M par_bit_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(par_bit) );
  XNOR2X2M U2 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  XOR3XLM U3 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U4 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n7) );
  NAND3BX2M U6 ( .AN(busy), .B(Data_Valid), .C(PAR_EN), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
endmodule


module Serializer ( P_DATA, Data_Valid, busy, ser_en, CLK, RST, ser_data, 
        ser_done );
  input [7:0] P_DATA;
  input Data_Valid, busy, ser_en, CLK, RST;
  output ser_data, ser_done;
  wire   n4, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n1, n2, n3, n5;
  wire   [7:0] temp_data;
  wire   [3:0] count;

  DFFRQX2M \temp_data_reg[6]  ( .D(n25), .CK(CLK), .RN(RST), .Q(temp_data[6])
         );
  DFFRQX2M \temp_data_reg[5]  ( .D(n26), .CK(CLK), .RN(RST), .Q(temp_data[5])
         );
  DFFRQX2M \temp_data_reg[4]  ( .D(n27), .CK(CLK), .RN(RST), .Q(temp_data[4])
         );
  DFFRQX2M \temp_data_reg[3]  ( .D(n28), .CK(CLK), .RN(RST), .Q(temp_data[3])
         );
  DFFRQX2M \temp_data_reg[2]  ( .D(n29), .CK(CLK), .RN(RST), .Q(temp_data[2])
         );
  DFFRQX2M \temp_data_reg[1]  ( .D(n30), .CK(CLK), .RN(RST), .Q(temp_data[1])
         );
  DFFRQX2M \temp_data_reg[0]  ( .D(n31), .CK(CLK), .RN(RST), .Q(temp_data[0])
         );
  DFFRQX2M \temp_data_reg[7]  ( .D(n24), .CK(CLK), .RN(RST), .Q(temp_data[7])
         );
  DFFRQX2M \count_reg[2]  ( .D(n1), .CK(CLK), .RN(RST), .Q(count[2]) );
  DFFRQX2M \count_reg[0]  ( .D(n34), .CK(CLK), .RN(RST), .Q(count[0]) );
  DFFRQX2M \count_reg[1]  ( .D(n32), .CK(CLK), .RN(RST), .Q(count[1]) );
  DFFRX1M \count_reg[3]  ( .D(n33), .CK(CLK), .RN(RST), .QN(n4) );
  DFFRQX2M ser_data_reg ( .D(n23), .CK(CLK), .RN(RST), .Q(ser_data) );
  NOR4X1M U3 ( .A(n4), .B(count[0]), .C(count[1]), .D(count[2]), .Y(ser_done)
         );
  NOR2X2M U4 ( .A(n2), .B(n8), .Y(n6) );
  NOR2X2M U5 ( .A(n8), .B(n6), .Y(n7) );
  INVX2M U6 ( .A(n22), .Y(n2) );
  NOR2BX2M U7 ( .AN(Data_Valid), .B(busy), .Y(n8) );
  NOR2BX2M U8 ( .AN(ser_en), .B(ser_done), .Y(n22) );
  INVX2M U9 ( .A(n19), .Y(n3) );
  AOI2BB2XLM U10 ( .B0(n2), .B1(ser_en), .A0N(count[0]), .A1N(n2), .Y(n18) );
  OAI2B2X1M U11 ( .A1N(count[1]), .A0(n18), .B0(count[1]), .B1(n19), .Y(n32)
         );
  OAI21X2M U12 ( .A0(count[1]), .A1(n2), .B0(n18), .Y(n17) );
  OAI21X2M U13 ( .A0(n20), .A1(n4), .B0(n21), .Y(n33) );
  NAND4X2M U14 ( .A(count[2]), .B(count[1]), .C(n3), .D(n4), .Y(n21) );
  AOI21X2M U15 ( .A0(n22), .A1(n5), .B0(n17), .Y(n20) );
  NAND2X2M U16 ( .A(count[0]), .B(n22), .Y(n19) );
  NOR2X2M U17 ( .A(count[0]), .B(n2), .Y(n34) );
  INVX2M U18 ( .A(n16), .Y(n1) );
  AOI32X1M U19 ( .A0(count[1]), .A1(n5), .A2(n3), .B0(n17), .B1(count[2]), .Y(
        n16) );
  OAI2BB1X2M U20 ( .A0N(temp_data[0]), .A1N(n7), .B0(n15), .Y(n31) );
  AOI22X1M U21 ( .A0(temp_data[1]), .A1(n6), .B0(P_DATA[0]), .B1(n8), .Y(n15)
         );
  OAI2BB1X2M U22 ( .A0N(n7), .A1N(temp_data[1]), .B0(n14), .Y(n30) );
  AOI22X1M U23 ( .A0(temp_data[2]), .A1(n6), .B0(P_DATA[1]), .B1(n8), .Y(n14)
         );
  OAI2BB1X2M U24 ( .A0N(n7), .A1N(temp_data[2]), .B0(n13), .Y(n29) );
  AOI22X1M U25 ( .A0(temp_data[3]), .A1(n6), .B0(P_DATA[2]), .B1(n8), .Y(n13)
         );
  OAI2BB1X2M U26 ( .A0N(n7), .A1N(temp_data[3]), .B0(n12), .Y(n28) );
  AOI22X1M U27 ( .A0(temp_data[4]), .A1(n6), .B0(P_DATA[3]), .B1(n8), .Y(n12)
         );
  OAI2BB1X2M U28 ( .A0N(n7), .A1N(temp_data[4]), .B0(n11), .Y(n27) );
  AOI22X1M U29 ( .A0(temp_data[5]), .A1(n6), .B0(P_DATA[4]), .B1(n8), .Y(n11)
         );
  OAI2BB1X2M U30 ( .A0N(n7), .A1N(temp_data[5]), .B0(n10), .Y(n26) );
  AOI22X1M U31 ( .A0(temp_data[6]), .A1(n6), .B0(P_DATA[5]), .B1(n8), .Y(n10)
         );
  OAI2BB1X2M U32 ( .A0N(n7), .A1N(temp_data[6]), .B0(n9), .Y(n25) );
  AOI22X1M U33 ( .A0(temp_data[7]), .A1(n6), .B0(P_DATA[6]), .B1(n8), .Y(n9)
         );
  AO22X1M U34 ( .A0(n6), .A1(temp_data[0]), .B0(ser_data), .B1(n7), .Y(n23) );
  AO22X1M U35 ( .A0(n7), .A1(temp_data[7]), .B0(P_DATA[7]), .B1(n8), .Y(n24)
         );
  INVX2M U36 ( .A(count[2]), .Y(n5) );
endmodule


module mux_4_1 ( A, B, C, D, sel, out );
  input [1:0] sel;
  input A, B, C, D;
  output out;
  wire   n2, n3, n1, n4, n5, n6, n7;

  INVX8M U1 ( .A(n1), .Y(out) );
  CLKINVX1M U2 ( .A(sel[1]), .Y(n4) );
  NOR2X1M U3 ( .A(sel[1]), .B(n3), .Y(n5) );
  NOR2X1M U4 ( .A(n2), .B(n4), .Y(n6) );
  NOR2XLM U5 ( .A(n5), .B(n6), .Y(n1) );
  AOI22X1M U6 ( .A0(A), .A1(n7), .B0(sel[0]), .B1(B), .Y(n3) );
  AOI22X1M U7 ( .A0(C), .A1(n7), .B0(D), .B1(sel[0]), .Y(n2) );
  INVX2M U8 ( .A(sel[0]), .Y(n7) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, CLK, RST, TX_OUT, busy
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, CLK, RST;
  output TX_OUT, busy;
  wire   ser_done, ser_en, par_bit, ser_data;
  wire   [1:0] mux_sel;

  tx_controller U1 ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(
        ser_done), .CLK(CLK), .RST(RST), .ser_en(ser_en), .mux_sel(mux_sel), 
        .busy(busy) );
  Parity_Calc P1 ( .CLK(CLK), .RST(RST), .PAR_EN(PAR_EN), .PAR_TYP(PAR_TYP), 
        .P_DATA(P_DATA), .busy(busy), .Data_Valid(Data_Valid), .par_bit(
        par_bit) );
  Serializer S1 ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), .busy(busy), 
        .ser_en(ser_en), .CLK(CLK), .RST(RST), .ser_data(ser_data), .ser_done(
        ser_done) );
  mux_4_1 M1 ( .A(1'b0), .B(ser_data), .C(par_bit), .D(1'b1), .sel(mux_sel), 
        .out(TX_OUT) );
endmodule


module data_sampling ( RX_IN, Prescale, enable, edge_count, CLK, RST, 
        sampled_bit );
  input [5:0] Prescale;
  input [2:0] edge_count;
  input RX_IN, enable, CLK, RST;
  output sampled_bit;
  wire   \half_minus_one[0] , n9, n10, n11, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n1, n2, n3, n4;
  assign \half_minus_one[0]  = Prescale[1];

  DFFRX1M \sample_test_reg[1]  ( .D(n28), .CK(CLK), .RN(RST), .QN(n10) );
  DFFRX1M \sample_test_reg[0]  ( .D(n27), .CK(CLK), .RN(RST), .QN(n11) );
  DFFRX1M \sample_test_reg[2]  ( .D(n29), .CK(CLK), .RN(RST), .QN(n9) );
  XOR3XLM U3 ( .A(\half_minus_one[0] ), .B(edge_count[1]), .C(Prescale[2]), 
        .Y(n19) );
  XOR3XLM U4 ( .A(edge_count[2]), .B(Prescale[3]), .C(n21), .Y(n20) );
  OAI32X1M U5 ( .A0(n11), .A1(n2), .A2(n1), .B0(n16), .B1(n17), .Y(n27) );
  INVX2M U6 ( .A(enable), .Y(n1) );
  INVX2M U7 ( .A(n17), .Y(n2) );
  NAND3X2M U8 ( .A(n18), .B(n19), .C(n20), .Y(n17) );
  OAI31X1M U9 ( .A0(n18), .A1(n3), .A2(n23), .B0(enable), .Y(n22) );
  INVX2M U10 ( .A(n24), .Y(n3) );
  XOR3XLM U11 ( .A(edge_count[2]), .B(Prescale[3]), .C(n4), .Y(n23) );
  OAI2B2X1M U12 ( .A1N(n25), .A0(n16), .B0(n25), .B1(n9), .Y(n29) );
  OAI31X1M U13 ( .A0(n26), .A1(n18), .A2(n24), .B0(enable), .Y(n25) );
  CLKXOR2X2M U14 ( .A(edge_count[2]), .B(Prescale[3]), .Y(n26) );
  CLKXOR2X2M U15 ( .A(\half_minus_one[0] ), .B(edge_count[0]), .Y(n18) );
  CLKXOR2X2M U16 ( .A(edge_count[1]), .B(Prescale[2]), .Y(n24) );
  INVX2M U17 ( .A(Prescale[2]), .Y(n4) );
  NAND2BX2M U18 ( .AN(\half_minus_one[0] ), .B(n4), .Y(n21) );
  NAND2X2M U19 ( .A(RX_IN), .B(enable), .Y(n16) );
  OAI2B2X1M U20 ( .A1N(n22), .A0(n16), .B0(n10), .B1(n22), .Y(n28) );
  AOI21X2M U21 ( .A0(n11), .A1(n9), .B0(n10), .Y(sampled_bit) );
endmodule


module edge_bit_counter ( enable, CLK, RST, bit_cnt, edge_cnt );
  output [3:0] bit_cnt;
  output [2:0] edge_cnt;
  input enable, CLK, RST;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n1, n2, n3, n4;

  DFFRQX2M \bit_cnt_reg[3]  ( .D(n21), .CK(CLK), .RN(RST), .Q(bit_cnt[3]) );
  DFFRQX2M \bit_cnt_reg[2]  ( .D(n16), .CK(CLK), .RN(RST), .Q(bit_cnt[2]) );
  DFFRQX2M \edge_cnt_reg[2]  ( .D(n20), .CK(CLK), .RN(RST), .Q(edge_cnt[2]) );
  DFFRQX2M \edge_cnt_reg[0]  ( .D(n19), .CK(CLK), .RN(RST), .Q(edge_cnt[0]) );
  DFFRQX2M \edge_cnt_reg[1]  ( .D(n18), .CK(CLK), .RN(RST), .Q(edge_cnt[1]) );
  DFFRQX2M \bit_cnt_reg[0]  ( .D(n22), .CK(CLK), .RN(RST), .Q(bit_cnt[0]) );
  DFFRQX2M \bit_cnt_reg[1]  ( .D(n17), .CK(CLK), .RN(RST), .Q(bit_cnt[1]) );
  OAI21X2M U3 ( .A0(n12), .A1(n13), .B0(enable), .Y(n10) );
  NOR2BX2M U4 ( .AN(enable), .B(n12), .Y(n15) );
  NOR2BX2M U5 ( .AN(n7), .B(n2), .Y(n6) );
  OAI32X1M U6 ( .A0(n14), .A1(n5), .A2(n3), .B0(n6), .B1(n4), .Y(n21) );
  NAND2X2M U7 ( .A(bit_cnt[1]), .B(n4), .Y(n14) );
  INVX2M U8 ( .A(bit_cnt[3]), .Y(n4) );
  OAI32X1M U9 ( .A0(n5), .A1(bit_cnt[2]), .A2(n2), .B0(n6), .B1(n3), .Y(n16)
         );
  OAI22X1M U10 ( .A0(n8), .A1(n1), .B0(edge_cnt[1]), .B1(n9), .Y(n18) );
  OAI22X1M U11 ( .A0(n7), .A1(n2), .B0(bit_cnt[1]), .B1(n5), .Y(n17) );
  NAND3BX2M U12 ( .AN(n10), .B(edge_cnt[0]), .C(n12), .Y(n9) );
  XNOR2X2M U13 ( .A(edge_cnt[0]), .B(n10), .Y(n19) );
  NAND4X2M U14 ( .A(bit_cnt[3]), .B(bit_cnt[1]), .C(bit_cnt[0]), .D(n3), .Y(
        n13) );
  NAND3X2M U15 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .Y(n12) );
  NOR2BX2M U16 ( .AN(edge_cnt[0]), .B(n10), .Y(n8) );
  NAND3X2M U17 ( .A(bit_cnt[0]), .B(n13), .C(n15), .Y(n5) );
  OAI21X2M U18 ( .A0(n1), .A1(n9), .B0(n11), .Y(n20) );
  OAI2B1X2M U19 ( .A1N(n8), .A0(n12), .B0(edge_cnt[2]), .Y(n11) );
  INVX2M U20 ( .A(bit_cnt[1]), .Y(n2) );
  INVX2M U21 ( .A(edge_cnt[1]), .Y(n1) );
  INVX2M U22 ( .A(bit_cnt[2]), .Y(n3) );
  AND2X2M U23 ( .A(n15), .B(bit_cnt[0]), .Y(n7) );
  CLKXOR2X2M U24 ( .A(bit_cnt[0]), .B(n15), .Y(n22) );
endmodule


module RX_controller ( RX_IN, PAR_EN, edge_cnt, bit_cnt, stp_err, strt_glitch, 
        par_err, CLK, RST, par_chk_en, strt_chk_en, stp_chk_en, deser_en, 
        samp_en, cnt_en, data_valid );
  input [2:0] edge_cnt;
  input [3:0] bit_cnt;
  input RX_IN, PAR_EN, stp_err, strt_glitch, par_err, CLK, RST;
  output par_chk_en, strt_chk_en, stp_chk_en, deser_en, samp_en, cnt_en,
         data_valid;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n1, n2,
         n3, n4, n5;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  NAND2X2M U3 ( .A(n13), .B(n2), .Y(n19) );
  NOR2X2M U4 ( .A(n4), .B(n8), .Y(stp_chk_en) );
  NAND2X2M U5 ( .A(n2), .B(n3), .Y(n8) );
  NAND2X2M U6 ( .A(n7), .B(n19), .Y(cnt_en) );
  NOR3X2M U7 ( .A(n2), .B(current_state[1]), .C(n4), .Y(data_valid) );
  INVX2M U8 ( .A(current_state[2]), .Y(n4) );
  INVX2M U9 ( .A(current_state[0]), .Y(n2) );
  NAND3X2M U10 ( .A(n14), .B(n11), .C(n15), .Y(next_state[0]) );
  AOI2BB2XLM U11 ( .B0(n16), .B1(n10), .A0N(RX_IN), .A1N(n17), .Y(n15) );
  NAND4X2M U12 ( .A(PAR_EN), .B(deser_en), .C(bit_cnt[3]), .D(n18), .Y(n14) );
  AOI2BB1X2M U13 ( .A0N(n8), .A1N(current_state[2]), .B0(data_valid), .Y(n17)
         );
  INVX2M U14 ( .A(n19), .Y(deser_en) );
  NOR2X2M U15 ( .A(n3), .B(current_state[2]), .Y(n13) );
  INVX2M U16 ( .A(n9), .Y(par_chk_en) );
  INVX2M U17 ( .A(current_state[1]), .Y(n3) );
  OAI22X1M U18 ( .A0(strt_glitch), .A1(n7), .B0(par_err), .B1(n9), .Y(n16) );
  OAI31X1M U19 ( .A0(n9), .A1(par_err), .A2(n10), .B0(n11), .Y(next_state[2])
         );
  NOR4X1M U20 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .C(bit_cnt[0]), .D(n10), .Y(
        n18) );
  NAND3X2M U21 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .Y(n10) );
  OAI31X1M U22 ( .A0(n7), .A1(strt_glitch), .A2(n10), .B0(n12), .Y(
        next_state[1]) );
  AOI31X2M U23 ( .A0(n10), .A1(n1), .A2(n13), .B0(deser_en), .Y(n12) );
  INVX2M U24 ( .A(par_err), .Y(n1) );
  NAND3BX2M U25 ( .AN(stp_err), .B(stp_chk_en), .C(n5), .Y(n11) );
  INVX2M U26 ( .A(n10), .Y(n5) );
  NAND3X2M U27 ( .A(n3), .B(n4), .C(current_state[0]), .Y(n7) );
  NAND2X2M U28 ( .A(current_state[2]), .B(n8), .Y(samp_en) );
  NAND2X2M U29 ( .A(n13), .B(current_state[0]), .Y(n9) );
  INVX2M U30 ( .A(n7), .Y(strt_chk_en) );
endmodule


module stop_check ( sampled_bit, enable, CLK, RST, stp_err );
  input sampled_bit, enable, CLK, RST;
  output stp_err;
  wire   n2, n1;

  DFFRQX2M stp_err_reg ( .D(n2), .CK(CLK), .RN(RST), .Q(stp_err) );
  OAI2BB2X1M U2 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  INVX2M U3 ( .A(enable), .Y(n1) );
endmodule


module strt_check ( enable, sampled_bit, CLK, RST, strt_glitch );
  input enable, sampled_bit, CLK, RST;
  output strt_glitch;
  wire   n1;

  DFFRQX2M strt_glitch_reg ( .D(n1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  AO2B2X2M U2 ( .B0(sampled_bit), .B1(enable), .A0(strt_glitch), .A1N(enable), 
        .Y(n1) );
endmodule


module parity_check ( enable, sampled_bit, PAR_TYP, P_DATA, CLK, RST, par_err
 );
  input [7:0] P_DATA;
  input enable, sampled_bit, PAR_TYP, CLK, RST;
  output par_err;
  wire   par_bit, N9, n1, n3, n4, n5, n6, n7, n2;

  DFFRQX2M par_bit_reg ( .D(N9), .CK(CLK), .RN(RST), .Q(par_bit) );
  DFFRQX2M par_err_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(par_err) );
  XOR3XLM U3 ( .A(PAR_TYP), .B(n3), .C(n4), .Y(N9) );
  XOR3XLM U4 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
  XOR3XLM U5 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  XNOR2X2M U6 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  OAI2BB2X1M U7 ( .B0(n1), .B1(n2), .A0N(par_err), .A1N(n2), .Y(n7) );
  INVX2M U8 ( .A(enable), .Y(n2) );
  XNOR2X2M U9 ( .A(sampled_bit), .B(par_bit), .Y(n1) );
  XNOR2X2M U10 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
endmodule


module deserializer ( sampled_bit, edge_cnt, enable, CLK, RST, P_DATA );
  input [2:0] edge_cnt;
  output [7:0] P_DATA;
  input sampled_bit, enable, CLK, RST;
  wire   n1, n2, n4, n5, n8, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n3, n6, n7, n9;
  wire   [2:0] cnt;

  DFFRQX2M \cnt_reg[2]  ( .D(n23), .CK(CLK), .RN(RST), .Q(cnt[2]) );
  DFFRQX2M \cnt_reg[1]  ( .D(n24), .CK(CLK), .RN(RST), .Q(cnt[1]) );
  DFFRQX2M \cnt_reg[0]  ( .D(n25), .CK(CLK), .RN(RST), .Q(cnt[0]) );
  DFFRQX2M \P_DATA_reg[5]  ( .D(n28), .CK(CLK), .RN(RST), .Q(P_DATA[5]) );
  DFFRQX2M \P_DATA_reg[1]  ( .D(n32), .CK(CLK), .RN(RST), .Q(P_DATA[1]) );
  DFFRQX2M \P_DATA_reg[4]  ( .D(n29), .CK(CLK), .RN(RST), .Q(P_DATA[4]) );
  DFFRQX2M \P_DATA_reg[0]  ( .D(n33), .CK(CLK), .RN(RST), .Q(P_DATA[0]) );
  DFFRQX2M \P_DATA_reg[7]  ( .D(n26), .CK(CLK), .RN(RST), .Q(P_DATA[7]) );
  DFFRQX2M \P_DATA_reg[3]  ( .D(n30), .CK(CLK), .RN(RST), .Q(P_DATA[3]) );
  DFFRQX2M \P_DATA_reg[6]  ( .D(n27), .CK(CLK), .RN(RST), .Q(P_DATA[6]) );
  DFFRQX2M \P_DATA_reg[2]  ( .D(n31), .CK(CLK), .RN(RST), .Q(P_DATA[2]) );
  NAND2X2M U3 ( .A(sampled_bit), .B(n22), .Y(n17) );
  NAND2BX2M U4 ( .AN(n12), .B(sampled_bit), .Y(n10) );
  INVX2M U5 ( .A(n4), .Y(n9) );
  INVX2M U6 ( .A(n22), .Y(n7) );
  OAI221X1M U7 ( .A0(n4), .A1(n5), .B0(n9), .B1(n6), .C0(n8), .Y(n24) );
  XNOR2X2M U8 ( .A(n3), .B(n9), .Y(n25) );
  NAND2X2M U9 ( .A(n6), .B(n3), .Y(n15) );
  NAND4BX1M U10 ( .AN(edge_cnt[0]), .B(edge_cnt[1]), .C(enable), .D(
        edge_cnt[2]), .Y(n4) );
  NOR2X2M U11 ( .A(n4), .B(cnt[2]), .Y(n22) );
  OAI2B2X1M U12 ( .A1N(cnt[2]), .A0(n1), .B0(n2), .B1(n7), .Y(n23) );
  NOR2X2M U13 ( .A(n2), .B(n4), .Y(n1) );
  OAI21X2M U14 ( .A0(n2), .A1(n17), .B0(n18), .Y(n30) );
  OAI21X2M U15 ( .A0(n2), .A1(n7), .B0(P_DATA[3]), .Y(n18) );
  OAI21X2M U16 ( .A0(n8), .A1(n17), .B0(n19), .Y(n31) );
  OAI21X2M U17 ( .A0(n7), .A1(n8), .B0(P_DATA[2]), .Y(n19) );
  OAI21X2M U18 ( .A0(n15), .A1(n17), .B0(n21), .Y(n33) );
  OAI21X2M U19 ( .A0(n7), .A1(n15), .B0(P_DATA[0]), .Y(n21) );
  OAI21X2M U20 ( .A0(n5), .A1(n17), .B0(n20), .Y(n32) );
  OAI21X2M U21 ( .A0(n7), .A1(n5), .B0(P_DATA[1]), .Y(n20) );
  NAND2X2M U22 ( .A(cnt[2]), .B(n9), .Y(n12) );
  OAI21X2M U23 ( .A0(n10), .A1(n8), .B0(n13), .Y(n27) );
  OAI21X2M U24 ( .A0(n12), .A1(n8), .B0(P_DATA[6]), .Y(n13) );
  OAI21X2M U25 ( .A0(n10), .A1(n15), .B0(n16), .Y(n29) );
  OAI21X2M U26 ( .A0(n12), .A1(n15), .B0(P_DATA[4]), .Y(n16) );
  OAI21X2M U27 ( .A0(n5), .A1(n10), .B0(n14), .Y(n28) );
  OAI21X2M U28 ( .A0(n5), .A1(n12), .B0(P_DATA[5]), .Y(n14) );
  OAI21X2M U29 ( .A0(n2), .A1(n10), .B0(n11), .Y(n26) );
  OAI21X2M U30 ( .A0(n2), .A1(n12), .B0(P_DATA[7]), .Y(n11) );
  NAND2X2M U31 ( .A(cnt[1]), .B(cnt[0]), .Y(n2) );
  NAND2X2M U32 ( .A(cnt[1]), .B(n3), .Y(n8) );
  NAND2X2M U33 ( .A(cnt[0]), .B(n6), .Y(n5) );
  INVX2M U34 ( .A(cnt[0]), .Y(n3) );
  INVX2M U35 ( .A(cnt[1]), .Y(n6) );
endmodule


module UART_RX ( RX_IN, PAR_EN, Prescale, PAR_TYP, RX_CLK, RST, P_DATA, 
        data_Valid );
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input RX_IN, PAR_EN, PAR_TYP, RX_CLK, RST;
  output data_Valid;
  wire   samp_en, sampled_bit, cnt_en, stp_err, strt_glitch, par_err,
         par_chk_en, strt_chk_en, stp_chk_en, deser_en, n1, n2;
  wire   [2:0] edge_cnt;
  wire   [3:0] bit_cnt;

  data_sampling D0 ( .RX_IN(RX_IN), .Prescale(Prescale), .enable(samp_en), 
        .edge_count(edge_cnt), .CLK(RX_CLK), .RST(n1), .sampled_bit(
        sampled_bit) );
  edge_bit_counter E_B_c ( .enable(cnt_en), .CLK(RX_CLK), .RST(n1), .bit_cnt(
        bit_cnt), .edge_cnt(edge_cnt) );
  RX_controller RX0 ( .RX_IN(RX_IN), .PAR_EN(PAR_EN), .edge_cnt(edge_cnt), 
        .bit_cnt(bit_cnt), .stp_err(stp_err), .strt_glitch(strt_glitch), 
        .par_err(par_err), .CLK(RX_CLK), .RST(n1), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .deser_en(deser_en), .samp_en(samp_en), .cnt_en(cnt_en), .data_valid(data_Valid) );
  stop_check STP0 ( .sampled_bit(sampled_bit), .enable(stp_chk_en), .CLK(
        RX_CLK), .RST(n1), .stp_err(stp_err) );
  strt_check STR0 ( .enable(strt_chk_en), .sampled_bit(sampled_bit), .CLK(
        RX_CLK), .RST(n1), .strt_glitch(strt_glitch) );
  parity_check Par0 ( .enable(par_chk_en), .sampled_bit(sampled_bit), 
        .PAR_TYP(PAR_TYP), .P_DATA(P_DATA), .CLK(RX_CLK), .RST(n1), .par_err(
        par_err) );
  deserializer DSR0 ( .sampled_bit(sampled_bit), .edge_cnt(edge_cnt), .enable(
        deser_en), .CLK(RX_CLK), .RST(n1), .P_DATA(P_DATA) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module UART ( RST, TX_CLK, RX_CLK, RX_IN_S, RX_OUT_P, RX_OUT_V, TX_IN_P, 
        TX_IN_V, TX_OUT_S, TX_OUT_V, Prescale, parity_enable, parity_type );
  output [7:0] RX_OUT_P;
  input [7:0] TX_IN_P;
  input [5:0] Prescale;
  input RST, TX_CLK, RX_CLK, RX_IN_S, TX_IN_V, parity_enable, parity_type;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V;
  wire   n1, n2;

  UART_TX U0_UART_TX ( .P_DATA(TX_IN_P), .Data_Valid(TX_IN_V), .PAR_EN(
        parity_enable), .PAR_TYP(parity_type), .CLK(TX_CLK), .RST(n1), 
        .TX_OUT(TX_OUT_S), .busy(TX_OUT_V) );
  UART_RX U0_UART_RX ( .RX_IN(RX_IN_S), .PAR_EN(parity_enable), .Prescale(
        Prescale), .PAR_TYP(parity_type), .RX_CLK(RX_CLK), .RST(n1), .P_DATA(
        RX_OUT_P), .data_Valid(RX_OUT_V) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module RST_SYNC_0 ( RST, CLK, SYNC_RST );
  input RST, CLK;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  DFFRQX2M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(\sync_reg[0] )
         );
endmodule


module RST_SYNC_1 ( RST, CLK, SYNC_RST );
  input RST, CLK;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  DFFRQX2M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(\sync_reg[0] )
         );
endmodule


module DATA_SYNC ( CLK, RST, unsync_bus, bus_enable, sync_bus, enable_pulse_d
 );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input CLK, RST, bus_enable;
  output enable_pulse_d;
  wire   enable_flop, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [1:0] sync_reg;

  DFFRQX2M enable_flop_reg ( .D(sync_reg[1]), .CK(CLK), .RN(RST), .Q(
        enable_flop) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(CLK), .RN(RST), .Q(sync_bus[7]) );
  DFFRQX2M \sync_reg_reg[1]  ( .D(sync_reg[0]), .CK(CLK), .RN(RST), .Q(
        sync_reg[1]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(CLK), .RN(RST), .Q(sync_bus[5]) );
  DFFRQX2M \sync_bus_reg[6]  ( .D(n8), .CK(CLK), .RN(RST), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[4]  ( .D(n6), .CK(CLK), .RN(RST), .Q(sync_bus[4]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(CLK), .RN(RST), .Q(sync_bus[3]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(CLK), .RN(RST), .Q(sync_bus[1]) );
  DFFRQX2M enable_pulse_d_reg ( .D(n10), .CK(CLK), .RN(RST), .Q(enable_pulse_d) );
  DFFRQX2M \sync_bus_reg[2]  ( .D(n4), .CK(CLK), .RN(RST), .Q(sync_bus[2]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(CLK), .RN(RST), .Q(sync_bus[0]) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(bus_enable), .CK(CLK), .RN(RST), .Q(
        sync_reg[0]) );
  INVX2M U3 ( .A(n1), .Y(n10) );
  AO22X1M U4 ( .A0(unsync_bus[0]), .A1(n10), .B0(sync_bus[0]), .B1(n1), .Y(n2)
         );
  AO22X1M U5 ( .A0(unsync_bus[1]), .A1(n10), .B0(sync_bus[1]), .B1(n1), .Y(n3)
         );
  AO22X1M U6 ( .A0(unsync_bus[2]), .A1(n10), .B0(sync_bus[2]), .B1(n1), .Y(n4)
         );
  AO22X1M U7 ( .A0(unsync_bus[3]), .A1(n10), .B0(sync_bus[3]), .B1(n1), .Y(n5)
         );
  AO22X1M U8 ( .A0(unsync_bus[4]), .A1(n10), .B0(sync_bus[4]), .B1(n1), .Y(n6)
         );
  AO22X1M U9 ( .A0(unsync_bus[5]), .A1(n10), .B0(sync_bus[5]), .B1(n1), .Y(n7)
         );
  AO22X1M U10 ( .A0(unsync_bus[6]), .A1(n10), .B0(sync_bus[6]), .B1(n1), .Y(n8) );
  AO22X1M U11 ( .A0(unsync_bus[7]), .A1(n10), .B0(sync_bus[7]), .B1(n1), .Y(n9) );
  NAND2BX2M U12 ( .AN(enable_flop), .B(sync_reg[1]), .Y(n1) );
endmodule


module ClkDiv_0_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module ClkDiv_0 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en;
  output o_div_clk;
  wire   N2, div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  ClkDiv_0_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFRQX2M div_clk_reg ( .D(n18), .CK(i_ref_clk), .RN(i_rst), .Q(div_clk) );
  DFFSQX2M odd_edge_tog_reg ( .D(n17), .CK(i_ref_clk), .SN(i_rst), .Q(
        odd_edge_tog) );
  DFFRQX2M \count_reg[6]  ( .D(n19), .CK(i_ref_clk), .RN(i_rst), .Q(count[6])
         );
  DFFRQX2M \count_reg[0]  ( .D(n25), .CK(i_ref_clk), .RN(i_rst), .Q(count[0])
         );
  DFFRQX2M \count_reg[5]  ( .D(n20), .CK(i_ref_clk), .RN(i_rst), .Q(count[5])
         );
  DFFRQX2M \count_reg[4]  ( .D(n21), .CK(i_ref_clk), .RN(i_rst), .Q(count[4])
         );
  DFFRQX2M \count_reg[3]  ( .D(n22), .CK(i_ref_clk), .RN(i_rst), .Q(count[3])
         );
  DFFRQX2M \count_reg[2]  ( .D(n23), .CK(i_ref_clk), .RN(i_rst), .Q(count[2])
         );
  DFFRQX2M \count_reg[1]  ( .D(n24), .CK(i_ref_clk), .RN(i_rst), .Q(count[1])
         );
  MX2X2M U3 ( .A(i_ref_clk), .B(div_clk), .S0(N2), .Y(o_div_clk) );
  OR2X2M U4 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n1) );
  NAND2BX2M U5 ( .AN(n41), .B(i_clk_en), .Y(n7) );
  INVX2M U6 ( .A(i_div_ratio[5]), .Y(n6) );
  CLKINVX1M U7 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  OAI2BB1X1M U8 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n1), .Y(
        edge_flip_half[1]) );
  OR2X1M U9 ( .A(n1), .B(i_div_ratio[3]), .Y(n2) );
  OAI2BB1X1M U10 ( .A0N(n1), .A1N(i_div_ratio[3]), .B0(n2), .Y(
        edge_flip_half[2]) );
  NOR2X1M U11 ( .A(n2), .B(i_div_ratio[4]), .Y(n3) );
  AO21XLM U12 ( .A0(n2), .A1(i_div_ratio[4]), .B0(n3), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U13 ( .A(n3), .B(n6), .Y(n4) );
  OAI21X1M U14 ( .A0(n3), .A1(n6), .B0(n4), .Y(edge_flip_half[4]) );
  XNOR2X1M U15 ( .A(i_div_ratio[6]), .B(n4), .Y(edge_flip_half[5]) );
  NOR2X1M U16 ( .A(i_div_ratio[6]), .B(n4), .Y(n5) );
  CLKXOR2X2M U17 ( .A(i_div_ratio[7]), .B(n5), .Y(edge_flip_half[6]) );
  AO22X1M U18 ( .A0(n7), .A1(count[0]), .B0(N16), .B1(n8), .Y(n25) );
  AO22X1M U19 ( .A0(n7), .A1(count[1]), .B0(N17), .B1(n8), .Y(n24) );
  AO22X1M U20 ( .A0(n7), .A1(count[2]), .B0(N18), .B1(n8), .Y(n23) );
  AO22X1M U21 ( .A0(n7), .A1(count[3]), .B0(N19), .B1(n8), .Y(n22) );
  AO22X1M U22 ( .A0(n7), .A1(count[4]), .B0(N20), .B1(n8), .Y(n21) );
  AO22X1M U23 ( .A0(n7), .A1(count[5]), .B0(N21), .B1(n8), .Y(n20) );
  AO22X1M U24 ( .A0(n7), .A1(count[6]), .B0(N22), .B1(n8), .Y(n19) );
  AND3X1M U25 ( .A(n9), .B(n10), .C(N2), .Y(n8) );
  CLKXOR2X2M U26 ( .A(div_clk), .B(n11), .Y(n18) );
  AOI21X1M U27 ( .A0(n10), .A1(n9), .B0(n7), .Y(n11) );
  OR2X1M U28 ( .A(n12), .B(i_div_ratio[0]), .Y(n9) );
  XNOR2X1M U29 ( .A(odd_edge_tog), .B(n13), .Y(n17) );
  OR2X1M U30 ( .A(n10), .B(n7), .Y(n13) );
  CLKNAND2X2M U31 ( .A(n14), .B(i_div_ratio[0]), .Y(n10) );
  MXI2X1M U32 ( .A(n15), .B(n12), .S0(odd_edge_tog), .Y(n14) );
  NAND4X1M U33 ( .A(n16), .B(n26), .C(n27), .D(n28), .Y(n12) );
  NOR4X1M U34 ( .A(n29), .B(n30), .C(n31), .D(n32), .Y(n28) );
  CLKXOR2X2M U35 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n32) );
  CLKXOR2X2M U36 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n31) );
  CLKXOR2X2M U37 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n30) );
  CLKXOR2X2M U38 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n29) );
  XNOR2X1M U39 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n27) );
  XNOR2X1M U40 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n26) );
  XNOR2X1M U41 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n16) );
  NAND4X1M U42 ( .A(n33), .B(n34), .C(n35), .D(n36), .Y(n15) );
  NOR4X1M U43 ( .A(n37), .B(n38), .C(n39), .D(n40), .Y(n36) );
  CLKXOR2X2M U44 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n40) );
  CLKXOR2X2M U45 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n39) );
  CLKXOR2X2M U46 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n38) );
  CLKXOR2X2M U47 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n37) );
  XNOR2X1M U48 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n35) );
  XNOR2X1M U49 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n34) );
  XNOR2X1M U50 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n33) );
  CLKINVX1M U51 ( .A(n7), .Y(N2) );
  NOR4BX1M U52 ( .AN(n42), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n41) );
  NOR4X1M U53 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n42) );
endmodule


module ClkDiv_1_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module ClkDiv_1 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en;
  output o_div_clk;
  wire   N2, div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  ClkDiv_1_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFSQX2M odd_edge_tog_reg ( .D(n51), .CK(i_ref_clk), .SN(i_rst), .Q(
        odd_edge_tog) );
  DFFRQX2M div_clk_reg ( .D(n50), .CK(i_ref_clk), .RN(i_rst), .Q(div_clk) );
  DFFRQX2M \count_reg[5]  ( .D(n48), .CK(i_ref_clk), .RN(i_rst), .Q(count[5])
         );
  DFFRQX2M \count_reg[4]  ( .D(n47), .CK(i_ref_clk), .RN(i_rst), .Q(count[4])
         );
  DFFRQX2M \count_reg[3]  ( .D(n46), .CK(i_ref_clk), .RN(i_rst), .Q(count[3])
         );
  DFFRQX2M \count_reg[6]  ( .D(n49), .CK(i_ref_clk), .RN(i_rst), .Q(count[6])
         );
  DFFRQX2M \count_reg[0]  ( .D(n43), .CK(i_ref_clk), .RN(i_rst), .Q(count[0])
         );
  DFFRQX2M \count_reg[2]  ( .D(n45), .CK(i_ref_clk), .RN(i_rst), .Q(count[2])
         );
  DFFRQX2M \count_reg[1]  ( .D(n44), .CK(i_ref_clk), .RN(i_rst), .Q(count[1])
         );
  MX2X2M U3 ( .A(i_ref_clk), .B(div_clk), .S0(N2), .Y(o_div_clk) );
  NAND2BX2M U4 ( .AN(n41), .B(i_clk_en), .Y(n7) );
  INVX2M U5 ( .A(i_div_ratio[5]), .Y(n6) );
  OR2X2M U6 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n1) );
  CLKINVX1M U7 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  OAI2BB1X1M U8 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n1), .Y(
        edge_flip_half[1]) );
  OR2X1M U9 ( .A(n1), .B(i_div_ratio[3]), .Y(n2) );
  OAI2BB1X1M U10 ( .A0N(n1), .A1N(i_div_ratio[3]), .B0(n2), .Y(
        edge_flip_half[2]) );
  NOR2X1M U11 ( .A(n2), .B(i_div_ratio[4]), .Y(n3) );
  AO21XLM U12 ( .A0(n2), .A1(i_div_ratio[4]), .B0(n3), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U13 ( .A(n3), .B(n6), .Y(n4) );
  OAI21X1M U14 ( .A0(n3), .A1(n6), .B0(n4), .Y(edge_flip_half[4]) );
  XNOR2X1M U15 ( .A(i_div_ratio[6]), .B(n4), .Y(edge_flip_half[5]) );
  NOR2X1M U16 ( .A(i_div_ratio[6]), .B(n4), .Y(n5) );
  CLKXOR2X2M U17 ( .A(i_div_ratio[7]), .B(n5), .Y(edge_flip_half[6]) );
  AO22X1M U18 ( .A0(n7), .A1(count[0]), .B0(N16), .B1(n8), .Y(n43) );
  AO22X1M U19 ( .A0(n7), .A1(count[1]), .B0(N17), .B1(n8), .Y(n44) );
  AO22X1M U20 ( .A0(n7), .A1(count[2]), .B0(N18), .B1(n8), .Y(n45) );
  AO22X1M U21 ( .A0(n7), .A1(count[3]), .B0(N19), .B1(n8), .Y(n46) );
  AO22X1M U22 ( .A0(n7), .A1(count[4]), .B0(N20), .B1(n8), .Y(n47) );
  AO22X1M U23 ( .A0(n7), .A1(count[5]), .B0(N21), .B1(n8), .Y(n48) );
  AO22X1M U24 ( .A0(n7), .A1(count[6]), .B0(N22), .B1(n8), .Y(n49) );
  AND3X1M U25 ( .A(n9), .B(n10), .C(N2), .Y(n8) );
  CLKXOR2X2M U26 ( .A(div_clk), .B(n11), .Y(n50) );
  AOI21X1M U27 ( .A0(n10), .A1(n9), .B0(n7), .Y(n11) );
  OR2X1M U28 ( .A(n12), .B(i_div_ratio[0]), .Y(n9) );
  XNOR2X1M U29 ( .A(odd_edge_tog), .B(n13), .Y(n51) );
  OR2X1M U30 ( .A(n10), .B(n7), .Y(n13) );
  CLKNAND2X2M U31 ( .A(n14), .B(i_div_ratio[0]), .Y(n10) );
  MXI2X1M U32 ( .A(n15), .B(n12), .S0(odd_edge_tog), .Y(n14) );
  NAND4X1M U33 ( .A(n16), .B(n26), .C(n27), .D(n28), .Y(n12) );
  NOR4X1M U34 ( .A(n29), .B(n30), .C(n31), .D(n32), .Y(n28) );
  CLKXOR2X2M U35 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n32) );
  CLKXOR2X2M U36 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n31) );
  CLKXOR2X2M U37 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n30) );
  CLKXOR2X2M U38 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n29) );
  XNOR2X1M U39 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n27) );
  XNOR2X1M U40 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n26) );
  XNOR2X1M U41 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n16) );
  NAND4X1M U42 ( .A(n33), .B(n34), .C(n35), .D(n36), .Y(n15) );
  NOR4X1M U43 ( .A(n37), .B(n38), .C(n39), .D(n40), .Y(n36) );
  CLKXOR2X2M U44 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n40) );
  CLKXOR2X2M U45 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n39) );
  CLKXOR2X2M U46 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n38) );
  CLKXOR2X2M U47 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n37) );
  XNOR2X1M U48 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n35) );
  XNOR2X1M U49 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n34) );
  XNOR2X1M U50 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n33) );
  CLKINVX1M U51 ( .A(n7), .Y(N2) );
  NOR4BX1M U52 ( .AN(n42), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n41) );
  NOR4X1M U53 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n42) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX12M U0_TLATNCAX12M ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module REG_FILE ( WrData, Address, WrEn, RdEn, CLK, RST, RdData, RdData_VLD, 
        REG0, REG1, REG2, REG3 );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input WrEn, RdEn, CLK, RST;
  output RdData_VLD;
  wire   \Reg_File[13][7] , \Reg_File[13][6] , \Reg_File[13][5] ,
         \Reg_File[13][4] , \Reg_File[13][3] , \Reg_File[13][2] ,
         \Reg_File[13][1] , \Reg_File[13][0] , \Reg_File[12][7] ,
         \Reg_File[12][6] , \Reg_File[12][5] , \Reg_File[12][4] ,
         \Reg_File[12][3] , \Reg_File[12][2] , \Reg_File[12][1] ,
         \Reg_File[12][0] , \Reg_File[9][7] , \Reg_File[9][6] ,
         \Reg_File[9][5] , \Reg_File[9][4] , \Reg_File[9][3] ,
         \Reg_File[9][2] , \Reg_File[9][1] , \Reg_File[9][0] ,
         \Reg_File[8][7] , \Reg_File[8][6] , \Reg_File[8][5] ,
         \Reg_File[8][4] , \Reg_File[8][3] , \Reg_File[8][2] ,
         \Reg_File[8][1] , \Reg_File[8][0] , \Reg_File[7][7] ,
         \Reg_File[7][6] , \Reg_File[7][5] , \Reg_File[7][4] ,
         \Reg_File[7][3] , \Reg_File[7][2] , \Reg_File[7][1] ,
         \Reg_File[7][0] , \Reg_File[6][7] , \Reg_File[6][6] ,
         \Reg_File[6][5] , \Reg_File[6][4] , \Reg_File[6][3] ,
         \Reg_File[6][2] , \Reg_File[6][1] , \Reg_File[6][0] , n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n50, n51, n52, n57, n60, n61, n62, n63, n64, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n144, n145, n146, n147, n148, n149, n150, n151, n152, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n174, n175, n176, n177, n178,
         n179, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n49, n58, n59, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n85, n99, n133, n153,
         n173, n180, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357;

  DFFRX2M \Reg_File_reg[1][3]  ( .D(n218), .CK(CLK), .RN(n71), .Q(REG1[3]) );
  DFFRQX2M \Reg_File_reg[2][2]  ( .D(n225), .CK(CLK), .RN(n73), .Q(REG2[2]) );
  DFFRQX2M \Reg_File_reg[6][7]  ( .D(n262), .CK(CLK), .RN(n74), .Q(
        \Reg_File[6][7] ) );
  DFFRQX2M \Reg_File_reg[6][6]  ( .D(n261), .CK(CLK), .RN(n74), .Q(
        \Reg_File[6][6] ) );
  DFFRQX2M \Reg_File_reg[6][5]  ( .D(n260), .CK(CLK), .RN(n74), .Q(
        \Reg_File[6][5] ) );
  DFFRQX2M \Reg_File_reg[6][4]  ( .D(n259), .CK(CLK), .RN(n74), .Q(
        \Reg_File[6][4] ) );
  DFFRQX2M \Reg_File_reg[6][3]  ( .D(n258), .CK(CLK), .RN(n74), .Q(
        \Reg_File[6][3] ) );
  DFFRQX2M \Reg_File_reg[6][2]  ( .D(n257), .CK(CLK), .RN(n73), .Q(
        \Reg_File[6][2] ) );
  DFFRQX2M \Reg_File_reg[6][1]  ( .D(n256), .CK(CLK), .RN(n73), .Q(
        \Reg_File[6][1] ) );
  DFFRQX2M \Reg_File_reg[6][0]  ( .D(n255), .CK(CLK), .RN(n73), .Q(
        \Reg_File[6][0] ) );
  DFFRQX2M \RdData_reg[7]  ( .D(n205), .CK(CLK), .RN(n73), .Q(RdData[7]) );
  DFFRQX2M \RdData_reg[6]  ( .D(n204), .CK(CLK), .RN(n72), .Q(RdData[6]) );
  DFFRQX2M \RdData_reg[5]  ( .D(n203), .CK(CLK), .RN(n72), .Q(RdData[5]) );
  DFFRQX2M \RdData_reg[4]  ( .D(n202), .CK(CLK), .RN(n72), .Q(RdData[4]) );
  DFFRQX2M \RdData_reg[3]  ( .D(n201), .CK(CLK), .RN(n72), .Q(RdData[3]) );
  DFFRQX2M \RdData_reg[2]  ( .D(n200), .CK(CLK), .RN(n72), .Q(RdData[2]) );
  DFFRQX2M \RdData_reg[1]  ( .D(n199), .CK(CLK), .RN(n72), .Q(RdData[1]) );
  DFFRQX2M \RdData_reg[0]  ( .D(n198), .CK(CLK), .RN(n72), .Q(RdData[0]) );
  DFFRQX2M \Reg_File_reg[7][7]  ( .D(n270), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][7] ) );
  DFFRQX2M \Reg_File_reg[7][6]  ( .D(n269), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][6] ) );
  DFFRQX2M \Reg_File_reg[7][5]  ( .D(n268), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][5] ) );
  DFFRQX2M \Reg_File_reg[7][4]  ( .D(n267), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][4] ) );
  DFFRQX2M \Reg_File_reg[7][3]  ( .D(n266), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][3] ) );
  DFFRQX2M \Reg_File_reg[7][2]  ( .D(n265), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][2] ) );
  DFFRQX2M \Reg_File_reg[7][1]  ( .D(n264), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][1] ) );
  DFFRQX2M \Reg_File_reg[7][0]  ( .D(n263), .CK(CLK), .RN(n74), .Q(
        \Reg_File[7][0] ) );
  DFFRQX2M \Reg_File_reg[13][7]  ( .D(n318), .CK(CLK), .RN(n72), .Q(
        \Reg_File[13][7] ) );
  DFFRQX2M \Reg_File_reg[13][6]  ( .D(n317), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][6] ) );
  DFFRQX2M \Reg_File_reg[13][5]  ( .D(n316), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][5] ) );
  DFFRQX2M \Reg_File_reg[13][4]  ( .D(n315), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][4] ) );
  DFFRQX2M \Reg_File_reg[13][3]  ( .D(n314), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][3] ) );
  DFFRQX2M \Reg_File_reg[13][2]  ( .D(n313), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][2] ) );
  DFFRQX2M \Reg_File_reg[13][1]  ( .D(n312), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][1] ) );
  DFFRQX2M \Reg_File_reg[13][0]  ( .D(n311), .CK(CLK), .RN(n76), .Q(
        \Reg_File[13][0] ) );
  DFFRQX2M \Reg_File_reg[9][7]  ( .D(n286), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][7] ) );
  DFFRQX2M \Reg_File_reg[9][6]  ( .D(n285), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][6] ) );
  DFFRQX2M \Reg_File_reg[9][5]  ( .D(n284), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][5] ) );
  DFFRQX2M \Reg_File_reg[9][4]  ( .D(n283), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][4] ) );
  DFFRQX2M \Reg_File_reg[9][3]  ( .D(n282), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][3] ) );
  DFFRQX2M \Reg_File_reg[9][2]  ( .D(n281), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][2] ) );
  DFFRQX2M \Reg_File_reg[9][1]  ( .D(n280), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][1] ) );
  DFFRQX2M \Reg_File_reg[9][0]  ( .D(n279), .CK(CLK), .RN(n75), .Q(
        \Reg_File[9][0] ) );
  DFFRQX2M \Reg_File_reg[12][7]  ( .D(n310), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][7] ) );
  DFFRQX2M \Reg_File_reg[12][6]  ( .D(n309), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][6] ) );
  DFFRQX2M \Reg_File_reg[12][5]  ( .D(n308), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][5] ) );
  DFFRQX2M \Reg_File_reg[12][4]  ( .D(n307), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][4] ) );
  DFFRQX2M \Reg_File_reg[12][3]  ( .D(n306), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][3] ) );
  DFFRQX2M \Reg_File_reg[12][2]  ( .D(n305), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][2] ) );
  DFFRQX2M \Reg_File_reg[12][1]  ( .D(n304), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][1] ) );
  DFFRQX2M \Reg_File_reg[12][0]  ( .D(n303), .CK(CLK), .RN(n75), .Q(
        \Reg_File[12][0] ) );
  DFFRQX2M \Reg_File_reg[8][7]  ( .D(n278), .CK(CLK), .RN(n75), .Q(
        \Reg_File[8][7] ) );
  DFFRQX2M \Reg_File_reg[8][6]  ( .D(n277), .CK(CLK), .RN(n75), .Q(
        \Reg_File[8][6] ) );
  DFFRQX2M \Reg_File_reg[8][5]  ( .D(n276), .CK(CLK), .RN(n74), .Q(
        \Reg_File[8][5] ) );
  DFFRQX2M \Reg_File_reg[8][4]  ( .D(n275), .CK(CLK), .RN(n74), .Q(
        \Reg_File[8][4] ) );
  DFFRQX2M \Reg_File_reg[8][3]  ( .D(n274), .CK(CLK), .RN(n74), .Q(
        \Reg_File[8][3] ) );
  DFFRQX2M \Reg_File_reg[8][2]  ( .D(n273), .CK(CLK), .RN(n74), .Q(
        \Reg_File[8][2] ) );
  DFFRQX2M \Reg_File_reg[8][1]  ( .D(n272), .CK(CLK), .RN(n72), .Q(
        \Reg_File[8][1] ) );
  DFFRQX2M \Reg_File_reg[8][0]  ( .D(n271), .CK(CLK), .RN(n74), .Q(
        \Reg_File[8][0] ) );
  DFFRQX2M \Reg_File_reg[3][4]  ( .D(n235), .CK(CLK), .RN(n73), .Q(REG3[4]) );
  DFFRQX2M \Reg_File_reg[3][2]  ( .D(n233), .CK(CLK), .RN(n73), .Q(REG3[2]) );
  DFFRQX2M \Reg_File_reg[3][3]  ( .D(n234), .CK(CLK), .RN(n73), .Q(REG3[3]) );
  DFFSQX2M \Reg_File_reg[3][5]  ( .D(n236), .CK(CLK), .SN(n72), .Q(REG3[5]) );
  DFFRX1M \Reg_File_reg[14][7]  ( .D(n326), .CK(CLK), .RN(n67), .QN(n9) );
  DFFRX1M \Reg_File_reg[14][6]  ( .D(n325), .CK(CLK), .RN(n67), .QN(n10) );
  DFFRX1M \Reg_File_reg[14][5]  ( .D(n324), .CK(CLK), .RN(n67), .QN(n11) );
  DFFRX1M \Reg_File_reg[14][4]  ( .D(n323), .CK(CLK), .RN(n67), .QN(n12) );
  DFFRX1M \Reg_File_reg[14][3]  ( .D(n322), .CK(CLK), .RN(n68), .QN(n13) );
  DFFRX1M \Reg_File_reg[14][2]  ( .D(n321), .CK(CLK), .RN(n68), .QN(n14) );
  DFFRX1M \Reg_File_reg[14][1]  ( .D(n320), .CK(CLK), .RN(n68), .QN(n15) );
  DFFRX1M \Reg_File_reg[14][0]  ( .D(n319), .CK(CLK), .RN(n68), .QN(n16) );
  DFFRX1M \Reg_File_reg[10][7]  ( .D(n294), .CK(CLK), .RN(n69), .QN(n25) );
  DFFRX1M \Reg_File_reg[10][6]  ( .D(n293), .CK(CLK), .RN(n67), .QN(n26) );
  DFFRX1M \Reg_File_reg[10][5]  ( .D(n292), .CK(CLK), .RN(n69), .QN(n27) );
  DFFRX1M \Reg_File_reg[10][4]  ( .D(n291), .CK(CLK), .RN(n69), .QN(n28) );
  DFFRX1M \Reg_File_reg[10][3]  ( .D(n290), .CK(CLK), .RN(n69), .QN(n29) );
  DFFRX1M \Reg_File_reg[10][2]  ( .D(n289), .CK(CLK), .RN(n69), .QN(n30) );
  DFFRX1M \Reg_File_reg[10][1]  ( .D(n288), .CK(CLK), .RN(n69), .QN(n31) );
  DFFRX1M \Reg_File_reg[10][0]  ( .D(n287), .CK(CLK), .RN(n69), .QN(n32) );
  DFFRX1M \Reg_File_reg[15][7]  ( .D(n334), .CK(CLK), .RN(n69), .QN(n1) );
  DFFRX1M \Reg_File_reg[15][6]  ( .D(n333), .CK(CLK), .RN(n67), .QN(n2) );
  DFFRX1M \Reg_File_reg[15][5]  ( .D(n332), .CK(CLK), .RN(n67), .QN(n3) );
  DFFRX1M \Reg_File_reg[15][4]  ( .D(n331), .CK(CLK), .RN(n67), .QN(n4) );
  DFFRX1M \Reg_File_reg[15][3]  ( .D(n330), .CK(CLK), .RN(n67), .QN(n5) );
  DFFRX1M \Reg_File_reg[15][2]  ( .D(n329), .CK(CLK), .RN(n67), .QN(n6) );
  DFFRX1M \Reg_File_reg[15][1]  ( .D(n328), .CK(CLK), .RN(n67), .QN(n7) );
  DFFRX1M \Reg_File_reg[15][0]  ( .D(n327), .CK(CLK), .RN(n67), .QN(n8) );
  DFFRX1M \Reg_File_reg[11][7]  ( .D(n302), .CK(CLK), .RN(n68), .QN(n17) );
  DFFRX1M \Reg_File_reg[11][6]  ( .D(n301), .CK(CLK), .RN(n68), .QN(n18) );
  DFFRX1M \Reg_File_reg[11][5]  ( .D(n300), .CK(CLK), .RN(n68), .QN(n19) );
  DFFRX1M \Reg_File_reg[11][4]  ( .D(n299), .CK(CLK), .RN(n68), .QN(n20) );
  DFFRX1M \Reg_File_reg[11][3]  ( .D(n298), .CK(CLK), .RN(n68), .QN(n21) );
  DFFRX1M \Reg_File_reg[11][2]  ( .D(n297), .CK(CLK), .RN(n68), .QN(n22) );
  DFFRX1M \Reg_File_reg[11][1]  ( .D(n296), .CK(CLK), .RN(n68), .QN(n23) );
  DFFRX1M \Reg_File_reg[11][0]  ( .D(n295), .CK(CLK), .RN(n68), .QN(n24) );
  DFFRQX2M \Reg_File_reg[3][1]  ( .D(n232), .CK(CLK), .RN(n73), .Q(REG3[1]) );
  DFFRX1M \Reg_File_reg[5][7]  ( .D(n254), .CK(CLK), .RN(n69), .QN(n33) );
  DFFRX1M \Reg_File_reg[5][6]  ( .D(n253), .CK(CLK), .RN(n69), .QN(n34) );
  DFFRX1M \Reg_File_reg[5][5]  ( .D(n252), .CK(CLK), .RN(n69), .QN(n35) );
  DFFRX1M \Reg_File_reg[5][4]  ( .D(n251), .CK(CLK), .RN(n70), .QN(n36) );
  DFFRX1M \Reg_File_reg[5][3]  ( .D(n250), .CK(CLK), .RN(n70), .QN(n37) );
  DFFRX1M \Reg_File_reg[5][2]  ( .D(n249), .CK(CLK), .RN(n70), .QN(n38) );
  DFFRX1M \Reg_File_reg[5][1]  ( .D(n248), .CK(CLK), .RN(n69), .QN(n39) );
  DFFRX1M \Reg_File_reg[5][0]  ( .D(n247), .CK(CLK), .RN(n70), .QN(n40) );
  DFFRX1M \Reg_File_reg[4][7]  ( .D(n246), .CK(CLK), .RN(n70), .QN(n41) );
  DFFRX1M \Reg_File_reg[4][6]  ( .D(n245), .CK(CLK), .RN(n70), .QN(n42) );
  DFFRX1M \Reg_File_reg[4][5]  ( .D(n244), .CK(CLK), .RN(n70), .QN(n43) );
  DFFRX1M \Reg_File_reg[4][4]  ( .D(n243), .CK(CLK), .RN(n70), .QN(n44) );
  DFFRX1M \Reg_File_reg[4][3]  ( .D(n242), .CK(CLK), .RN(n70), .QN(n45) );
  DFFRX1M \Reg_File_reg[4][2]  ( .D(n241), .CK(CLK), .RN(n70), .QN(n46) );
  DFFRX1M \Reg_File_reg[4][1]  ( .D(n240), .CK(CLK), .RN(n70), .QN(n47) );
  DFFRX1M \Reg_File_reg[4][0]  ( .D(n239), .CK(CLK), .RN(n71), .QN(n48) );
  DFFRQX2M RdData_VLD_reg ( .D(n206), .CK(CLK), .RN(n73), .Q(RdData_VLD) );
  DFFRQX2M \Reg_File_reg[2][7]  ( .D(n230), .CK(CLK), .RN(n73), .Q(REG2[7]) );
  DFFRQX2M \Reg_File_reg[2][6]  ( .D(n229), .CK(CLK), .RN(n73), .Q(REG2[6]) );
  DFFRQX2M \Reg_File_reg[3][0]  ( .D(n231), .CK(CLK), .RN(n73), .Q(REG3[0]) );
  DFFRQX2M \Reg_File_reg[3][6]  ( .D(n237), .CK(CLK), .RN(n73), .Q(REG3[6]) );
  DFFRQX2M \Reg_File_reg[3][7]  ( .D(n238), .CK(CLK), .RN(n73), .Q(REG3[7]) );
  DFFRX1M \Reg_File_reg[0][2]  ( .D(n209), .CK(CLK), .RN(n71), .Q(REG0[2]), 
        .QN(n62) );
  DFFRX1M \Reg_File_reg[0][0]  ( .D(n207), .CK(CLK), .RN(n71), .Q(REG0[0]), 
        .QN(n64) );
  DFFRX1M \Reg_File_reg[0][3]  ( .D(n210), .CK(CLK), .RN(n71), .Q(REG0[3]), 
        .QN(n61) );
  DFFSQX2M \Reg_File_reg[2][0]  ( .D(n223), .CK(CLK), .SN(n72), .Q(REG2[0]) );
  DFFRQX2M \Reg_File_reg[2][1]  ( .D(n224), .CK(CLK), .RN(n73), .Q(REG2[1]) );
  DFFRX1M \Reg_File_reg[0][5]  ( .D(n212), .CK(CLK), .RN(n71), .Q(REG0[5]) );
  DFFSQX2M \Reg_File_reg[2][5]  ( .D(n228), .CK(CLK), .SN(n72), .Q(REG2[5]) );
  DFFRQX2M \Reg_File_reg[2][4]  ( .D(n227), .CK(CLK), .RN(n73), .Q(REG2[4]) );
  DFFRX1M \Reg_File_reg[0][1]  ( .D(n208), .CK(CLK), .RN(n71), .Q(REG0[1]), 
        .QN(n63) );
  DFFRQX2M \Reg_File_reg[2][3]  ( .D(n226), .CK(CLK), .RN(n73), .Q(REG2[3]) );
  DFFRX1M \Reg_File_reg[1][5]  ( .D(n220), .CK(CLK), .RN(n71), .QN(n51) );
  DFFRX1M \Reg_File_reg[1][4]  ( .D(n219), .CK(CLK), .RN(n71), .QN(n52) );
  DFFRX1M \Reg_File_reg[0][6]  ( .D(n213), .CK(CLK), .RN(n71), .Q(REG0[6]) );
  DFFRQX2M \Reg_File_reg[1][2]  ( .D(n217), .CK(CLK), .RN(n70), .Q(REG1[2]) );
  DFFRHQX1M \Reg_File_reg[1][1]  ( .D(n216), .CK(CLK), .RN(n71), .Q(REG1[1])
         );
  DFFRX1M \Reg_File_reg[0][4]  ( .D(n211), .CK(CLK), .RN(RST), .Q(REG0[4]), 
        .QN(n60) );
  DFFRHQX1M \Reg_File_reg[1][0]  ( .D(n215), .CK(CLK), .RN(RST), .Q(REG1[0])
         );
  DFFRHQX4M \Reg_File_reg[1][7]  ( .D(n222), .CK(CLK), .RN(n72), .Q(REG1[7])
         );
  DFFRX1M \Reg_File_reg[0][7]  ( .D(n214), .CK(CLK), .RN(n72), .QN(n57) );
  DFFRX2M \Reg_File_reg[1][6]  ( .D(n221), .CK(CLK), .RN(n72), .QN(n50) );
  NOR2X2M U3 ( .A(n82), .B(n343), .Y(n49) );
  INVX2M U4 ( .A(n50), .Y(REG1[6]) );
  CLKINVX2M U5 ( .A(n57), .Y(REG0[7]) );
  NOR2BX2M U6 ( .AN(n177), .B(n96), .Y(n184) );
  INVX2M U7 ( .A(n52), .Y(REG1[4]) );
  INVX2M U8 ( .A(n51), .Y(REG1[5]) );
  INVX2M U9 ( .A(n178), .Y(n342) );
  INVX2M U10 ( .A(n191), .Y(n339) );
  INVX2M U11 ( .A(n192), .Y(n338) );
  INVX2M U12 ( .A(n196), .Y(n337) );
  INVX2M U13 ( .A(n197), .Y(n336) );
  INVX2M U14 ( .A(n183), .Y(n341) );
  INVX2M U15 ( .A(n185), .Y(n340) );
  NAND2X2M U16 ( .A(n179), .B(n344), .Y(n181) );
  NAND2X2M U17 ( .A(n179), .B(n346), .Y(n182) );
  NAND2X2M U18 ( .A(n184), .B(n344), .Y(n186) );
  NAND2X2M U19 ( .A(n184), .B(n346), .Y(n187) );
  NAND2X2M U20 ( .A(n189), .B(n65), .Y(n188) );
  NAND2X2M U21 ( .A(n189), .B(n58), .Y(n190) );
  NAND2X2M U22 ( .A(n194), .B(n65), .Y(n193) );
  NAND2X2M U23 ( .A(n194), .B(n58), .Y(n195) );
  NAND2BX2M U24 ( .AN(n82), .B(n65), .Y(n178) );
  NAND2X2M U25 ( .A(n189), .B(n344), .Y(n191) );
  NAND2X2M U26 ( .A(n189), .B(n346), .Y(n192) );
  NAND2X2M U27 ( .A(n194), .B(n344), .Y(n196) );
  NAND2X2M U28 ( .A(n194), .B(n346), .Y(n197) );
  NAND2X2M U29 ( .A(n184), .B(n65), .Y(n183) );
  NAND2X2M U30 ( .A(n184), .B(n58), .Y(n185) );
  INVX2M U31 ( .A(n58), .Y(n343) );
  INVX2M U32 ( .A(n65), .Y(n347) );
  INVX2M U33 ( .A(n179), .Y(n82) );
  NOR2BX2M U34 ( .AN(n177), .B(n98), .Y(n179) );
  INVX2M U35 ( .A(n101), .Y(n344) );
  INVX2M U36 ( .A(n102), .Y(n346) );
  AND2X2M U37 ( .A(n177), .B(n92), .Y(n194) );
  AND2X2M U38 ( .A(n177), .B(n90), .Y(n189) );
  BUFX2M U39 ( .A(n104), .Y(n65) );
  BUFX2M U40 ( .A(n105), .Y(n58) );
  BUFX2M U41 ( .A(n104), .Y(n66) );
  BUFX2M U42 ( .A(n105), .Y(n59) );
  NAND2X2M U43 ( .A(Address[1]), .B(n345), .Y(n101) );
  NAND2X2M U44 ( .A(Address[1]), .B(Address[0]), .Y(n102) );
  NOR2BX2M U45 ( .AN(WrEn), .B(RdEn), .Y(n177) );
  NOR2X2M U46 ( .A(Address[0]), .B(Address[1]), .Y(n104) );
  NOR2X2M U47 ( .A(n345), .B(Address[1]), .Y(n105) );
  INVX2M U48 ( .A(Address[0]), .Y(n345) );
  NAND2BX2M U49 ( .AN(WrEn), .B(RdEn), .Y(n89) );
  INVX2M U50 ( .A(WrData[0]), .Y(n350) );
  INVX2M U51 ( .A(WrData[1]), .Y(n351) );
  INVX2M U52 ( .A(WrData[2]), .Y(n352) );
  INVX2M U53 ( .A(WrData[3]), .Y(n353) );
  INVX2M U54 ( .A(WrData[4]), .Y(n354) );
  INVX2M U55 ( .A(WrData[5]), .Y(n355) );
  NOR2X2M U56 ( .A(n349), .B(n348), .Y(n92) );
  NOR2X2M U57 ( .A(n349), .B(Address[2]), .Y(n90) );
  NAND2X2M U58 ( .A(n348), .B(n349), .Y(n98) );
  NAND2X2M U59 ( .A(Address[2]), .B(n349), .Y(n96) );
  INVX2M U60 ( .A(Address[2]), .Y(n348) );
  BUFX2M U61 ( .A(n79), .Y(n72) );
  BUFX2M U62 ( .A(n78), .Y(n73) );
  BUFX2M U63 ( .A(n78), .Y(n74) );
  BUFX2M U64 ( .A(n77), .Y(n75) );
  BUFX2M U65 ( .A(n80), .Y(n70) );
  BUFX2M U66 ( .A(n81), .Y(n68) );
  BUFX2M U67 ( .A(n81), .Y(n67) );
  BUFX2M U68 ( .A(n80), .Y(n69) );
  BUFX2M U69 ( .A(n79), .Y(n71) );
  BUFX2M U70 ( .A(n77), .Y(n76) );
  MX2X2M U71 ( .A(REG0[5]), .B(WrData[5]), .S0(n342), .Y(n212) );
  MX2X2M U72 ( .A(REG0[6]), .B(WrData[6]), .S0(n342), .Y(n213) );
  MX2X2M U73 ( .A(REG1[1]), .B(WrData[1]), .S0(n49), .Y(n216) );
  MX2X2M U74 ( .A(REG1[2]), .B(WrData[2]), .S0(n49), .Y(n217) );
  MX2X2M U75 ( .A(REG1[4]), .B(WrData[4]), .S0(n49), .Y(n219) );
  MX2X2M U76 ( .A(REG1[5]), .B(WrData[5]), .S0(n49), .Y(n220) );
  MX2X2M U77 ( .A(REG1[3]), .B(WrData[3]), .S0(n49), .Y(n218) );
  INVX2M U78 ( .A(WrData[6]), .Y(n356) );
  INVX2M U79 ( .A(WrData[7]), .Y(n357) );
  INVX2M U80 ( .A(Address[3]), .Y(n349) );
  BUFX2M U81 ( .A(RST), .Y(n78) );
  BUFX2M U82 ( .A(RST), .Y(n77) );
  BUFX2M U83 ( .A(RST), .Y(n79) );
  BUFX2M U84 ( .A(RST), .Y(n81) );
  BUFX2M U85 ( .A(RST), .Y(n80) );
  OAI22X1M U86 ( .A0(n95), .A1(n96), .B0(n97), .B1(n98), .Y(n94) );
  AOI221XLM U87 ( .A0(\Reg_File[6][0] ), .A1(n344), .B0(\Reg_File[7][0] ), 
        .B1(n346), .C0(n100), .Y(n95) );
  OAI22X1M U88 ( .A0(n343), .A1(n40), .B0(n347), .B1(n48), .Y(n100) );
  OAI22X1M U89 ( .A0(n161), .A1(n96), .B0(n162), .B1(n98), .Y(n160) );
  AOI221XLM U90 ( .A0(\Reg_File[6][6] ), .A1(n344), .B0(\Reg_File[7][6] ), 
        .B1(n346), .C0(n164), .Y(n161) );
  OAI22X1M U91 ( .A0(n343), .A1(n34), .B0(n347), .B1(n42), .Y(n164) );
  OAI22X1M U92 ( .A0(n171), .A1(n96), .B0(n172), .B1(n98), .Y(n170) );
  AOI221XLM U93 ( .A0(\Reg_File[6][7] ), .A1(n344), .B0(\Reg_File[7][7] ), 
        .B1(n346), .C0(n174), .Y(n171) );
  OAI22X1M U94 ( .A0(n343), .A1(n33), .B0(n347), .B1(n41), .Y(n174) );
  OAI22X1M U95 ( .A0(n111), .A1(n96), .B0(n112), .B1(n98), .Y(n110) );
  AOI221XLM U96 ( .A0(\Reg_File[6][1] ), .A1(n344), .B0(\Reg_File[7][1] ), 
        .B1(n346), .C0(n114), .Y(n111) );
  AOI221XLM U97 ( .A0(REG1[1]), .A1(n59), .B0(n66), .B1(REG0[1]), .C0(n180), 
        .Y(n112) );
  OAI22X1M U98 ( .A0(n343), .A1(n39), .B0(n347), .B1(n47), .Y(n114) );
  OAI22X1M U99 ( .A0(n121), .A1(n96), .B0(n122), .B1(n98), .Y(n120) );
  AOI221XLM U100 ( .A0(\Reg_File[6][2] ), .A1(n344), .B0(\Reg_File[7][2] ), 
        .B1(n346), .C0(n124), .Y(n121) );
  AOI221XLM U101 ( .A0(REG1[2]), .A1(n59), .B0(n66), .B1(REG0[2]), .C0(n173), 
        .Y(n122) );
  OAI22X1M U102 ( .A0(n343), .A1(n38), .B0(n347), .B1(n46), .Y(n124) );
  OAI22X1M U103 ( .A0(n131), .A1(n96), .B0(n132), .B1(n98), .Y(n130) );
  AOI221XLM U104 ( .A0(\Reg_File[6][3] ), .A1(n344), .B0(\Reg_File[7][3] ), 
        .B1(n346), .C0(n134), .Y(n131) );
  AOI221XLM U105 ( .A0(REG1[3]), .A1(n59), .B0(n66), .B1(REG0[3]), .C0(n153), 
        .Y(n132) );
  OAI22X1M U106 ( .A0(n343), .A1(n37), .B0(n347), .B1(n45), .Y(n134) );
  OAI22X1M U107 ( .A0(n141), .A1(n96), .B0(n142), .B1(n98), .Y(n140) );
  AOI221XLM U108 ( .A0(\Reg_File[6][4] ), .A1(n344), .B0(\Reg_File[7][4] ), 
        .B1(n346), .C0(n144), .Y(n141) );
  AOI221XLM U109 ( .A0(REG1[4]), .A1(n59), .B0(n66), .B1(REG0[4]), .C0(n133), 
        .Y(n142) );
  OAI22X1M U110 ( .A0(n343), .A1(n36), .B0(n347), .B1(n44), .Y(n144) );
  OAI22X1M U111 ( .A0(n151), .A1(n96), .B0(n152), .B1(n98), .Y(n150) );
  AOI221XLM U112 ( .A0(\Reg_File[6][5] ), .A1(n344), .B0(\Reg_File[7][5] ), 
        .B1(n346), .C0(n154), .Y(n151) );
  AOI221XLM U113 ( .A0(REG1[5]), .A1(n59), .B0(REG0[5]), .B1(n66), .C0(n99), 
        .Y(n152) );
  OAI22X1M U114 ( .A0(n343), .A1(n35), .B0(n347), .B1(n43), .Y(n154) );
  OAI22X1M U115 ( .A0(n350), .A1(n191), .B0(n339), .B1(n32), .Y(n287) );
  OAI22X1M U116 ( .A0(n351), .A1(n191), .B0(n339), .B1(n31), .Y(n288) );
  OAI22X1M U117 ( .A0(n352), .A1(n191), .B0(n339), .B1(n30), .Y(n289) );
  OAI22X1M U118 ( .A0(n353), .A1(n191), .B0(n339), .B1(n29), .Y(n290) );
  OAI22X1M U119 ( .A0(n354), .A1(n191), .B0(n339), .B1(n28), .Y(n291) );
  OAI22X1M U120 ( .A0(n355), .A1(n191), .B0(n339), .B1(n27), .Y(n292) );
  OAI22X1M U121 ( .A0(n356), .A1(n191), .B0(n339), .B1(n26), .Y(n293) );
  OAI22X1M U122 ( .A0(n357), .A1(n191), .B0(n339), .B1(n25), .Y(n294) );
  OAI22X1M U123 ( .A0(n350), .A1(n192), .B0(n338), .B1(n24), .Y(n295) );
  OAI22X1M U124 ( .A0(n351), .A1(n192), .B0(n338), .B1(n23), .Y(n296) );
  OAI22X1M U125 ( .A0(n352), .A1(n192), .B0(n338), .B1(n22), .Y(n297) );
  OAI22X1M U126 ( .A0(n353), .A1(n192), .B0(n338), .B1(n21), .Y(n298) );
  OAI22X1M U127 ( .A0(n354), .A1(n192), .B0(n338), .B1(n20), .Y(n299) );
  OAI22X1M U128 ( .A0(n355), .A1(n192), .B0(n338), .B1(n19), .Y(n300) );
  OAI22X1M U129 ( .A0(n356), .A1(n192), .B0(n338), .B1(n18), .Y(n301) );
  OAI22X1M U130 ( .A0(n357), .A1(n192), .B0(n338), .B1(n17), .Y(n302) );
  OAI22X1M U131 ( .A0(n350), .A1(n196), .B0(n337), .B1(n16), .Y(n319) );
  OAI22X1M U132 ( .A0(n351), .A1(n196), .B0(n337), .B1(n15), .Y(n320) );
  OAI22X1M U133 ( .A0(n352), .A1(n196), .B0(n337), .B1(n14), .Y(n321) );
  OAI22X1M U134 ( .A0(n353), .A1(n196), .B0(n337), .B1(n13), .Y(n322) );
  OAI22X1M U135 ( .A0(n354), .A1(n196), .B0(n337), .B1(n12), .Y(n323) );
  OAI22X1M U136 ( .A0(n355), .A1(n196), .B0(n337), .B1(n11), .Y(n324) );
  OAI22X1M U137 ( .A0(n356), .A1(n196), .B0(n337), .B1(n10), .Y(n325) );
  OAI22X1M U138 ( .A0(n357), .A1(n196), .B0(n337), .B1(n9), .Y(n326) );
  OAI22X1M U139 ( .A0(n350), .A1(n197), .B0(n336), .B1(n8), .Y(n327) );
  OAI22X1M U140 ( .A0(n351), .A1(n197), .B0(n336), .B1(n7), .Y(n328) );
  OAI22X1M U141 ( .A0(n352), .A1(n197), .B0(n336), .B1(n6), .Y(n329) );
  OAI22X1M U142 ( .A0(n353), .A1(n197), .B0(n336), .B1(n5), .Y(n330) );
  OAI22X1M U143 ( .A0(n354), .A1(n197), .B0(n336), .B1(n4), .Y(n331) );
  OAI22X1M U144 ( .A0(n355), .A1(n197), .B0(n336), .B1(n3), .Y(n332) );
  OAI22X1M U145 ( .A0(n356), .A1(n197), .B0(n336), .B1(n2), .Y(n333) );
  OAI22X1M U146 ( .A0(n357), .A1(n197), .B0(n336), .B1(n1), .Y(n334) );
  OAI22X1M U147 ( .A0(n178), .A1(n350), .B0(n342), .B1(n64), .Y(n207) );
  OAI22X1M U148 ( .A0(n178), .A1(n351), .B0(n342), .B1(n63), .Y(n208) );
  OAI22X1M U149 ( .A0(n178), .A1(n352), .B0(n342), .B1(n62), .Y(n209) );
  OAI22X1M U150 ( .A0(n178), .A1(n353), .B0(n342), .B1(n61), .Y(n210) );
  OAI22X1M U151 ( .A0(n178), .A1(n354), .B0(n342), .B1(n60), .Y(n211) );
  OAI22X1M U152 ( .A0(n350), .A1(n183), .B0(n341), .B1(n48), .Y(n239) );
  OAI22X1M U153 ( .A0(n351), .A1(n183), .B0(n341), .B1(n47), .Y(n240) );
  OAI22X1M U154 ( .A0(n352), .A1(n183), .B0(n341), .B1(n46), .Y(n241) );
  OAI22X1M U155 ( .A0(n353), .A1(n183), .B0(n341), .B1(n45), .Y(n242) );
  OAI22X1M U156 ( .A0(n354), .A1(n183), .B0(n341), .B1(n44), .Y(n243) );
  OAI22X1M U157 ( .A0(n355), .A1(n183), .B0(n341), .B1(n43), .Y(n244) );
  OAI22X1M U158 ( .A0(n356), .A1(n183), .B0(n341), .B1(n42), .Y(n245) );
  OAI22X1M U159 ( .A0(n357), .A1(n183), .B0(n341), .B1(n41), .Y(n246) );
  OAI22X1M U160 ( .A0(n350), .A1(n185), .B0(n340), .B1(n40), .Y(n247) );
  OAI22X1M U161 ( .A0(n351), .A1(n185), .B0(n340), .B1(n39), .Y(n248) );
  OAI22X1M U162 ( .A0(n352), .A1(n185), .B0(n340), .B1(n38), .Y(n249) );
  OAI22X1M U163 ( .A0(n353), .A1(n185), .B0(n340), .B1(n37), .Y(n250) );
  OAI22X1M U164 ( .A0(n354), .A1(n185), .B0(n340), .B1(n36), .Y(n251) );
  OAI22X1M U165 ( .A0(n355), .A1(n185), .B0(n340), .B1(n35), .Y(n252) );
  OAI22X1M U166 ( .A0(n356), .A1(n185), .B0(n340), .B1(n34), .Y(n253) );
  OAI22X1M U167 ( .A0(n357), .A1(n185), .B0(n340), .B1(n33), .Y(n254) );
  OAI2BB2X1M U168 ( .B0(n88), .B1(n89), .A0N(RdData[0]), .A1N(n89), .Y(n198)
         );
  AOI221XLM U169 ( .A0(n90), .A1(n91), .B0(n92), .B1(n93), .C0(n94), .Y(n88)
         );
  OAI221X1M U170 ( .A0(n101), .A1(n32), .B0(n102), .B1(n24), .C0(n106), .Y(n91) );
  OAI221X1M U171 ( .A0(n101), .A1(n16), .B0(n102), .B1(n8), .C0(n103), .Y(n93)
         );
  OAI2BB2X1M U172 ( .B0(n107), .B1(n89), .A0N(RdData[1]), .A1N(n89), .Y(n199)
         );
  AOI221XLM U173 ( .A0(n90), .A1(n108), .B0(n92), .B1(n109), .C0(n110), .Y(
        n107) );
  OAI221X1M U174 ( .A0(n101), .A1(n31), .B0(n102), .B1(n23), .C0(n116), .Y(
        n108) );
  OAI221X1M U175 ( .A0(n101), .A1(n15), .B0(n102), .B1(n7), .C0(n115), .Y(n109) );
  OAI2BB2X1M U176 ( .B0(n117), .B1(n89), .A0N(RdData[2]), .A1N(n89), .Y(n200)
         );
  AOI221XLM U177 ( .A0(n90), .A1(n118), .B0(n92), .B1(n119), .C0(n120), .Y(
        n117) );
  OAI221X1M U178 ( .A0(n101), .A1(n30), .B0(n102), .B1(n22), .C0(n126), .Y(
        n118) );
  OAI221X1M U179 ( .A0(n101), .A1(n14), .B0(n102), .B1(n6), .C0(n125), .Y(n119) );
  OAI2BB2X1M U180 ( .B0(n127), .B1(n89), .A0N(RdData[3]), .A1N(n89), .Y(n201)
         );
  AOI221XLM U181 ( .A0(n90), .A1(n128), .B0(n92), .B1(n129), .C0(n130), .Y(
        n127) );
  OAI221X1M U182 ( .A0(n101), .A1(n29), .B0(n102), .B1(n21), .C0(n136), .Y(
        n128) );
  OAI221X1M U183 ( .A0(n101), .A1(n13), .B0(n102), .B1(n5), .C0(n135), .Y(n129) );
  OAI2BB2X1M U184 ( .B0(n137), .B1(n89), .A0N(RdData[4]), .A1N(n89), .Y(n202)
         );
  AOI221XLM U185 ( .A0(n90), .A1(n138), .B0(n92), .B1(n139), .C0(n140), .Y(
        n137) );
  OAI221X1M U186 ( .A0(n101), .A1(n28), .B0(n102), .B1(n20), .C0(n146), .Y(
        n138) );
  OAI221X1M U187 ( .A0(n101), .A1(n12), .B0(n102), .B1(n4), .C0(n145), .Y(n139) );
  OAI2BB2X1M U188 ( .B0(n147), .B1(n89), .A0N(RdData[5]), .A1N(n89), .Y(n203)
         );
  AOI221XLM U189 ( .A0(n90), .A1(n148), .B0(n92), .B1(n149), .C0(n150), .Y(
        n147) );
  OAI221X1M U190 ( .A0(n101), .A1(n27), .B0(n102), .B1(n19), .C0(n156), .Y(
        n148) );
  OAI221X1M U191 ( .A0(n101), .A1(n11), .B0(n102), .B1(n3), .C0(n155), .Y(n149) );
  OAI2BB2X1M U192 ( .B0(n157), .B1(n89), .A0N(RdData[6]), .A1N(n89), .Y(n204)
         );
  AOI221XLM U193 ( .A0(n90), .A1(n158), .B0(n92), .B1(n159), .C0(n160), .Y(
        n157) );
  OAI221X1M U194 ( .A0(n101), .A1(n26), .B0(n102), .B1(n18), .C0(n166), .Y(
        n158) );
  OAI221X1M U195 ( .A0(n101), .A1(n10), .B0(n102), .B1(n2), .C0(n165), .Y(n159) );
  OAI2BB2X1M U196 ( .B0(n167), .B1(n89), .A0N(RdData[7]), .A1N(n89), .Y(n205)
         );
  AOI221XLM U197 ( .A0(n90), .A1(n168), .B0(n92), .B1(n169), .C0(n170), .Y(
        n167) );
  OAI221X1M U198 ( .A0(n101), .A1(n25), .B0(n102), .B1(n17), .C0(n176), .Y(
        n168) );
  OAI221X1M U199 ( .A0(n101), .A1(n9), .B0(n102), .B1(n1), .C0(n175), .Y(n169)
         );
  OAI2BB2X1M U200 ( .B0(n350), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][0] ), 
        .Y(n255) );
  OAI2BB2X1M U201 ( .B0(n351), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][1] ), 
        .Y(n256) );
  OAI2BB2X1M U202 ( .B0(n352), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][2] ), 
        .Y(n257) );
  OAI2BB2X1M U203 ( .B0(n353), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][3] ), 
        .Y(n258) );
  OAI2BB2X1M U204 ( .B0(n354), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][4] ), 
        .Y(n259) );
  OAI2BB2X1M U205 ( .B0(n355), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][5] ), 
        .Y(n260) );
  OAI2BB2X1M U206 ( .B0(n356), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][6] ), 
        .Y(n261) );
  OAI2BB2X1M U207 ( .B0(n357), .B1(n186), .A0N(n186), .A1N(\Reg_File[6][7] ), 
        .Y(n262) );
  OAI2BB2X1M U208 ( .B0(n350), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][0] ), 
        .Y(n263) );
  OAI2BB2X1M U209 ( .B0(n351), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][1] ), 
        .Y(n264) );
  OAI2BB2X1M U210 ( .B0(n352), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][2] ), 
        .Y(n265) );
  OAI2BB2X1M U211 ( .B0(n353), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][3] ), 
        .Y(n266) );
  OAI2BB2X1M U212 ( .B0(n354), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][4] ), 
        .Y(n267) );
  OAI2BB2X1M U213 ( .B0(n355), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][5] ), 
        .Y(n268) );
  OAI2BB2X1M U214 ( .B0(n356), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][6] ), 
        .Y(n269) );
  OAI2BB2X1M U215 ( .B0(n357), .B1(n187), .A0N(n187), .A1N(\Reg_File[7][7] ), 
        .Y(n270) );
  OAI2BB2X1M U216 ( .B0(n351), .B1(n181), .A0N(n181), .A1N(REG2[1]), .Y(n224)
         );
  OAI2BB2X1M U217 ( .B0(n352), .B1(n181), .A0N(n181), .A1N(REG2[2]), .Y(n225)
         );
  OAI2BB2X1M U218 ( .B0(n353), .B1(n181), .A0N(n181), .A1N(REG2[3]), .Y(n226)
         );
  OAI2BB2X1M U219 ( .B0(n354), .B1(n181), .A0N(n181), .A1N(REG2[4]), .Y(n227)
         );
  OAI2BB2X1M U220 ( .B0(n356), .B1(n181), .A0N(n181), .A1N(REG2[6]), .Y(n229)
         );
  OAI2BB2X1M U221 ( .B0(n357), .B1(n181), .A0N(n181), .A1N(REG2[7]), .Y(n230)
         );
  OAI2BB2X1M U222 ( .B0(n350), .B1(n182), .A0N(n182), .A1N(REG3[0]), .Y(n231)
         );
  OAI2BB2X1M U223 ( .B0(n351), .B1(n182), .A0N(n182), .A1N(REG3[1]), .Y(n232)
         );
  OAI2BB2X1M U224 ( .B0(n352), .B1(n182), .A0N(n182), .A1N(REG3[2]), .Y(n233)
         );
  OAI2BB2X1M U225 ( .B0(n353), .B1(n182), .A0N(n182), .A1N(REG3[3]), .Y(n234)
         );
  OAI2BB2X1M U226 ( .B0(n354), .B1(n182), .A0N(n182), .A1N(REG3[4]), .Y(n235)
         );
  OAI2BB2X1M U227 ( .B0(n356), .B1(n182), .A0N(n182), .A1N(REG3[6]), .Y(n237)
         );
  OAI2BB2X1M U228 ( .B0(n357), .B1(n182), .A0N(n182), .A1N(REG3[7]), .Y(n238)
         );
  OAI2BB2X1M U229 ( .B0(n350), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][0] ), 
        .Y(n271) );
  OAI2BB2X1M U230 ( .B0(n351), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][1] ), 
        .Y(n272) );
  OAI2BB2X1M U231 ( .B0(n352), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][2] ), 
        .Y(n273) );
  OAI2BB2X1M U232 ( .B0(n353), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][3] ), 
        .Y(n274) );
  OAI2BB2X1M U233 ( .B0(n354), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][4] ), 
        .Y(n275) );
  OAI2BB2X1M U234 ( .B0(n355), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][5] ), 
        .Y(n276) );
  OAI2BB2X1M U235 ( .B0(n356), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][6] ), 
        .Y(n277) );
  OAI2BB2X1M U236 ( .B0(n357), .B1(n188), .A0N(n188), .A1N(\Reg_File[8][7] ), 
        .Y(n278) );
  OAI2BB2X1M U237 ( .B0(n350), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][0] ), 
        .Y(n279) );
  OAI2BB2X1M U238 ( .B0(n351), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][1] ), 
        .Y(n280) );
  OAI2BB2X1M U239 ( .B0(n352), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][2] ), 
        .Y(n281) );
  OAI2BB2X1M U240 ( .B0(n353), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][3] ), 
        .Y(n282) );
  OAI2BB2X1M U241 ( .B0(n354), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][4] ), 
        .Y(n283) );
  OAI2BB2X1M U242 ( .B0(n355), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][5] ), 
        .Y(n284) );
  OAI2BB2X1M U243 ( .B0(n356), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][6] ), 
        .Y(n285) );
  OAI2BB2X1M U244 ( .B0(n357), .B1(n190), .A0N(n190), .A1N(\Reg_File[9][7] ), 
        .Y(n286) );
  OAI2BB2X1M U245 ( .B0(n350), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][0] ), 
        .Y(n303) );
  OAI2BB2X1M U246 ( .B0(n351), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][1] ), 
        .Y(n304) );
  OAI2BB2X1M U247 ( .B0(n352), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][2] ), 
        .Y(n305) );
  OAI2BB2X1M U248 ( .B0(n353), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][3] ), 
        .Y(n306) );
  OAI2BB2X1M U249 ( .B0(n354), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][4] ), 
        .Y(n307) );
  OAI2BB2X1M U250 ( .B0(n355), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][5] ), 
        .Y(n308) );
  OAI2BB2X1M U251 ( .B0(n356), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][6] ), 
        .Y(n309) );
  OAI2BB2X1M U252 ( .B0(n357), .B1(n193), .A0N(n193), .A1N(\Reg_File[12][7] ), 
        .Y(n310) );
  OAI2BB2X1M U253 ( .B0(n350), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][0] ), 
        .Y(n311) );
  OAI2BB2X1M U254 ( .B0(n351), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][1] ), 
        .Y(n312) );
  OAI2BB2X1M U255 ( .B0(n352), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][2] ), 
        .Y(n313) );
  OAI2BB2X1M U256 ( .B0(n353), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][3] ), 
        .Y(n314) );
  OAI2BB2X1M U257 ( .B0(n354), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][4] ), 
        .Y(n315) );
  OAI2BB2X1M U258 ( .B0(n355), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][5] ), 
        .Y(n316) );
  OAI2BB2X1M U259 ( .B0(n356), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][6] ), 
        .Y(n317) );
  OAI2BB2X1M U260 ( .B0(n357), .B1(n195), .A0N(n195), .A1N(\Reg_File[13][7] ), 
        .Y(n318) );
  OAI2BB2X1M U261 ( .B0(n350), .B1(n181), .A0N(n181), .A1N(REG2[0]), .Y(n223)
         );
  OAI2BB2X1M U262 ( .B0(n355), .B1(n181), .A0N(n181), .A1N(REG2[5]), .Y(n228)
         );
  OAI2BB2X1M U263 ( .B0(n355), .B1(n182), .A0N(n182), .A1N(REG3[5]), .Y(n236)
         );
  AO22X1M U264 ( .A0(REG2[1]), .A1(n344), .B0(REG3[1]), .B1(n346), .Y(n180) );
  AO22X1M U265 ( .A0(REG2[2]), .A1(n344), .B0(REG3[2]), .B1(n346), .Y(n173) );
  AO22X1M U266 ( .A0(REG2[3]), .A1(n344), .B0(REG3[3]), .B1(n346), .Y(n153) );
  AO22X1M U267 ( .A0(REG2[4]), .A1(n344), .B0(REG3[4]), .B1(n346), .Y(n133) );
  AO22X1M U268 ( .A0(REG2[5]), .A1(n344), .B0(REG3[5]), .B1(n346), .Y(n99) );
  AO22X1M U269 ( .A0(REG2[0]), .A1(n344), .B0(REG3[0]), .B1(n346), .Y(n335) );
  AO22X1M U270 ( .A0(REG2[6]), .A1(n344), .B0(REG3[6]), .B1(n346), .Y(n85) );
  AO22X1M U271 ( .A0(REG2[7]), .A1(n344), .B0(REG3[7]), .B1(n346), .Y(n83) );
  AOI22X1M U272 ( .A0(\Reg_File[12][0] ), .A1(n66), .B0(\Reg_File[13][0] ), 
        .B1(n59), .Y(n103) );
  AOI22X1M U273 ( .A0(\Reg_File[8][0] ), .A1(n66), .B0(\Reg_File[9][0] ), .B1(
        n59), .Y(n106) );
  AOI22X1M U274 ( .A0(\Reg_File[12][1] ), .A1(n66), .B0(\Reg_File[13][1] ), 
        .B1(n59), .Y(n115) );
  AOI22X1M U275 ( .A0(\Reg_File[8][1] ), .A1(n66), .B0(\Reg_File[9][1] ), .B1(
        n59), .Y(n116) );
  AOI22X1M U276 ( .A0(\Reg_File[12][2] ), .A1(n66), .B0(\Reg_File[13][2] ), 
        .B1(n59), .Y(n125) );
  AOI22X1M U277 ( .A0(\Reg_File[8][2] ), .A1(n66), .B0(\Reg_File[9][2] ), .B1(
        n59), .Y(n126) );
  AOI22X1M U278 ( .A0(\Reg_File[12][3] ), .A1(n66), .B0(\Reg_File[13][3] ), 
        .B1(n59), .Y(n135) );
  AOI22X1M U279 ( .A0(\Reg_File[8][3] ), .A1(n66), .B0(\Reg_File[9][3] ), .B1(
        n59), .Y(n136) );
  AOI22X1M U280 ( .A0(\Reg_File[12][4] ), .A1(n66), .B0(\Reg_File[13][4] ), 
        .B1(n59), .Y(n145) );
  AOI22X1M U281 ( .A0(\Reg_File[8][4] ), .A1(n66), .B0(\Reg_File[9][4] ), .B1(
        n59), .Y(n146) );
  AOI22X1M U282 ( .A0(\Reg_File[12][5] ), .A1(n66), .B0(\Reg_File[13][5] ), 
        .B1(n59), .Y(n155) );
  AOI22X1M U283 ( .A0(\Reg_File[8][5] ), .A1(n66), .B0(\Reg_File[9][5] ), .B1(
        n59), .Y(n156) );
  AOI22X1M U284 ( .A0(\Reg_File[12][6] ), .A1(n66), .B0(\Reg_File[13][6] ), 
        .B1(n59), .Y(n165) );
  AOI22X1M U285 ( .A0(\Reg_File[8][6] ), .A1(n66), .B0(\Reg_File[9][6] ), .B1(
        n59), .Y(n166) );
  AOI22X1M U286 ( .A0(\Reg_File[12][7] ), .A1(n66), .B0(\Reg_File[13][7] ), 
        .B1(n59), .Y(n175) );
  AOI22X1M U287 ( .A0(\Reg_File[8][7] ), .A1(n65), .B0(\Reg_File[9][7] ), .B1(
        n58), .Y(n176) );
  OAI2BB1X2M U288 ( .A0N(RdData_VLD), .A1N(n177), .B0(n89), .Y(n206) );
  MX2XLM U289 ( .A(REG0[7]), .B(WrData[7]), .S0(n342), .Y(n214) );
  MX2XLM U290 ( .A(REG1[0]), .B(WrData[0]), .S0(n49), .Y(n215) );
  AOI221XLM U291 ( .A0(REG1[0]), .A1(n59), .B0(n66), .B1(REG0[0]), .C0(n335), 
        .Y(n97) );
  MX2XLM U292 ( .A(REG1[6]), .B(WrData[6]), .S0(n49), .Y(n221) );
  AOI221XLM U293 ( .A0(REG1[6]), .A1(n59), .B0(REG0[6]), .B1(n66), .C0(n85), 
        .Y(n162) );
  MX2XLM U294 ( .A(REG1[7]), .B(WrData[7]), .S0(n49), .Y(n222) );
  AOI221XLM U295 ( .A0(REG1[7]), .A1(n59), .B0(REG0[7]), .B1(n66), .C0(n83), 
        .Y(n172) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFX2M U2_1 ( .A(A[1]), .B(n8), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n4), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n6), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  INVX2M U1 ( .A(B[3]), .Y(n6) );
  INVXLM U2 ( .A(B[1]), .Y(n8) );
  NAND2X2M U3 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX2M U4 ( .A(A[0]), .Y(n1) );
  XNOR2X2M U5 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVXLM U6 ( .A(B[6]), .Y(n3) );
  INVXLM U7 ( .A(B[7]), .Y(n2) );
  INVXLM U8 ( .A(B[2]), .Y(n7) );
  INVXLM U9 ( .A(B[4]), .Y(n5) );
  INVXLM U10 ( .A(B[0]), .Y(n9) );
  INVX2M U11 ( .A(B[5]), .Y(n4) );
  CLKINVX1M U12 ( .A(carry[8]), .Y(DIFF[8]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;

  wire   [8:1] carry;

  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(carry[1]), .CO(carry[2]), .S(SUM[1])
         );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_0 ( .A(A[0]), .B(B[0]), .CI(1'b0), .CO(carry[1]), .S(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n1, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27;

  AOI21BX2M U2 ( .A0(n18), .A1(A[12]), .B0N(n19), .Y(n1) );
  XNOR2X2M U3 ( .A(B[13]), .B(n1), .Y(SUM[13]) );
  NAND2X2M U4 ( .A(A[7]), .B(B[7]), .Y(n15) );
  XNOR2X2M U5 ( .A(A[7]), .B(n8), .Y(SUM[7]) );
  INVX2M U6 ( .A(B[7]), .Y(n8) );
  INVX2M U7 ( .A(A[6]), .Y(n9) );
  INVX2M U8 ( .A(n9), .Y(SUM[6]) );
  BUFX2M U9 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U10 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U11 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U12 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U13 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U14 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U15 ( .A(n10), .B(n11), .Y(SUM[9]) );
  NOR2X1M U16 ( .A(n12), .B(n13), .Y(n11) );
  CLKXOR2X2M U17 ( .A(n14), .B(n15), .Y(SUM[8]) );
  NAND2BX1M U18 ( .AN(n16), .B(n17), .Y(n14) );
  OAI21X1M U19 ( .A0(A[12]), .A1(n18), .B0(B[12]), .Y(n19) );
  XOR3XLM U20 ( .A(B[12]), .B(A[12]), .C(n18), .Y(SUM[12]) );
  OAI21BX1M U21 ( .A0(n20), .A1(n21), .B0N(n22), .Y(n18) );
  XNOR2X1M U22 ( .A(n21), .B(n23), .Y(SUM[11]) );
  NOR2X1M U23 ( .A(n22), .B(n20), .Y(n23) );
  NOR2X1M U24 ( .A(B[11]), .B(A[11]), .Y(n20) );
  AND2X1M U25 ( .A(B[11]), .B(A[11]), .Y(n22) );
  OA21X1M U26 ( .A0(n24), .A1(n25), .B0(n26), .Y(n21) );
  CLKXOR2X2M U27 ( .A(n27), .B(n25), .Y(SUM[10]) );
  AOI2BB1X1M U28 ( .A0N(n10), .A1N(n13), .B0(n12), .Y(n25) );
  AND2X1M U29 ( .A(B[9]), .B(A[9]), .Y(n12) );
  NOR2X1M U30 ( .A(B[9]), .B(A[9]), .Y(n13) );
  OA21X1M U31 ( .A0(n15), .A1(n16), .B0(n17), .Y(n10) );
  CLKNAND2X2M U32 ( .A(B[8]), .B(A[8]), .Y(n17) );
  NOR2X1M U33 ( .A(B[8]), .B(A[8]), .Y(n16) );
  NAND2BX1M U34 ( .AN(n24), .B(n26), .Y(n27) );
  CLKNAND2X2M U35 ( .A(B[10]), .B(A[10]), .Y(n26) );
  NOR2X1M U36 ( .A(B[10]), .B(A[10]), .Y(n24) );
endmodule


module ALU_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39;

  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n14, n11, n13, n16, n15, n12, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n8), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n5), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n6), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n9), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n4), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n3), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n7), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  AND2X2M U2 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  INVXLM U10 ( .A(B[1]), .Y(n30) );
  INVXLM U11 ( .A(A[5]), .Y(n34) );
  AND2X2M U12 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n11) );
  CLKXOR2X2M U13 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U14 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  AND2X2M U15 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n12) );
  CLKXOR2X2M U16 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  XNOR2X2M U17 ( .A(\CARRYB[7][0] ), .B(n17), .Y(\A1[6] ) );
  INVX2M U18 ( .A(\SUMB[7][1] ), .Y(n17) );
  AND2X2M U19 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n13) );
  CLKXOR2X2M U20 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  AND2X2M U21 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n14) );
  CLKXOR2X2M U22 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U23 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  INVX2M U24 ( .A(\ab[0][5] ), .Y(n21) );
  INVX2M U25 ( .A(\ab[0][7] ), .Y(n23) );
  INVX2M U26 ( .A(\ab[0][6] ), .Y(n22) );
  INVX2M U27 ( .A(\ab[0][4] ), .Y(n20) );
  INVX2M U28 ( .A(\ab[0][3] ), .Y(n19) );
  XNOR2X2M U29 ( .A(\ab[1][6] ), .B(n23), .Y(\SUMB[1][6] ) );
  XNOR2X2M U30 ( .A(\ab[1][4] ), .B(n21), .Y(\SUMB[1][4] ) );
  XNOR2X2M U31 ( .A(\ab[1][2] ), .B(n19), .Y(\SUMB[1][2] ) );
  XNOR2X2M U32 ( .A(\ab[1][5] ), .B(n22), .Y(\SUMB[1][5] ) );
  AND2X2M U33 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n15) );
  AND2X2M U34 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n16) );
  INVX2M U35 ( .A(\ab[0][2] ), .Y(n18) );
  XNOR2X2M U36 ( .A(\ab[1][1] ), .B(n18), .Y(\SUMB[1][1] ) );
  INVX2M U37 ( .A(B[3]), .Y(n28) );
  XNOR2X2M U38 ( .A(\ab[1][3] ), .B(n20), .Y(\SUMB[1][3] ) );
  INVX2M U39 ( .A(A[2]), .Y(n37) );
  INVX2M U40 ( .A(A[3]), .Y(n36) );
  INVX2M U41 ( .A(A[4]), .Y(n35) );
  INVX2M U42 ( .A(A[6]), .Y(n33) );
  CLKXOR2X2M U43 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  INVX2M U44 ( .A(A[1]), .Y(n38) );
  INVX2M U45 ( .A(A[0]), .Y(n39) );
  INVXLM U46 ( .A(B[6]), .Y(n25) );
  INVX2M U47 ( .A(B[2]), .Y(n29) );
  INVXLM U48 ( .A(B[4]), .Y(n27) );
  INVX2M U49 ( .A(B[5]), .Y(n26) );
  INVXLM U50 ( .A(A[7]), .Y(n32) );
  INVXLM U51 ( .A(B[0]), .Y(n31) );
  INVXLM U52 ( .A(B[7]), .Y(n24) );
  NOR2X1M U54 ( .A(n32), .B(n24), .Y(\ab[7][7] ) );
  NOR2X1M U55 ( .A(n32), .B(n25), .Y(\ab[7][6] ) );
  NOR2X1M U56 ( .A(n32), .B(n26), .Y(\ab[7][5] ) );
  NOR2X1M U57 ( .A(n32), .B(n27), .Y(\ab[7][4] ) );
  NOR2X1M U58 ( .A(n32), .B(n28), .Y(\ab[7][3] ) );
  NOR2X1M U59 ( .A(n32), .B(n29), .Y(\ab[7][2] ) );
  NOR2X1M U60 ( .A(n32), .B(n30), .Y(\ab[7][1] ) );
  NOR2X1M U61 ( .A(n32), .B(n31), .Y(\ab[7][0] ) );
  NOR2X1M U62 ( .A(n24), .B(n33), .Y(\ab[6][7] ) );
  NOR2X1M U63 ( .A(n25), .B(n33), .Y(\ab[6][6] ) );
  NOR2X1M U64 ( .A(n26), .B(n33), .Y(\ab[6][5] ) );
  NOR2X1M U65 ( .A(n27), .B(n33), .Y(\ab[6][4] ) );
  NOR2X1M U66 ( .A(n28), .B(n33), .Y(\ab[6][3] ) );
  NOR2X1M U67 ( .A(n29), .B(n33), .Y(\ab[6][2] ) );
  NOR2X1M U68 ( .A(n30), .B(n33), .Y(\ab[6][1] ) );
  NOR2X1M U69 ( .A(n31), .B(n33), .Y(\ab[6][0] ) );
  NOR2X1M U70 ( .A(n24), .B(n34), .Y(\ab[5][7] ) );
  NOR2X1M U71 ( .A(n25), .B(n34), .Y(\ab[5][6] ) );
  NOR2X1M U72 ( .A(n26), .B(n34), .Y(\ab[5][5] ) );
  NOR2X1M U73 ( .A(n27), .B(n34), .Y(\ab[5][4] ) );
  NOR2X1M U74 ( .A(n28), .B(n34), .Y(\ab[5][3] ) );
  NOR2X1M U75 ( .A(n29), .B(n34), .Y(\ab[5][2] ) );
  NOR2X1M U76 ( .A(n30), .B(n34), .Y(\ab[5][1] ) );
  NOR2X1M U77 ( .A(n31), .B(n34), .Y(\ab[5][0] ) );
  NOR2X1M U78 ( .A(n24), .B(n35), .Y(\ab[4][7] ) );
  NOR2X1M U79 ( .A(n25), .B(n35), .Y(\ab[4][6] ) );
  NOR2X1M U80 ( .A(n26), .B(n35), .Y(\ab[4][5] ) );
  NOR2X1M U81 ( .A(n27), .B(n35), .Y(\ab[4][4] ) );
  NOR2X1M U82 ( .A(n28), .B(n35), .Y(\ab[4][3] ) );
  NOR2X1M U83 ( .A(n29), .B(n35), .Y(\ab[4][2] ) );
  NOR2X1M U84 ( .A(n30), .B(n35), .Y(\ab[4][1] ) );
  NOR2X1M U85 ( .A(n31), .B(n35), .Y(\ab[4][0] ) );
  NOR2X1M U86 ( .A(n24), .B(n36), .Y(\ab[3][7] ) );
  NOR2X1M U87 ( .A(n25), .B(n36), .Y(\ab[3][6] ) );
  NOR2X1M U88 ( .A(n26), .B(n36), .Y(\ab[3][5] ) );
  NOR2X1M U89 ( .A(n27), .B(n36), .Y(\ab[3][4] ) );
  NOR2X1M U90 ( .A(n28), .B(n36), .Y(\ab[3][3] ) );
  NOR2X1M U91 ( .A(n29), .B(n36), .Y(\ab[3][2] ) );
  NOR2X1M U92 ( .A(n30), .B(n36), .Y(\ab[3][1] ) );
  NOR2X1M U93 ( .A(n31), .B(n36), .Y(\ab[3][0] ) );
  NOR2X1M U94 ( .A(n24), .B(n37), .Y(\ab[2][7] ) );
  NOR2X1M U95 ( .A(n25), .B(n37), .Y(\ab[2][6] ) );
  NOR2X1M U96 ( .A(n26), .B(n37), .Y(\ab[2][5] ) );
  NOR2X1M U97 ( .A(n27), .B(n37), .Y(\ab[2][4] ) );
  NOR2X1M U98 ( .A(n28), .B(n37), .Y(\ab[2][3] ) );
  NOR2X1M U99 ( .A(n29), .B(n37), .Y(\ab[2][2] ) );
  NOR2X1M U100 ( .A(n30), .B(n37), .Y(\ab[2][1] ) );
  NOR2X1M U101 ( .A(n31), .B(n37), .Y(\ab[2][0] ) );
  NOR2X1M U102 ( .A(n24), .B(n38), .Y(\ab[1][7] ) );
  NOR2X1M U103 ( .A(n25), .B(n38), .Y(\ab[1][6] ) );
  NOR2X1M U104 ( .A(n26), .B(n38), .Y(\ab[1][5] ) );
  NOR2X1M U105 ( .A(n27), .B(n38), .Y(\ab[1][4] ) );
  NOR2X1M U106 ( .A(n28), .B(n38), .Y(\ab[1][3] ) );
  NOR2X1M U107 ( .A(n29), .B(n38), .Y(\ab[1][2] ) );
  NOR2X1M U108 ( .A(n30), .B(n38), .Y(\ab[1][1] ) );
  NOR2X1M U109 ( .A(n31), .B(n38), .Y(\ab[1][0] ) );
  NOR2X1M U110 ( .A(n24), .B(n39), .Y(\ab[0][7] ) );
  NOR2X1M U111 ( .A(n25), .B(n39), .Y(\ab[0][6] ) );
  NOR2X1M U112 ( .A(n26), .B(n39), .Y(\ab[0][5] ) );
  NOR2X1M U113 ( .A(n27), .B(n39), .Y(\ab[0][4] ) );
  NOR2X1M U114 ( .A(n28), .B(n39), .Y(\ab[0][3] ) );
  NOR2X1M U115 ( .A(n29), .B(n39), .Y(\ab[0][2] ) );
  NOR2X1M U116 ( .A(n30), .B(n39), .Y(\ab[0][1] ) );
  NOR2X1M U117 ( .A(n31), .B(n39), .Y(PRODUCT[0]) );
endmodule


module ALU_DW_div_uns_1 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] , \u_div/SumTmp[1][3] ,
         \u_div/SumTmp[1][4] , \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] ,
         \u_div/SumTmp[2][1] , \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] ,
         \u_div/SumTmp[2][4] , \u_div/SumTmp[2][5] , \u_div/SumTmp[3][1] ,
         \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] ,
         \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] ,
         \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] ,
         \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
         \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] ,
         \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] ,
         \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] ,
         \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] ,
         \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] ,
         \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] ,
         \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] ,
         \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] ,
         \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] ,
         \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] ,
         \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] ,
         \u_div/PartRem[1][1] , \u_div/PartRem[1][3] , \u_div/PartRem[1][4] ,
         \u_div/PartRem[1][5] , \u_div/PartRem[1][6] , \u_div/PartRem[1][7] ,
         \u_div/PartRem[2][1] , \u_div/PartRem[2][2] , \u_div/PartRem[2][3] ,
         \u_div/PartRem[2][4] , \u_div/PartRem[2][5] , \u_div/PartRem[2][6] ,
         \u_div/PartRem[3][2] , \u_div/PartRem[4][1] , \u_div/PartRem[5][1] ,
         \u_div/PartRem[6][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n39, n40,
         n41, n42, n43, n44, n45, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104;
  wire   [7:0] \u_div/BInv ;

  ADDFHX8M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), 
        .S(\u_div/SumTmp[4][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/BInv [1]), .B(
        \u_div/PartRem[4][1] ), .CI(\u_div/CryTmp[3][1] ), .CO(
        \u_div/CryTmp[3][2] ), .S(\u_div/SumTmp[3][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), 
        .S(\u_div/SumTmp[1][6] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), 
        .S(\u_div/SumTmp[1][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n59), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n33), 
        .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), 
        .S(\u_div/SumTmp[1][1] ) );
  ADDFHX1M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n59), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFHX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(
        \u_div/BInv [5]), .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_6_1  ( .A(n60), .B(\u_div/BInv [1]), .CI(
        \u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_4_2  ( .A(n42), .B(n33), .CI(
        \u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_1  ( .A(n54), .B(\u_div/BInv [1]), .CI(
        \u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n33), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_4  ( .A(n45), .B(\u_div/BInv [4]), .CI(
        \u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_3  ( .A(n44), .B(n59), .CI(
        \u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_2  ( .A(n1), .B(n33), .CI(
        \u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_3_4  ( .A(n49), .B(\u_div/BInv [4]), .CI(
        \u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(
        \u_div/BInv [7]), .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFHX4M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/CryTmp[5][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/PartRem[6][1] ), .CO(\u_div/CryTmp[5][2] ), .S(\u_div/SumTmp[5][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_3_3  ( .A(n48), .B(n59), .CI(
        \u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFHX1M \u_div/u_fa_PartRem_0_6_0  ( .A(a[6]), .B(\u_div/BInv [0]), .CI(
        1'b1), .CO(\u_div/CryTmp[6][1] ), .S(\u_div/SumTmp[6][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_0  ( .A(a[5]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[5][1] ), .S(\u_div/SumTmp[5][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_0  ( .A(a[0]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[0][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_0  ( .A(a[4]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[4][1] ), .S(\u_div/SumTmp[4][0] ) );
  NAND3X4M U1 ( .A(n18), .B(n17), .C(n16), .Y(\u_div/CryTmp[3][3] ) );
  CLKINVX12M U2 ( .A(n92), .Y(n102) );
  NAND2X3M U3 ( .A(\u_div/CryTmp[4][3] ), .B(n59), .Y(n9) );
  CLKINVX4M U4 ( .A(n100), .Y(quotient[4]) );
  CLKNAND2X2M U5 ( .A(n47), .B(n33), .Y(n18) );
  NAND2X3M U6 ( .A(\u_div/CryTmp[4][3] ), .B(n50), .Y(n8) );
  XNOR3XLM U7 ( .A(\u_div/CryTmp[1][5] ), .B(\u_div/PartRem[2][5] ), .C(
        \u_div/BInv [5]), .Y(n3) );
  NAND2X2M U8 ( .A(\u_div/CryTmp[3][2] ), .B(n47), .Y(n16) );
  NAND2X3M U9 ( .A(n21), .B(n40), .Y(n27) );
  NAND2X4M U10 ( .A(\u_div/CryTmp[5][2] ), .B(n33), .Y(n28) );
  NAND2X6M U11 ( .A(n20), .B(n59), .Y(n78) );
  CLKINVX8M U12 ( .A(n85), .Y(n20) );
  NAND2X4M U13 ( .A(\u_div/CryTmp[6][2] ), .B(n72), .Y(n71) );
  INVX4M U14 ( .A(\u_div/CryTmp[7][1] ), .Y(n98) );
  CLKNAND2X4M U15 ( .A(b[0]), .B(n53), .Y(\u_div/CryTmp[7][1] ) );
  INVX8M U16 ( .A(b[3]), .Y(n59) );
  NAND2X4M U17 ( .A(\u_div/CryTmp[2][5] ), .B(\u_div/BInv [5]), .Y(n13) );
  NAND2X4M U18 ( .A(\u_div/CryTmp[2][5] ), .B(n39), .Y(n12) );
  NAND2X8M U19 ( .A(n101), .B(n102), .Y(n85) );
  NAND2X6M U20 ( .A(n40), .B(n33), .Y(n29) );
  CLKINVX8M U21 ( .A(n25), .Y(n40) );
  BUFX4M U22 ( .A(n2), .Y(n1) );
  NAND2X4M U23 ( .A(n23), .B(n24), .Y(n25) );
  NAND2X2M U24 ( .A(n41), .B(quotient[6]), .Y(n24) );
  NAND3X4M U25 ( .A(n31), .B(n30), .C(n32), .Y(\u_div/CryTmp[1][6] ) );
  MX2X3M U26 ( .A(n42), .B(\u_div/SumTmp[4][2] ), .S0(quotient[4]), .Y(n48) );
  MXI2X4M U27 ( .A(n43), .B(n37), .S0(n99), .Y(n42) );
  NAND2X3M U28 ( .A(\u_div/CryTmp[3][2] ), .B(n33), .Y(n17) );
  INVXLM U29 ( .A(n99), .Y(quotient[5]) );
  CLKINVX8M U30 ( .A(n66), .Y(\u_div/PartRem[2][2] ) );
  INVX3M U31 ( .A(quotient[6]), .Y(n22) );
  CLKNAND2X2M U32 ( .A(\u_div/CryTmp[1][5] ), .B(\u_div/BInv [5]), .Y(n31) );
  MXI2XLM U33 ( .A(n90), .B(n67), .S0(n104), .Y(n2) );
  INVX8M U34 ( .A(n67), .Y(\u_div/PartRem[2][1] ) );
  XOR2XLM U35 ( .A(n59), .B(n50), .Y(n7) );
  NAND2BX12M U36 ( .AN(b[6]), .B(\u_div/BInv [7]), .Y(n92) );
  MX2X1M U37 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(n47) );
  MXI2X8M U38 ( .A(n75), .B(n76), .S0(n77), .Y(\u_div/PartRem[5][1] ) );
  MXI2X6M U39 ( .A(n82), .B(n83), .S0(n84), .Y(\u_div/PartRem[4][1] ) );
  OR2X6M U40 ( .A(n89), .B(n88), .Y(n56) );
  INVXLM U41 ( .A(a[6]), .Y(n69) );
  BUFX2M U42 ( .A(\u_div/BInv [2]), .Y(n33) );
  NOR2X4M U43 ( .A(b[5]), .B(b[4]), .Y(n101) );
  INVX2M U44 ( .A(n81), .Y(\u_div/PartRem[3][2] ) );
  MXI2X1M U45 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(n65) );
  INVX2M U46 ( .A(\u_div/SumTmp[5][1] ), .Y(n43) );
  CLKNAND2X2M U47 ( .A(\u_div/CryTmp[1][5] ), .B(\u_div/PartRem[2][5] ), .Y(
        n30) );
  MX2X2M U48 ( .A(n35), .B(\u_div/SumTmp[5][2] ), .S0(quotient[5]), .Y(n50) );
  INVX2M U49 ( .A(a[7]), .Y(n53) );
  NOR2X4M U50 ( .A(n86), .B(n85), .Y(n84) );
  XNOR2X2M U51 ( .A(\u_div/BInv [0]), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  INVX4M U52 ( .A(b[7]), .Y(\u_div/BInv [7]) );
  INVX2M U53 ( .A(b[0]), .Y(\u_div/BInv [0]) );
  CLKXOR2X2M U54 ( .A(\u_div/BInv [0]), .B(a[3]), .Y(n4) );
  NAND2X6M U55 ( .A(n97), .B(n96), .Y(n95) );
  INVX2M U56 ( .A(quotient[7]), .Y(n5) );
  INVX2M U57 ( .A(n19), .Y(n6) );
  NAND2BX1M U58 ( .AN(n86), .B(n20), .Y(n100) );
  INVX4M U59 ( .A(\u_div/CryTmp[4][4] ), .Y(n86) );
  XOR2XLM U60 ( .A(n7), .B(\u_div/CryTmp[4][3] ), .Y(\u_div/SumTmp[4][3] ) );
  NAND2X2M U61 ( .A(n50), .B(n59), .Y(n10) );
  NAND3X4M U62 ( .A(n10), .B(n9), .C(n8), .Y(\u_div/CryTmp[4][4] ) );
  XOR2XLM U63 ( .A(\u_div/BInv [5]), .B(n39), .Y(n11) );
  XOR2XLM U64 ( .A(n11), .B(\u_div/CryTmp[2][5] ), .Y(\u_div/SumTmp[2][5] ) );
  NAND2X1M U65 ( .A(n39), .B(\u_div/BInv [5]), .Y(n14) );
  NAND3X4M U66 ( .A(n13), .B(n14), .C(n12), .Y(\u_div/CryTmp[2][6] ) );
  CLKINVX1M U67 ( .A(b[5]), .Y(\u_div/BInv [5]) );
  XOR2XLM U68 ( .A(n33), .B(n47), .Y(n15) );
  XOR2XLM U69 ( .A(n15), .B(\u_div/CryTmp[3][2] ), .Y(\u_div/SumTmp[3][2] ) );
  INVXLM U70 ( .A(n78), .Y(n19) );
  INVX4M U71 ( .A(\u_div/CryTmp[5][3] ), .Y(n79) );
  NAND3X4M U72 ( .A(n28), .B(n27), .C(n29), .Y(\u_div/CryTmp[5][3] ) );
  CLKINVX8M U73 ( .A(n78), .Y(n97) );
  INVX4M U74 ( .A(b[1]), .Y(\u_div/BInv [1]) );
  ADDFHX4M U75 ( .A(\u_div/CryTmp[5][1] ), .B(\u_div/BInv [1]), .CI(
        \u_div/PartRem[6][1] ), .CO(n21) );
  XOR2XLM U76 ( .A(n26), .B(n21), .Y(\u_div/SumTmp[5][2] ) );
  CLKNAND2X4M U77 ( .A(n22), .B(n36), .Y(n23) );
  INVX2M U78 ( .A(\u_div/SumTmp[6][1] ), .Y(n41) );
  NOR2BX4M U79 ( .AN(\u_div/CryTmp[6][2] ), .B(n73), .Y(quotient[6]) );
  XOR2XLM U80 ( .A(n33), .B(n40), .Y(n26) );
  MXI2X4M U81 ( .A(n58), .B(\u_div/SumTmp[2][1] ), .S0(quotient[2]), .Y(n66)
         );
  CLKNAND2X2M U82 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/BInv [5]), .Y(n32) );
  INVX2M U83 ( .A(n63), .Y(\u_div/PartRem[2][5] ) );
  NAND2XLM U84 ( .A(n19), .B(\u_div/BInv [2]), .Y(n73) );
  INVXLM U85 ( .A(b[2]), .Y(\u_div/BInv [2]) );
  MXI2X6M U86 ( .A(n51), .B(n52), .S0(n61), .Y(\u_div/PartRem[1][1] ) );
  MX2X4M U87 ( .A(\u_div/SumTmp[7][0] ), .B(a[7]), .S0(n95), .Y(n60) );
  CLKINVX8M U88 ( .A(n94), .Y(n61) );
  NOR2BX8M U89 ( .AN(\u_div/CryTmp[1][7] ), .B(b[7]), .Y(n94) );
  NOR2X6M U90 ( .A(n79), .B(n6), .Y(n77) );
  CLKINVX6M U91 ( .A(\u_div/CryTmp[2][6] ), .Y(n93) );
  MXI2XLM U92 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(n81) );
  NAND2BX2M U93 ( .AN(n93), .B(n102), .Y(n103) );
  MXI2X6M U94 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(n91), .Y(n67) );
  MXI2X6M U95 ( .A(n70), .B(n69), .S0(n71), .Y(\u_div/PartRem[6][1] ) );
  NOR2X3M U96 ( .A(n89), .B(n88), .Y(quotient[3]) );
  INVX4M U97 ( .A(\u_div/CryTmp[3][5] ), .Y(n89) );
  CLKINVX1M U98 ( .A(b[4]), .Y(\u_div/BInv [4]) );
  CLKINVX2M U99 ( .A(n64), .Y(\u_div/PartRem[2][4] ) );
  INVXLM U100 ( .A(n40), .Y(n34) );
  CLKINVX1M U101 ( .A(n34), .Y(n35) );
  NOR2X6M U102 ( .A(n93), .B(n92), .Y(n91) );
  INVXLM U103 ( .A(n104), .Y(quotient[1]) );
  MXI2XLM U104 ( .A(\u_div/SumTmp[7][0] ), .B(a[7]), .S0(n5), .Y(n36) );
  INVX4M U105 ( .A(n103), .Y(quotient[2]) );
  CLKINVX4M U106 ( .A(n62), .Y(\u_div/PartRem[2][6] ) );
  MX2XLM U107 ( .A(n47), .B(\u_div/SumTmp[3][2] ), .S0(quotient[3]), .Y(n44)
         );
  INVX2M U108 ( .A(n65), .Y(\u_div/PartRem[2][3] ) );
  MX2XLM U109 ( .A(n70), .B(n69), .S0(n71), .Y(n37) );
  CLKINVX4M U110 ( .A(\u_div/SumTmp[6][0] ), .Y(n70) );
  MXI2X1M U111 ( .A(n39), .B(\u_div/SumTmp[2][5] ), .S0(quotient[2]), .Y(n62)
         );
  NAND2XLM U112 ( .A(n102), .B(\u_div/BInv [5]), .Y(n88) );
  MXI2XLM U113 ( .A(n45), .B(\u_div/SumTmp[2][4] ), .S0(quotient[2]), .Y(n63)
         );
  MXI2X1M U114 ( .A(n63), .B(n3), .S0(quotient[1]), .Y(\u_div/PartRem[1][6] )
         );
  NAND2BX2M U115 ( .AN(n79), .B(n19), .Y(n99) );
  MX2XLM U116 ( .A(n49), .B(\u_div/SumTmp[3][4] ), .S0(quotient[3]), .Y(n39)
         );
  MXI2XLM U117 ( .A(n44), .B(\u_div/SumTmp[2][3] ), .S0(quotient[2]), .Y(n64)
         );
  MXI2X1M U118 ( .A(n65), .B(n80), .S0(quotient[1]), .Y(\u_div/PartRem[1][4] )
         );
  INVX2M U119 ( .A(\u_div/SumTmp[1][3] ), .Y(n80) );
  INVX2M U120 ( .A(\u_div/SumTmp[1][1] ), .Y(n90) );
  MX2X1M U121 ( .A(n48), .B(\u_div/SumTmp[3][3] ), .S0(quotient[3]), .Y(n45)
         );
  INVX2M U122 ( .A(n73), .Y(n72) );
  MXI2X1M U123 ( .A(n64), .B(n74), .S0(quotient[1]), .Y(\u_div/PartRem[1][5] )
         );
  INVX2M U124 ( .A(\u_div/SumTmp[1][4] ), .Y(n74) );
  MXI2X1M U125 ( .A(n62), .B(n68), .S0(quotient[1]), .Y(\u_div/PartRem[1][7] )
         );
  INVX2M U126 ( .A(\u_div/SumTmp[1][6] ), .Y(n68) );
  MX2XLM U127 ( .A(n50), .B(\u_div/SumTmp[4][3] ), .S0(quotient[4]), .Y(n49)
         );
  INVX2M U128 ( .A(a[5]), .Y(n75) );
  INVX2M U129 ( .A(\u_div/SumTmp[5][0] ), .Y(n76) );
  INVX2M U130 ( .A(a[4]), .Y(n82) );
  INVX2M U131 ( .A(\u_div/SumTmp[4][0] ), .Y(n83) );
  INVX2M U132 ( .A(a[3]), .Y(n55) );
  XNOR2XLM U133 ( .A(\u_div/BInv [0]), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  OR2X1M U134 ( .A(\u_div/BInv [0]), .B(a[3]), .Y(\u_div/CryTmp[3][1] ) );
  MXI2XLM U135 ( .A(n66), .B(n87), .S0(quotient[1]), .Y(\u_div/PartRem[1][3] )
         );
  INVX2M U136 ( .A(\u_div/SumTmp[1][2] ), .Y(n87) );
  NAND2BX1M U137 ( .AN(\u_div/BInv [0]), .B(n52), .Y(\u_div/CryTmp[1][1] ) );
  OR2X1M U138 ( .A(\u_div/BInv [0]), .B(a[2]), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U139 ( .A(a[1]), .Y(n52) );
  XOR2XLM U140 ( .A(\u_div/BInv [0]), .B(a[1]), .Y(n51) );
  NAND2BX1M U141 ( .AN(b[7]), .B(\u_div/CryTmp[1][7] ), .Y(n104) );
  NOR3X8M U142 ( .A(n98), .B(b[2]), .C(b[1]), .Y(n96) );
  INVXLM U143 ( .A(b[6]), .Y(\u_div/BInv [6]) );
  INVXLM U144 ( .A(n95), .Y(quotient[7]) );
  MXI2X6M U145 ( .A(n4), .B(n55), .S0(n56), .Y(n54) );
  INVXLM U146 ( .A(n54), .Y(n57) );
  INVX2M U147 ( .A(n57), .Y(n58) );
endmodule


module ALU ( A, B, ALU_FUN, EN, CLK, RST, ALU_OUT, OUT_VALID );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n31, n32,
         n33, n34, n36, n43, n44, n45, n46, n47, n48, n54, n55, n56, n60, n61,
         n62, n66, n67, n68, n72, n73, n74, n78, n79, n80, n88, n89, n90, n92,
         n101, n103, n104, n106, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n35, n37, n38, n39, n40, n41, n42, n49, n50, n51,
         n52, n53, n57, n58, n59, n63, n64, n65, n69, n70, n71, n75, n76, n77,
         n81, n82, n83, n84, n85, n86, n87, n91, n93, n94, n95, n96, n97, n98,
         n99, n100, n102, n105, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180;
  wire   [15:0] ALU_OUT_Comb;

  ALU_DW01_sub_0 sub_52 ( .A({1'b0, n28, n5, n26, n25, n24, n23, A[1:0]}), .B(
        {1'b0, B[7], n11, n18, B[4], n20, B[2], n21, B[0]}), .CI(1'b0), .DIFF(
        {N108, N107, N106, N105, N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_48 ( .A({1'b0, n28, n4, n26, n25, n24, n23, A[1:0]}), .B(
        {1'b0, B[7], n10, n18, n7, n20, B[2], n21, B[0]}), .CI(1'b0), .SUM({
        N99, N98, N97, N96, N95, N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_56 ( .A({n28, n4, n26, n25, n24, n23, A[1:0]}), .B({
        B[7], n11, n18, B[4], n20, B[2], n21, B[0]}), .TC(1'b0), .PRODUCT({
        N124, N123, N122, N121, N120, N119, N118, N117, N116, N115, N114, N113, 
        N112, N111, N110, N109}) );
  ALU_DW_div_uns_1 div_60 ( .a({n28, n3, n26, n25, n24, n23, A[1:0]}), .b({
        B[7], n22, n17, B[4:2], n21, B[0]}), .quotient({N132, N131, N130, N129, 
        N128, N127, N126, N125}) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[3]) );
  DFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[2]) );
  DFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[1]) );
  DFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[15]) );
  DFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[14]) );
  DFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[13]) );
  DFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[12]) );
  DFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[11]) );
  DFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[10]) );
  DFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[9]) );
  DFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[8]) );
  DFFRQX2M OUT_VALID_reg ( .D(EN), .CK(CLK), .RN(RST), .Q(OUT_VALID) );
  DFFRQX1M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[0]) );
  BUFX2M U3 ( .A(n9), .Y(n10) );
  AO22X1M U4 ( .A0(N110), .A1(n131), .B0(N92), .B1(n15), .Y(n127) );
  BUFX5M U7 ( .A(A[7]), .Y(n28) );
  NOR2X4M U8 ( .A(N125), .B(n85), .Y(n111) );
  BUFX2M U9 ( .A(n27), .Y(n3) );
  BUFX2M U10 ( .A(n27), .Y(n4) );
  BUFX2M U11 ( .A(n27), .Y(n5) );
  BUFX2M U12 ( .A(B[1]), .Y(n21) );
  AND2X2M U13 ( .A(n103), .B(n94), .Y(n6) );
  BUFX2M U14 ( .A(n9), .Y(n11) );
  BUFX2M U15 ( .A(A[6]), .Y(n27) );
  INVX2M U16 ( .A(n174), .Y(n7) );
  CLKMX2X2M U17 ( .A(n132), .B(n135), .S0(n21), .Y(n126) );
  CLKMX2X2M U18 ( .A(n113), .B(n117), .S0(n21), .Y(n115) );
  CLKMX2X2M U19 ( .A(n117), .B(n116), .S0(n21), .Y(n119) );
  INVXLM U20 ( .A(B[6]), .Y(n8) );
  INVX2M U21 ( .A(n8), .Y(n9) );
  BUFX8M U22 ( .A(B[6]), .Y(n22) );
  AND2X1M U23 ( .A(N126), .B(n125), .Y(n12) );
  NOR3X2M U24 ( .A(n12), .B(n13), .C(n124), .Y(n130) );
  AOI22XLM U25 ( .A0(N105), .A1(n14), .B0(n26), .B1(n135), .Y(n69) );
  NAND2BXLM U26 ( .AN(n18), .B(n26), .Y(n157) );
  INVXLM U27 ( .A(n26), .Y(n177) );
  BUFX2M U28 ( .A(A[3]), .Y(n24) );
  AOI21XLM U29 ( .A0(n141), .A1(n138), .B0(n21), .Y(n142) );
  AND2X2M U30 ( .A(N101), .B(n14), .Y(n13) );
  INVX2M U31 ( .A(n114), .Y(n132) );
  INVX2M U32 ( .A(n118), .Y(n135) );
  INVX2M U33 ( .A(n47), .Y(n113) );
  INVX2M U34 ( .A(n48), .Y(n116) );
  INVX2M U35 ( .A(n112), .Y(n133) );
  INVX2M U36 ( .A(n99), .Y(n125) );
  OAI2BB1X2M U37 ( .A0N(N124), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X2M U38 ( .A0N(N123), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U39 ( .A0N(N122), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U40 ( .A0N(N118), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[9]) );
  OAI2BB1X2M U41 ( .A0N(N119), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U42 ( .A0N(N120), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U43 ( .A0N(N121), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U44 ( .A0N(n133), .A1N(n136), .B0(n101), .Y(n47) );
  OAI2BB1X2M U45 ( .A0N(n134), .A1N(n137), .B0(n101), .Y(n48) );
  OR2X2M U46 ( .A(n30), .B(n29), .Y(n118) );
  OR2X2M U47 ( .A(n39), .B(n112), .Y(n114) );
  OR2X2M U48 ( .A(n139), .B(n38), .Y(n112) );
  NOR2X2M U49 ( .A(n37), .B(n30), .Y(n14) );
  INVX2M U50 ( .A(n106), .Y(n37) );
  INVX2M U51 ( .A(n46), .Y(n117) );
  INVX2M U52 ( .A(n29), .Y(n137) );
  INVX2M U53 ( .A(n39), .Y(n134) );
  INVX2M U54 ( .A(n30), .Y(n136) );
  NAND3BX2M U55 ( .AN(n139), .B(n136), .C(n38), .Y(n99) );
  NOR2BX2M U56 ( .AN(n131), .B(n172), .Y(n31) );
  INVX2M U57 ( .A(n35), .Y(n131) );
  NAND3BX2M U58 ( .AN(n139), .B(n134), .C(n38), .Y(n35) );
  NOR2X2M U59 ( .A(n39), .B(n37), .Y(n15) );
  INVX2M U60 ( .A(n123), .Y(n71) );
  AOI211X2M U61 ( .A0(n111), .A1(n110), .B0(n109), .C0(n172), .Y(
        ALU_OUT_Comb[0]) );
  NOR2X2M U62 ( .A(n108), .B(n107), .Y(n109) );
  NOR2X2M U63 ( .A(n96), .B(n95), .Y(n110) );
  INVX2M U64 ( .A(n16), .Y(n17) );
  AOI31X2M U65 ( .A0(n84), .A1(n83), .A2(n82), .B0(n172), .Y(ALU_OUT_Comb[7])
         );
  OA22X2M U66 ( .A0(n118), .A1(n175), .B0(n114), .B1(n28), .Y(n83) );
  AOI22X1M U67 ( .A0(N132), .A1(n125), .B0(N107), .B1(n14), .Y(n84) );
  AOI221XLM U68 ( .A0(N98), .A1(n15), .B0(N116), .B1(n131), .C0(n43), .Y(n82)
         );
  AOI21X2M U69 ( .A0(n33), .A1(n34), .B0(n172), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U70 ( .A0(N99), .A1(n15), .B0(n171), .Y(n33) );
  AOI2BB2XLM U71 ( .B0(N117), .B1(n131), .A0N(n175), .A1N(n36), .Y(n34) );
  NAND3BX2M U72 ( .AN(ALU_FUN[0]), .B(ALU_FUN[3]), .C(n133), .Y(n36) );
  NOR2X2M U73 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n106) );
  NAND3BX2M U74 ( .AN(n140), .B(ALU_FUN[3]), .C(n137), .Y(n123) );
  AND3X2M U75 ( .A(n106), .B(n140), .C(ALU_FUN[3]), .Y(n46) );
  NAND2X2M U76 ( .A(EN), .B(n171), .Y(n32) );
  INVX2M U77 ( .A(n92), .Y(n171) );
  AOI211X2M U78 ( .A0(N108), .A1(n14), .B0(n132), .C0(n47), .Y(n92) );
  INVX2M U79 ( .A(ALU_FUN[0]), .Y(n140) );
  OR2X2M U80 ( .A(ALU_FUN[3]), .B(n140), .Y(n30) );
  OR2X2M U81 ( .A(ALU_FUN[0]), .B(ALU_FUN[3]), .Y(n39) );
  INVX2M U82 ( .A(ALU_FUN[1]), .Y(n139) );
  INVX2M U83 ( .A(ALU_FUN[2]), .Y(n38) );
  OR2X2M U84 ( .A(ALU_FUN[1]), .B(n38), .Y(n29) );
  NAND3X2M U85 ( .A(n106), .B(ALU_FUN[0]), .C(ALU_FUN[3]), .Y(n101) );
  AND4X2M U86 ( .A(N159), .B(n137), .C(ALU_FUN[3]), .D(n140), .Y(n90) );
  AO22X1M U87 ( .A0(N94), .A1(n15), .B0(n179), .B1(n132), .Y(n50) );
  AO22X1M U88 ( .A0(N95), .A1(n15), .B0(n178), .B1(n132), .Y(n57) );
  AO22X1M U89 ( .A0(N96), .A1(n15), .B0(n177), .B1(n132), .Y(n64) );
  AO22X1M U90 ( .A0(N97), .A1(n15), .B0(n176), .B1(n132), .Y(n75) );
  AND2X2M U91 ( .A(n86), .B(n114), .Y(n93) );
  AND2X2M U92 ( .A(n87), .B(n118), .Y(n91) );
  NOR3X2M U93 ( .A(n140), .B(ALU_FUN[2]), .C(n139), .Y(n89) );
  NOR3X2M U94 ( .A(n139), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n104) );
  INVX2M U95 ( .A(n105), .Y(n96) );
  INVX2M U96 ( .A(EN), .Y(n172) );
  INVX2M U97 ( .A(B[5]), .Y(n16) );
  AOI31X2M U98 ( .A0(n49), .A1(n42), .A2(n41), .B0(n172), .Y(ALU_OUT_Comb[2])
         );
  AOI22X1M U99 ( .A0(N102), .A1(n14), .B0(n135), .B1(n23), .Y(n42) );
  AOI211X2M U100 ( .A0(N111), .A1(n131), .B0(n40), .C0(n78), .Y(n41) );
  AOI22XLM U101 ( .A0(n24), .A1(n71), .B0(N127), .B1(n125), .Y(n49) );
  AOI31X2M U102 ( .A0(n53), .A1(n52), .A2(n51), .B0(n172), .Y(ALU_OUT_Comb[3])
         );
  AOI22X1M U103 ( .A0(N103), .A1(n14), .B0(n24), .B1(n135), .Y(n52) );
  AOI211X2M U104 ( .A0(N112), .A1(n131), .B0(n50), .C0(n72), .Y(n51) );
  AOI31X2M U105 ( .A0(n63), .A1(n59), .A2(n58), .B0(n172), .Y(ALU_OUT_Comb[4])
         );
  AOI22X1M U106 ( .A0(N104), .A1(n14), .B0(n25), .B1(n135), .Y(n59) );
  AOI211X2M U107 ( .A0(N113), .A1(n131), .B0(n57), .C0(n66), .Y(n58) );
  AOI31X2M U108 ( .A0(n81), .A1(n77), .A2(n76), .B0(n172), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U109 ( .A0(N106), .A1(n14), .B0(n5), .B1(n135), .Y(n77) );
  AOI211X2M U110 ( .A0(N115), .A1(n131), .B0(n75), .C0(n54), .Y(n76) );
  AOI31X2M U111 ( .A0(n70), .A1(n69), .A2(n65), .B0(n172), .Y(ALU_OUT_Comb[5])
         );
  AOI22XLM U112 ( .A0(n4), .A1(n71), .B0(N130), .B1(n125), .Y(n70) );
  AOI211X2M U113 ( .A0(N114), .A1(n131), .B0(n64), .C0(n60), .Y(n65) );
  INVX2M U114 ( .A(n152), .Y(n170) );
  NAND3X2M U115 ( .A(n105), .B(n6), .C(n102), .Y(n107) );
  NAND2X2M U116 ( .A(n97), .B(n6), .Y(n95) );
  AOI221XLM U117 ( .A0(n46), .A1(n176), .B0(n5), .B1(n48), .C0(n135), .Y(n55)
         );
  AOI221XLM U118 ( .A0(n4), .A1(n46), .B0(n47), .B1(n176), .C0(n132), .Y(n56)
         );
  OAI222X1M U119 ( .A0(n73), .A1(n19), .B0(n20), .B1(n74), .C0(n36), .C1(n180), 
        .Y(n72) );
  AOI221XLM U120 ( .A0(n24), .A1(n46), .B0(n47), .B1(n179), .C0(n132), .Y(n74)
         );
  AOI221XLM U121 ( .A0(n46), .A1(n179), .B0(n24), .B1(n48), .C0(n135), .Y(n73)
         );
  OAI222X1M U122 ( .A0(n61), .A1(n16), .B0(n18), .B1(n62), .C0(n36), .C1(n178), 
        .Y(n60) );
  AOI221XLM U123 ( .A0(n26), .A1(n46), .B0(n47), .B1(n177), .C0(n132), .Y(n62)
         );
  AOI221XLM U124 ( .A0(n46), .A1(n177), .B0(n26), .B1(n48), .C0(n135), .Y(n61)
         );
  AOI221XLM U125 ( .A0(n46), .A1(n178), .B0(n25), .B1(n48), .C0(n135), .Y(n67)
         );
  AOI221XLM U126 ( .A0(n25), .A1(n46), .B0(n47), .B1(n178), .C0(n132), .Y(n68)
         );
  NAND4X2M U127 ( .A(n100), .B(n99), .C(n98), .D(n97), .Y(n108) );
  NAND3X2M U128 ( .A(n98), .B(n102), .C(n100), .Y(n85) );
  OR2X2M U129 ( .A(n138), .B(n123), .Y(n97) );
  AND2X2M U130 ( .A(n119), .B(n118), .Y(n120) );
  NAND2X2M U131 ( .A(N109), .B(n131), .Y(n105) );
  NAND2X2M U132 ( .A(N91), .B(n15), .Y(n102) );
  AO22X1M U133 ( .A0(N93), .A1(n15), .B0(n180), .B1(n132), .Y(n40) );
  INVX2M U134 ( .A(n24), .Y(n179) );
  INVX2M U135 ( .A(n23), .Y(n180) );
  INVX2M U136 ( .A(n25), .Y(n178) );
  INVX2M U137 ( .A(n4), .Y(n176) );
  AOI21X2M U138 ( .A0(n130), .A1(n129), .B0(n172), .Y(ALU_OUT_Comb[1]) );
  AOI211X2M U139 ( .A0(A[0]), .A1(n128), .B0(n127), .C0(n126), .Y(n129) );
  INVX2M U140 ( .A(n36), .Y(n128) );
  BUFX2M U141 ( .A(A[5]), .Y(n26) );
  BUFX2M U142 ( .A(A[4]), .Y(n25) );
  BUFX2M U143 ( .A(A[2]), .Y(n23) );
  OAI2B11X2M U144 ( .A1N(n23), .A0(n123), .B0(n88), .C0(n122), .Y(n124) );
  MX2X2M U145 ( .A(n121), .B(n120), .S0(A[1]), .Y(n122) );
  AOI31X2M U146 ( .A0(N158), .A1(ALU_FUN[3]), .A2(n89), .B0(n90), .Y(n88) );
  AND2X2M U147 ( .A(n115), .B(n114), .Y(n121) );
  INVX2M U148 ( .A(A[1]), .Y(n138) );
  MX2X2M U149 ( .A(n93), .B(n91), .S0(A[0]), .Y(n94) );
  AOI31X2M U150 ( .A0(N157), .A1(ALU_FUN[3]), .A2(n104), .B0(n90), .Y(n103) );
  OAI222XLM U151 ( .A0(n79), .A1(n169), .B0(B[2]), .B1(n80), .C0(n36), .C1(
        n138), .Y(n78) );
  AOI221XLM U152 ( .A0(n23), .A1(n46), .B0(n47), .B1(n180), .C0(n132), .Y(n80)
         );
  AOI221XLM U153 ( .A0(n46), .A1(n180), .B0(n23), .B1(n48), .C0(n135), .Y(n79)
         );
  INVX2M U154 ( .A(n141), .Y(n168) );
  NAND2X2M U155 ( .A(N100), .B(n14), .Y(n98) );
  OAI222XLM U156 ( .A0(n55), .A1(n8), .B0(n10), .B1(n56), .C0(n36), .C1(n177), 
        .Y(n54) );
  AOI32XLM U157 ( .A0(n147), .A1(n157), .A2(n160), .B0(n11), .B1(n176), .Y(
        n148) );
  XNOR2XLM U158 ( .A(n5), .B(n10), .Y(n160) );
  INVXLM U159 ( .A(B[7]), .Y(n173) );
  INVXLM U160 ( .A(B[2]), .Y(n169) );
  OAI222XLM U161 ( .A0(n67), .A1(n174), .B0(n7), .B1(n68), .C0(n36), .C1(n179), 
        .Y(n66) );
  INVXLM U162 ( .A(B[4]), .Y(n174) );
  NAND2BXLM U163 ( .AN(n25), .B(n7), .Y(n145) );
  INVXLM U164 ( .A(n16), .Y(n18) );
  MX2XLM U165 ( .A(n114), .B(n118), .S0(B[0]), .Y(n100) );
  MX2XLM U166 ( .A(n113), .B(n117), .S0(B[0]), .Y(n86) );
  MX2XLM U167 ( .A(n117), .B(n116), .S0(B[0]), .Y(n87) );
  AOI22XLM U168 ( .A0(n28), .A1(n71), .B0(N131), .B1(n125), .Y(n81) );
  AOI221XLM U169 ( .A0(n46), .A1(n175), .B0(n28), .B1(n48), .C0(n135), .Y(n44)
         );
  AOI221XLM U170 ( .A0(n46), .A1(n28), .B0(n47), .B1(n175), .C0(n132), .Y(n45)
         );
  INVXLM U171 ( .A(B[3]), .Y(n19) );
  INVX2M U172 ( .A(n19), .Y(n20) );
  AOI22XLM U173 ( .A0(n25), .A1(n71), .B0(N128), .B1(n125), .Y(n53) );
  INVXLM U174 ( .A(B[0]), .Y(n167) );
  INVXLM U175 ( .A(n28), .Y(n175) );
  NAND2XLM U176 ( .A(B[7]), .B(n175), .Y(n164) );
  OAI222XLM U177 ( .A0(n44), .A1(n173), .B0(B[7]), .B1(n45), .C0(n36), .C1(
        n176), .Y(n43) );
  NOR2XLM U178 ( .A(n175), .B(B[7]), .Y(n163) );
  AOI22XLM U179 ( .A0(n26), .A1(n71), .B0(N129), .B1(n125), .Y(n63) );
  NAND2BX1M U180 ( .AN(n7), .B(n25), .Y(n156) );
  CLKNAND2X2M U181 ( .A(n156), .B(n145), .Y(n158) );
  NOR2X1M U182 ( .A(n19), .B(n24), .Y(n153) );
  NOR2X1M U183 ( .A(n169), .B(n23), .Y(n144) );
  NOR2X1M U184 ( .A(n167), .B(A[0]), .Y(n141) );
  CLKNAND2X2M U185 ( .A(n23), .B(n169), .Y(n155) );
  NAND2BX1M U186 ( .AN(n144), .B(n155), .Y(n150) );
  AOI211X1M U187 ( .A0(A[1]), .A1(n168), .B0(n150), .C0(n142), .Y(n143) );
  CLKNAND2X2M U188 ( .A(n24), .B(n19), .Y(n154) );
  OAI31X1M U189 ( .A0(n153), .A1(n144), .A2(n143), .B0(n154), .Y(n146) );
  NAND2BX1M U190 ( .AN(n26), .B(n18), .Y(n161) );
  OAI211X1M U191 ( .A0(n158), .A1(n146), .B0(n145), .C0(n161), .Y(n147) );
  OAI21X1M U192 ( .A0(n163), .A1(n148), .B0(n164), .Y(N159) );
  CLKNAND2X2M U193 ( .A(A[0]), .B(n167), .Y(n151) );
  OA21X1M U194 ( .A0(n151), .A1(n138), .B0(n21), .Y(n149) );
  AOI211X1M U195 ( .A0(n151), .A1(n138), .B0(n150), .C0(n149), .Y(n152) );
  AOI31X1M U196 ( .A0(n170), .A1(n155), .A2(n154), .B0(n153), .Y(n159) );
  OAI2B11X1M U197 ( .A1N(n159), .A0(n158), .B0(n157), .C0(n156), .Y(n162) );
  AOI32X1M U198 ( .A0(n162), .A1(n161), .A2(n160), .B0(n5), .B1(n8), .Y(n165)
         );
  AOI2B1X1M U199 ( .A1N(n165), .A0(n164), .B0(n163), .Y(n166) );
  CLKINVX1M U200 ( .A(n166), .Y(N158) );
  NOR2X1M U201 ( .A(N159), .B(N158), .Y(N157) );
endmodule


module BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_0 ( CLK, RST, ASYNC, SYNC );
  input [3:0] ASYNC;
  output [3:0] SYNC;
  input CLK, RST;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] ;

  DFFRQX2M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[3]) );
  DFFRQX2M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[2]) );
  DFFRQX2M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[1]) );
  DFFRQX2M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[0]) );
  DFFRQX2M \sync_reg_reg[3][0]  ( .D(ASYNC[3]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[3][0] ) );
  DFFRQX2M \sync_reg_reg[2][0]  ( .D(ASYNC[2]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[2][0] ) );
  DFFRQX2M \sync_reg_reg[1][0]  ( .D(ASYNC[1]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[1][0] ) );
  DFFRQX2M \sync_reg_reg[0][0]  ( .D(ASYNC[0]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[0][0] ) );
endmodule


module BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_1 ( CLK, RST, ASYNC, SYNC );
  input [3:0] ASYNC;
  output [3:0] SYNC;
  input CLK, RST;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] ;

  DFFRQX2M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[3]) );
  DFFRQX2M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[2]) );
  DFFRQX2M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[1]) );
  DFFRQX2M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .CK(CLK), .RN(RST), 
        .Q(SYNC[0]) );
  DFFRQX2M \sync_reg_reg[3][0]  ( .D(ASYNC[3]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[3][0] ) );
  DFFRQX2M \sync_reg_reg[2][0]  ( .D(ASYNC[2]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[2][0] ) );
  DFFRQX2M \sync_reg_reg[1][0]  ( .D(ASYNC[1]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[1][0] ) );
  DFFRQX2M \sync_reg_reg[0][0]  ( .D(ASYNC[0]), .CK(CLK), .RN(RST), .Q(
        \sync_reg[0][0] ) );
endmodule


module FIFO_mem_Data_Width8_DEPTH8_POI_SIZE4 ( wclk, wrst_n, winc, wfull, 
        wdata, waddr, raddr, rdata );
  input [7:0] wdata;
  input [2:0] waddr;
  input [2:0] raddr;
  output [7:0] rdata;
  input wclk, wrst_n, winc, wfull;
  wire   N9, N10, N11, \MEM[7][7] , \MEM[7][6] , \MEM[7][5] , \MEM[7][4] ,
         \MEM[7][3] , \MEM[7][2] , \MEM[7][1] , \MEM[7][0] , \MEM[6][7] ,
         \MEM[6][6] , \MEM[6][5] , \MEM[6][4] , \MEM[6][3] , \MEM[6][2] ,
         \MEM[6][1] , \MEM[6][0] , \MEM[5][7] , \MEM[5][6] , \MEM[5][5] ,
         \MEM[5][4] , \MEM[5][3] , \MEM[5][2] , \MEM[5][1] , \MEM[5][0] ,
         \MEM[4][7] , \MEM[4][6] , \MEM[4][5] , \MEM[4][4] , \MEM[4][3] ,
         \MEM[4][2] , \MEM[4][1] , \MEM[4][0] , \MEM[3][7] , \MEM[3][6] ,
         \MEM[3][5] , \MEM[3][4] , \MEM[3][3] , \MEM[3][2] , \MEM[3][1] ,
         \MEM[3][0] , \MEM[2][7] , \MEM[2][6] , \MEM[2][5] , \MEM[2][4] ,
         \MEM[2][3] , \MEM[2][2] , \MEM[2][1] , \MEM[2][0] , \MEM[1][7] ,
         \MEM[1][6] , \MEM[1][5] , \MEM[1][4] , \MEM[1][3] , \MEM[1][2] ,
         \MEM[1][1] , \MEM[1][0] , \MEM[0][7] , \MEM[0][6] , \MEM[0][5] ,
         \MEM[0][4] , \MEM[0][3] , \MEM[0][2] , \MEM[0][1] , \MEM[0][0] , n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115;
  assign N9 = raddr[0];
  assign N10 = raddr[1];
  assign N11 = raddr[2];

  DFFRQX2M \MEM_reg[5][7]  ( .D(n69), .CK(wclk), .RN(n102), .Q(\MEM[5][7] ) );
  DFFRQX2M \MEM_reg[5][6]  ( .D(n68), .CK(wclk), .RN(n102), .Q(\MEM[5][6] ) );
  DFFRQX2M \MEM_reg[5][5]  ( .D(n67), .CK(wclk), .RN(n102), .Q(\MEM[5][5] ) );
  DFFRQX2M \MEM_reg[5][4]  ( .D(n66), .CK(wclk), .RN(n102), .Q(\MEM[5][4] ) );
  DFFRQX2M \MEM_reg[5][3]  ( .D(n65), .CK(wclk), .RN(n102), .Q(\MEM[5][3] ) );
  DFFRQX2M \MEM_reg[5][2]  ( .D(n64), .CK(wclk), .RN(n102), .Q(\MEM[5][2] ) );
  DFFRQX2M \MEM_reg[5][1]  ( .D(n63), .CK(wclk), .RN(n102), .Q(\MEM[5][1] ) );
  DFFRQX2M \MEM_reg[5][0]  ( .D(n62), .CK(wclk), .RN(n102), .Q(\MEM[5][0] ) );
  DFFRQX2M \MEM_reg[1][7]  ( .D(n37), .CK(wclk), .RN(n104), .Q(\MEM[1][7] ) );
  DFFRQX2M \MEM_reg[1][6]  ( .D(n36), .CK(wclk), .RN(n104), .Q(\MEM[1][6] ) );
  DFFRQX2M \MEM_reg[1][5]  ( .D(n35), .CK(wclk), .RN(n104), .Q(\MEM[1][5] ) );
  DFFRQX2M \MEM_reg[1][4]  ( .D(n34), .CK(wclk), .RN(n104), .Q(\MEM[1][4] ) );
  DFFRQX2M \MEM_reg[1][3]  ( .D(n33), .CK(wclk), .RN(n105), .Q(\MEM[1][3] ) );
  DFFRQX2M \MEM_reg[1][2]  ( .D(n32), .CK(wclk), .RN(n105), .Q(\MEM[1][2] ) );
  DFFRQX2M \MEM_reg[1][1]  ( .D(n31), .CK(wclk), .RN(n105), .Q(\MEM[1][1] ) );
  DFFRQX2M \MEM_reg[1][0]  ( .D(n30), .CK(wclk), .RN(n105), .Q(\MEM[1][0] ) );
  DFFRQX2M \MEM_reg[7][7]  ( .D(n85), .CK(wclk), .RN(n101), .Q(\MEM[7][7] ) );
  DFFRQX2M \MEM_reg[7][6]  ( .D(n84), .CK(wclk), .RN(n101), .Q(\MEM[7][6] ) );
  DFFRQX2M \MEM_reg[7][5]  ( .D(n83), .CK(wclk), .RN(n101), .Q(\MEM[7][5] ) );
  DFFRQX2M \MEM_reg[7][4]  ( .D(n82), .CK(wclk), .RN(n101), .Q(\MEM[7][4] ) );
  DFFRQX2M \MEM_reg[7][3]  ( .D(n81), .CK(wclk), .RN(n101), .Q(\MEM[7][3] ) );
  DFFRQX2M \MEM_reg[7][2]  ( .D(n80), .CK(wclk), .RN(n101), .Q(\MEM[7][2] ) );
  DFFRQX2M \MEM_reg[7][1]  ( .D(n79), .CK(wclk), .RN(n101), .Q(\MEM[7][1] ) );
  DFFRQX2M \MEM_reg[7][0]  ( .D(n78), .CK(wclk), .RN(n101), .Q(\MEM[7][0] ) );
  DFFRQX2M \MEM_reg[3][7]  ( .D(n53), .CK(wclk), .RN(n103), .Q(\MEM[3][7] ) );
  DFFRQX2M \MEM_reg[3][6]  ( .D(n52), .CK(wclk), .RN(n103), .Q(\MEM[3][6] ) );
  DFFRQX2M \MEM_reg[3][5]  ( .D(n51), .CK(wclk), .RN(n103), .Q(\MEM[3][5] ) );
  DFFRQX2M \MEM_reg[3][4]  ( .D(n50), .CK(wclk), .RN(n103), .Q(\MEM[3][4] ) );
  DFFRQX2M \MEM_reg[3][3]  ( .D(n49), .CK(wclk), .RN(n103), .Q(\MEM[3][3] ) );
  DFFRQX2M \MEM_reg[3][2]  ( .D(n48), .CK(wclk), .RN(n103), .Q(\MEM[3][2] ) );
  DFFRQX2M \MEM_reg[3][1]  ( .D(n47), .CK(wclk), .RN(n103), .Q(\MEM[3][1] ) );
  DFFRQX2M \MEM_reg[3][0]  ( .D(n46), .CK(wclk), .RN(n104), .Q(\MEM[3][0] ) );
  DFFRQX2M \MEM_reg[6][7]  ( .D(n77), .CK(wclk), .RN(n101), .Q(\MEM[6][7] ) );
  DFFRQX2M \MEM_reg[6][6]  ( .D(n76), .CK(wclk), .RN(n101), .Q(\MEM[6][6] ) );
  DFFRQX2M \MEM_reg[6][5]  ( .D(n75), .CK(wclk), .RN(n101), .Q(\MEM[6][5] ) );
  DFFRQX2M \MEM_reg[6][4]  ( .D(n74), .CK(wclk), .RN(n101), .Q(\MEM[6][4] ) );
  DFFRQX2M \MEM_reg[6][3]  ( .D(n73), .CK(wclk), .RN(n101), .Q(\MEM[6][3] ) );
  DFFRQX2M \MEM_reg[6][2]  ( .D(n72), .CK(wclk), .RN(n102), .Q(\MEM[6][2] ) );
  DFFRQX2M \MEM_reg[6][1]  ( .D(n71), .CK(wclk), .RN(n102), .Q(\MEM[6][1] ) );
  DFFRQX2M \MEM_reg[6][0]  ( .D(n70), .CK(wclk), .RN(n102), .Q(\MEM[6][0] ) );
  DFFRQX2M \MEM_reg[2][7]  ( .D(n45), .CK(wclk), .RN(n104), .Q(\MEM[2][7] ) );
  DFFRQX2M \MEM_reg[2][6]  ( .D(n44), .CK(wclk), .RN(n104), .Q(\MEM[2][6] ) );
  DFFRQX2M \MEM_reg[2][5]  ( .D(n43), .CK(wclk), .RN(n104), .Q(\MEM[2][5] ) );
  DFFRQX2M \MEM_reg[2][4]  ( .D(n42), .CK(wclk), .RN(n104), .Q(\MEM[2][4] ) );
  DFFRQX2M \MEM_reg[2][3]  ( .D(n41), .CK(wclk), .RN(n104), .Q(\MEM[2][3] ) );
  DFFRQX2M \MEM_reg[2][2]  ( .D(n40), .CK(wclk), .RN(n104), .Q(\MEM[2][2] ) );
  DFFRQX2M \MEM_reg[2][1]  ( .D(n39), .CK(wclk), .RN(n104), .Q(\MEM[2][1] ) );
  DFFRQX2M \MEM_reg[2][0]  ( .D(n38), .CK(wclk), .RN(n104), .Q(\MEM[2][0] ) );
  DFFRQX2M \MEM_reg[4][7]  ( .D(n61), .CK(wclk), .RN(n102), .Q(\MEM[4][7] ) );
  DFFRQX2M \MEM_reg[4][6]  ( .D(n60), .CK(wclk), .RN(n102), .Q(\MEM[4][6] ) );
  DFFRQX2M \MEM_reg[4][5]  ( .D(n59), .CK(wclk), .RN(n103), .Q(\MEM[4][5] ) );
  DFFRQX2M \MEM_reg[4][4]  ( .D(n58), .CK(wclk), .RN(n103), .Q(\MEM[4][4] ) );
  DFFRQX2M \MEM_reg[4][3]  ( .D(n57), .CK(wclk), .RN(n103), .Q(\MEM[4][3] ) );
  DFFRQX2M \MEM_reg[4][2]  ( .D(n56), .CK(wclk), .RN(n103), .Q(\MEM[4][2] ) );
  DFFRQX2M \MEM_reg[4][1]  ( .D(n55), .CK(wclk), .RN(n103), .Q(\MEM[4][1] ) );
  DFFRQX2M \MEM_reg[4][0]  ( .D(n54), .CK(wclk), .RN(n103), .Q(\MEM[4][0] ) );
  DFFRQX2M \MEM_reg[0][7]  ( .D(n29), .CK(wclk), .RN(n105), .Q(\MEM[0][7] ) );
  DFFRQX2M \MEM_reg[0][6]  ( .D(n28), .CK(wclk), .RN(n105), .Q(\MEM[0][6] ) );
  DFFRQX2M \MEM_reg[0][5]  ( .D(n27), .CK(wclk), .RN(n105), .Q(\MEM[0][5] ) );
  DFFRQX2M \MEM_reg[0][4]  ( .D(n26), .CK(wclk), .RN(n105), .Q(\MEM[0][4] ) );
  DFFRQX2M \MEM_reg[0][3]  ( .D(n25), .CK(wclk), .RN(n105), .Q(\MEM[0][3] ) );
  DFFRQX2M \MEM_reg[0][2]  ( .D(n24), .CK(wclk), .RN(n105), .Q(\MEM[0][2] ) );
  DFFRQX2M \MEM_reg[0][1]  ( .D(n23), .CK(wclk), .RN(n105), .Q(\MEM[0][1] ) );
  DFFRQX2M \MEM_reg[0][0]  ( .D(n22), .CK(wclk), .RN(n105), .Q(\MEM[0][0] ) );
  BUFX2M U2 ( .A(n19), .Y(n96) );
  BUFX2M U3 ( .A(n13), .Y(n98) );
  BUFX2M U4 ( .A(n14), .Y(n97) );
  BUFX2M U5 ( .A(n20), .Y(n95) );
  BUFX2M U6 ( .A(n21), .Y(n94) );
  BUFX2M U7 ( .A(n99), .Y(n103) );
  BUFX2M U8 ( .A(n99), .Y(n102) );
  BUFX2M U9 ( .A(n99), .Y(n101) );
  BUFX2M U10 ( .A(n100), .Y(n104) );
  BUFX2M U11 ( .A(n100), .Y(n105) );
  BUFX2M U12 ( .A(wrst_n), .Y(n99) );
  BUFX2M U13 ( .A(wrst_n), .Y(n100) );
  NAND3X2M U14 ( .A(n114), .B(n115), .C(n18), .Y(n17) );
  NAND3X2M U15 ( .A(n114), .B(n115), .C(n12), .Y(n11) );
  NOR2BX2M U16 ( .AN(winc), .B(wfull), .Y(n16) );
  NAND3X2M U17 ( .A(waddr[0]), .B(n12), .C(waddr[1]), .Y(n15) );
  NOR2BX2M U18 ( .AN(n16), .B(waddr[2]), .Y(n12) );
  OAI2BB2X1M U19 ( .B0(n11), .B1(n113), .A0N(\MEM[0][0] ), .A1N(n11), .Y(n22)
         );
  OAI2BB2X1M U20 ( .B0(n11), .B1(n112), .A0N(\MEM[0][1] ), .A1N(n11), .Y(n23)
         );
  OAI2BB2X1M U21 ( .B0(n11), .B1(n111), .A0N(\MEM[0][2] ), .A1N(n11), .Y(n24)
         );
  OAI2BB2X1M U22 ( .B0(n11), .B1(n110), .A0N(\MEM[0][3] ), .A1N(n11), .Y(n25)
         );
  OAI2BB2X1M U23 ( .B0(n11), .B1(n109), .A0N(\MEM[0][4] ), .A1N(n11), .Y(n26)
         );
  OAI2BB2X1M U24 ( .B0(n11), .B1(n108), .A0N(\MEM[0][5] ), .A1N(n11), .Y(n27)
         );
  OAI2BB2X1M U25 ( .B0(n11), .B1(n107), .A0N(\MEM[0][6] ), .A1N(n11), .Y(n28)
         );
  OAI2BB2X1M U26 ( .B0(n11), .B1(n106), .A0N(\MEM[0][7] ), .A1N(n11), .Y(n29)
         );
  OAI2BB2X1M U27 ( .B0(n113), .B1(n15), .A0N(\MEM[3][0] ), .A1N(n15), .Y(n46)
         );
  OAI2BB2X1M U28 ( .B0(n112), .B1(n15), .A0N(\MEM[3][1] ), .A1N(n15), .Y(n47)
         );
  OAI2BB2X1M U29 ( .B0(n111), .B1(n15), .A0N(\MEM[3][2] ), .A1N(n15), .Y(n48)
         );
  OAI2BB2X1M U30 ( .B0(n110), .B1(n15), .A0N(\MEM[3][3] ), .A1N(n15), .Y(n49)
         );
  OAI2BB2X1M U31 ( .B0(n109), .B1(n15), .A0N(\MEM[3][4] ), .A1N(n15), .Y(n50)
         );
  OAI2BB2X1M U32 ( .B0(n108), .B1(n15), .A0N(\MEM[3][5] ), .A1N(n15), .Y(n51)
         );
  OAI2BB2X1M U33 ( .B0(n107), .B1(n15), .A0N(\MEM[3][6] ), .A1N(n15), .Y(n52)
         );
  OAI2BB2X1M U34 ( .B0(n106), .B1(n15), .A0N(\MEM[3][7] ), .A1N(n15), .Y(n53)
         );
  OAI2BB2X1M U35 ( .B0(n113), .B1(n17), .A0N(\MEM[4][0] ), .A1N(n17), .Y(n54)
         );
  OAI2BB2X1M U36 ( .B0(n112), .B1(n17), .A0N(\MEM[4][1] ), .A1N(n17), .Y(n55)
         );
  OAI2BB2X1M U37 ( .B0(n111), .B1(n17), .A0N(\MEM[4][2] ), .A1N(n17), .Y(n56)
         );
  OAI2BB2X1M U38 ( .B0(n110), .B1(n17), .A0N(\MEM[4][3] ), .A1N(n17), .Y(n57)
         );
  OAI2BB2X1M U39 ( .B0(n109), .B1(n17), .A0N(\MEM[4][4] ), .A1N(n17), .Y(n58)
         );
  OAI2BB2X1M U40 ( .B0(n108), .B1(n17), .A0N(\MEM[4][5] ), .A1N(n17), .Y(n59)
         );
  OAI2BB2X1M U41 ( .B0(n107), .B1(n17), .A0N(\MEM[4][6] ), .A1N(n17), .Y(n60)
         );
  OAI2BB2X1M U42 ( .B0(n106), .B1(n17), .A0N(\MEM[4][7] ), .A1N(n17), .Y(n61)
         );
  INVX2M U43 ( .A(wdata[0]), .Y(n113) );
  INVX2M U44 ( .A(wdata[1]), .Y(n112) );
  INVX2M U45 ( .A(wdata[2]), .Y(n111) );
  INVX2M U46 ( .A(wdata[3]), .Y(n110) );
  INVX2M U47 ( .A(wdata[4]), .Y(n109) );
  INVX2M U48 ( .A(wdata[5]), .Y(n108) );
  INVX2M U49 ( .A(wdata[6]), .Y(n107) );
  INVX2M U50 ( .A(wdata[7]), .Y(n106) );
  OAI2BB2X1M U51 ( .B0(n113), .B1(n98), .A0N(\MEM[1][0] ), .A1N(n98), .Y(n30)
         );
  OAI2BB2X1M U52 ( .B0(n112), .B1(n98), .A0N(\MEM[1][1] ), .A1N(n98), .Y(n31)
         );
  OAI2BB2X1M U53 ( .B0(n111), .B1(n98), .A0N(\MEM[1][2] ), .A1N(n98), .Y(n32)
         );
  OAI2BB2X1M U54 ( .B0(n110), .B1(n98), .A0N(\MEM[1][3] ), .A1N(n98), .Y(n33)
         );
  OAI2BB2X1M U55 ( .B0(n109), .B1(n98), .A0N(\MEM[1][4] ), .A1N(n98), .Y(n34)
         );
  OAI2BB2X1M U56 ( .B0(n108), .B1(n98), .A0N(\MEM[1][5] ), .A1N(n98), .Y(n35)
         );
  OAI2BB2X1M U57 ( .B0(n107), .B1(n98), .A0N(\MEM[1][6] ), .A1N(n98), .Y(n36)
         );
  OAI2BB2X1M U58 ( .B0(n106), .B1(n98), .A0N(\MEM[1][7] ), .A1N(n98), .Y(n37)
         );
  OAI2BB2X1M U59 ( .B0(n113), .B1(n97), .A0N(\MEM[2][0] ), .A1N(n97), .Y(n38)
         );
  OAI2BB2X1M U60 ( .B0(n112), .B1(n97), .A0N(\MEM[2][1] ), .A1N(n97), .Y(n39)
         );
  OAI2BB2X1M U61 ( .B0(n111), .B1(n97), .A0N(\MEM[2][2] ), .A1N(n97), .Y(n40)
         );
  OAI2BB2X1M U62 ( .B0(n110), .B1(n97), .A0N(\MEM[2][3] ), .A1N(n97), .Y(n41)
         );
  OAI2BB2X1M U63 ( .B0(n109), .B1(n97), .A0N(\MEM[2][4] ), .A1N(n97), .Y(n42)
         );
  OAI2BB2X1M U64 ( .B0(n108), .B1(n97), .A0N(\MEM[2][5] ), .A1N(n97), .Y(n43)
         );
  OAI2BB2X1M U65 ( .B0(n107), .B1(n97), .A0N(\MEM[2][6] ), .A1N(n97), .Y(n44)
         );
  OAI2BB2X1M U66 ( .B0(n106), .B1(n97), .A0N(\MEM[2][7] ), .A1N(n97), .Y(n45)
         );
  OAI2BB2X1M U67 ( .B0(n113), .B1(n96), .A0N(\MEM[5][0] ), .A1N(n96), .Y(n62)
         );
  OAI2BB2X1M U68 ( .B0(n112), .B1(n96), .A0N(\MEM[5][1] ), .A1N(n96), .Y(n63)
         );
  OAI2BB2X1M U69 ( .B0(n111), .B1(n96), .A0N(\MEM[5][2] ), .A1N(n96), .Y(n64)
         );
  OAI2BB2X1M U70 ( .B0(n110), .B1(n96), .A0N(\MEM[5][3] ), .A1N(n96), .Y(n65)
         );
  OAI2BB2X1M U71 ( .B0(n109), .B1(n96), .A0N(\MEM[5][4] ), .A1N(n96), .Y(n66)
         );
  OAI2BB2X1M U72 ( .B0(n108), .B1(n96), .A0N(\MEM[5][5] ), .A1N(n96), .Y(n67)
         );
  OAI2BB2X1M U73 ( .B0(n107), .B1(n96), .A0N(\MEM[5][6] ), .A1N(n96), .Y(n68)
         );
  OAI2BB2X1M U74 ( .B0(n106), .B1(n96), .A0N(\MEM[5][7] ), .A1N(n96), .Y(n69)
         );
  OAI2BB2X1M U75 ( .B0(n113), .B1(n95), .A0N(\MEM[6][0] ), .A1N(n95), .Y(n70)
         );
  OAI2BB2X1M U76 ( .B0(n112), .B1(n95), .A0N(\MEM[6][1] ), .A1N(n95), .Y(n71)
         );
  OAI2BB2X1M U77 ( .B0(n111), .B1(n95), .A0N(\MEM[6][2] ), .A1N(n95), .Y(n72)
         );
  OAI2BB2X1M U78 ( .B0(n110), .B1(n95), .A0N(\MEM[6][3] ), .A1N(n95), .Y(n73)
         );
  OAI2BB2X1M U79 ( .B0(n109), .B1(n95), .A0N(\MEM[6][4] ), .A1N(n95), .Y(n74)
         );
  OAI2BB2X1M U80 ( .B0(n108), .B1(n95), .A0N(\MEM[6][5] ), .A1N(n95), .Y(n75)
         );
  OAI2BB2X1M U81 ( .B0(n107), .B1(n95), .A0N(\MEM[6][6] ), .A1N(n95), .Y(n76)
         );
  OAI2BB2X1M U82 ( .B0(n106), .B1(n95), .A0N(\MEM[6][7] ), .A1N(n95), .Y(n77)
         );
  OAI2BB2X1M U83 ( .B0(n113), .B1(n94), .A0N(\MEM[7][0] ), .A1N(n94), .Y(n78)
         );
  OAI2BB2X1M U84 ( .B0(n112), .B1(n94), .A0N(\MEM[7][1] ), .A1N(n94), .Y(n79)
         );
  OAI2BB2X1M U85 ( .B0(n111), .B1(n94), .A0N(\MEM[7][2] ), .A1N(n94), .Y(n80)
         );
  OAI2BB2X1M U86 ( .B0(n110), .B1(n94), .A0N(\MEM[7][3] ), .A1N(n94), .Y(n81)
         );
  OAI2BB2X1M U87 ( .B0(n109), .B1(n94), .A0N(\MEM[7][4] ), .A1N(n94), .Y(n82)
         );
  OAI2BB2X1M U88 ( .B0(n108), .B1(n94), .A0N(\MEM[7][5] ), .A1N(n94), .Y(n83)
         );
  OAI2BB2X1M U89 ( .B0(n107), .B1(n94), .A0N(\MEM[7][6] ), .A1N(n94), .Y(n84)
         );
  OAI2BB2X1M U90 ( .B0(n106), .B1(n94), .A0N(\MEM[7][7] ), .A1N(n94), .Y(n85)
         );
  AND2X2M U91 ( .A(waddr[2]), .B(n16), .Y(n18) );
  NAND3X2M U92 ( .A(n12), .B(n114), .C(waddr[1]), .Y(n14) );
  NAND3X2M U93 ( .A(n12), .B(n115), .C(waddr[0]), .Y(n13) );
  NAND3X2M U94 ( .A(waddr[1]), .B(waddr[0]), .C(n18), .Y(n21) );
  NAND3X2M U95 ( .A(waddr[0]), .B(n115), .C(n18), .Y(n19) );
  NAND3X2M U96 ( .A(waddr[1]), .B(n114), .C(n18), .Y(n20) );
  INVX2M U97 ( .A(waddr[1]), .Y(n115) );
  INVX2M U98 ( .A(waddr[0]), .Y(n114) );
  MX2X2M U99 ( .A(n6), .B(n5), .S0(N11), .Y(rdata[2]) );
  MX4X1M U100 ( .A(\MEM[4][2] ), .B(\MEM[5][2] ), .C(\MEM[6][2] ), .D(
        \MEM[7][2] ), .S0(n92), .S1(N10), .Y(n5) );
  MX4X1M U101 ( .A(\MEM[0][2] ), .B(\MEM[1][2] ), .C(\MEM[2][2] ), .D(
        \MEM[3][2] ), .S0(n93), .S1(N10), .Y(n6) );
  MX2X2M U102 ( .A(n8), .B(n7), .S0(N11), .Y(rdata[3]) );
  MX4X1M U103 ( .A(\MEM[4][3] ), .B(\MEM[5][3] ), .C(\MEM[6][3] ), .D(
        \MEM[7][3] ), .S0(n92), .S1(N10), .Y(n7) );
  MX4X1M U104 ( .A(\MEM[0][3] ), .B(\MEM[1][3] ), .C(\MEM[2][3] ), .D(
        \MEM[3][3] ), .S0(n93), .S1(N10), .Y(n8) );
  MX2X2M U105 ( .A(n10), .B(n9), .S0(N11), .Y(rdata[4]) );
  MX4X1M U106 ( .A(\MEM[4][4] ), .B(\MEM[5][4] ), .C(\MEM[6][4] ), .D(
        \MEM[7][4] ), .S0(n92), .S1(N10), .Y(n9) );
  MX4X1M U107 ( .A(\MEM[0][4] ), .B(\MEM[1][4] ), .C(\MEM[2][4] ), .D(
        \MEM[3][4] ), .S0(n93), .S1(N10), .Y(n10) );
  MX2X2M U108 ( .A(n2), .B(n1), .S0(N11), .Y(rdata[0]) );
  MX4X1M U109 ( .A(\MEM[4][0] ), .B(\MEM[5][0] ), .C(\MEM[6][0] ), .D(
        \MEM[7][0] ), .S0(n92), .S1(N10), .Y(n1) );
  MX4X1M U110 ( .A(\MEM[0][0] ), .B(\MEM[1][0] ), .C(\MEM[2][0] ), .D(
        \MEM[3][0] ), .S0(n93), .S1(N10), .Y(n2) );
  MX2X2M U111 ( .A(n89), .B(n88), .S0(N11), .Y(rdata[6]) );
  MX4X1M U112 ( .A(\MEM[4][6] ), .B(\MEM[5][6] ), .C(\MEM[6][6] ), .D(
        \MEM[7][6] ), .S0(n92), .S1(N10), .Y(n88) );
  MX4X1M U113 ( .A(\MEM[0][6] ), .B(\MEM[1][6] ), .C(\MEM[2][6] ), .D(
        \MEM[3][6] ), .S0(n93), .S1(N10), .Y(n89) );
  MX2X2M U114 ( .A(n91), .B(n90), .S0(N11), .Y(rdata[7]) );
  MX4X1M U115 ( .A(\MEM[4][7] ), .B(\MEM[5][7] ), .C(\MEM[6][7] ), .D(
        \MEM[7][7] ), .S0(n92), .S1(N10), .Y(n90) );
  MX4X1M U116 ( .A(\MEM[0][7] ), .B(\MEM[1][7] ), .C(\MEM[2][7] ), .D(
        \MEM[3][7] ), .S0(n93), .S1(N10), .Y(n91) );
  MX2X2M U117 ( .A(n87), .B(n86), .S0(N11), .Y(rdata[5]) );
  MX4X1M U118 ( .A(\MEM[4][5] ), .B(\MEM[5][5] ), .C(\MEM[6][5] ), .D(
        \MEM[7][5] ), .S0(n92), .S1(N10), .Y(n86) );
  MX4X1M U119 ( .A(\MEM[0][5] ), .B(\MEM[1][5] ), .C(\MEM[2][5] ), .D(
        \MEM[3][5] ), .S0(n93), .S1(N10), .Y(n87) );
  MX2X2M U120 ( .A(n4), .B(n3), .S0(N11), .Y(rdata[1]) );
  MX4X1M U121 ( .A(\MEM[4][1] ), .B(\MEM[5][1] ), .C(\MEM[6][1] ), .D(
        \MEM[7][1] ), .S0(n92), .S1(N10), .Y(n3) );
  MX4X1M U122 ( .A(\MEM[0][1] ), .B(\MEM[1][1] ), .C(\MEM[2][1] ), .D(
        \MEM[3][1] ), .S0(n93), .S1(N10), .Y(n4) );
  BUFX2M U123 ( .A(N9), .Y(n93) );
  BUFX2M U124 ( .A(N9), .Y(n92) );
endmodule


module r_empty_P_SIZE4 ( rinc, rclk, rrst_n, rq2_wptr, rempty, raddr, g_rptr
 );
  input [3:0] rq2_wptr;
  output [2:0] raddr;
  output [3:0] g_rptr;
  input rinc, rclk, rrst_n;
  output rempty;
  wire   \bn_rptr[3] , n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n1, n2, n3, n4;

  DFFRQX2M \g_rptr_reg[0]  ( .D(n33), .CK(rclk), .RN(rrst_n), .Q(g_rptr[0]) );
  DFFRQX2M \g_rptr_reg[3]  ( .D(n26), .CK(rclk), .RN(rrst_n), .Q(g_rptr[3]) );
  DFFRQX2M \g_rptr_reg[2]  ( .D(n27), .CK(rclk), .RN(rrst_n), .Q(g_rptr[2]) );
  DFFRQX2M \g_rptr_reg[1]  ( .D(n28), .CK(rclk), .RN(rrst_n), .Q(g_rptr[1]) );
  DFFRQX2M \bn_rptr_reg[3]  ( .D(n29), .CK(rclk), .RN(rrst_n), .Q(\bn_rptr[3] ) );
  DFFRQX2M \bn_rptr_reg[0]  ( .D(n32), .CK(rclk), .RN(rrst_n), .Q(raddr[0]) );
  DFFRQX2M \bn_rptr_reg[2]  ( .D(n30), .CK(rclk), .RN(rrst_n), .Q(raddr[2]) );
  DFFRQX2M \bn_rptr_reg[1]  ( .D(n31), .CK(rclk), .RN(rrst_n), .Q(raddr[1]) );
  NOR3BX2M U3 ( .AN(n10), .B(n2), .C(n9), .Y(n8) );
  OAI2BB2X1M U4 ( .B0(n2), .B1(n11), .A0N(n4), .A1N(n16), .Y(n13) );
  XNOR2X2M U5 ( .A(n2), .B(n19), .Y(n31) );
  INVX2M U6 ( .A(n7), .Y(rempty) );
  XNOR2X2M U7 ( .A(g_rptr[1]), .B(rq2_wptr[1]), .Y(n21) );
  OAI211X2M U8 ( .A0(raddr[0]), .A1(n4), .B0(n14), .C0(n11), .Y(n9) );
  XNOR2X2M U9 ( .A(raddr[2]), .B(n18), .Y(n30) );
  NOR2BX2M U10 ( .AN(raddr[0]), .B(n20), .Y(n19) );
  XNOR2X2M U11 ( .A(raddr[0]), .B(n20), .Y(n32) );
  NAND4X2M U12 ( .A(n21), .B(n22), .C(n23), .D(n24), .Y(n7) );
  XNOR2X2M U13 ( .A(g_rptr[3]), .B(rq2_wptr[3]), .Y(n23) );
  XNOR2X2M U14 ( .A(g_rptr[2]), .B(rq2_wptr[2]), .Y(n24) );
  XNOR2X2M U15 ( .A(g_rptr[0]), .B(rq2_wptr[0]), .Y(n22) );
  NOR2X2M U16 ( .A(n3), .B(raddr[1]), .Y(n16) );
  OAI211X2M U17 ( .A0(raddr[2]), .A1(n10), .B0(n14), .C0(n15), .Y(n28) );
  AOI21X2M U18 ( .A0(n8), .A1(g_rptr[1]), .B0(n13), .Y(n15) );
  OAI211X2M U19 ( .A0(n3), .A1(n10), .B0(n11), .C0(n12), .Y(n27) );
  AOI21X2M U20 ( .A0(n8), .A1(g_rptr[2]), .B0(n13), .Y(n12) );
  NAND2X2M U21 ( .A(raddr[1]), .B(n4), .Y(n10) );
  NAND2X2M U22 ( .A(n19), .B(raddr[1]), .Y(n18) );
  NAND2X2M U23 ( .A(\bn_rptr[3] ), .B(n3), .Y(n11) );
  INVX2M U24 ( .A(raddr[1]), .Y(n2) );
  INVX2M U25 ( .A(raddr[2]), .Y(n3) );
  INVX2M U26 ( .A(\bn_rptr[3] ), .Y(n4) );
  NAND2X2M U27 ( .A(rinc), .B(n7), .Y(n20) );
  NAND2X2M U28 ( .A(n16), .B(\bn_rptr[3] ), .Y(n14) );
  OAI2BB1X2M U29 ( .A0N(g_rptr[0]), .A1N(n8), .B0(n25), .Y(n33) );
  XNOR2X2M U30 ( .A(raddr[0]), .B(raddr[1]), .Y(n25) );
  OAI211X2M U31 ( .A0(n1), .A1(n4), .B0(n17), .C0(n11), .Y(n29) );
  NAND3X2M U32 ( .A(raddr[2]), .B(n4), .C(n1), .Y(n17) );
  INVX2M U33 ( .A(n18), .Y(n1) );
  AO21XLM U34 ( .A0(g_rptr[3]), .A1(n8), .B0(n9), .Y(n26) );
endmodule


module w_full_POI_SIZE4 ( winc, wclk, wrst_n, wq2_rptr, wfull, waddr, g_wptr
 );
  input [3:0] wq2_rptr;
  output [2:0] waddr;
  output [3:0] g_wptr;
  input winc, wclk, wrst_n;
  output wfull;
  wire   \bn_wptr[3] , n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n1, n2, n3, n4, n5, n6, n7;

  DFFRQX2M \g_wptr_reg[3]  ( .D(n31), .CK(wclk), .RN(wrst_n), .Q(g_wptr[3]) );
  DFFRQX2M \g_wptr_reg[0]  ( .D(n1), .CK(wclk), .RN(wrst_n), .Q(g_wptr[0]) );
  DFFRQX2M \g_wptr_reg[1]  ( .D(n4), .CK(wclk), .RN(wrst_n), .Q(g_wptr[1]) );
  DFFRQX2M \g_wptr_reg[2]  ( .D(n32), .CK(wclk), .RN(wrst_n), .Q(g_wptr[2]) );
  DFFRQX2M \bn_wptr_reg[3]  ( .D(n33), .CK(wclk), .RN(wrst_n), .Q(\bn_wptr[3] ) );
  DFFRQX2M \bn_wptr_reg[2]  ( .D(n34), .CK(wclk), .RN(wrst_n), .Q(waddr[2]) );
  DFFRQX2M \bn_wptr_reg[0]  ( .D(n36), .CK(wclk), .RN(wrst_n), .Q(waddr[0]) );
  DFFRQX2M \bn_wptr_reg[1]  ( .D(n35), .CK(wclk), .RN(wrst_n), .Q(waddr[1]) );
  OAI2B11X2M U3 ( .A1N(n30), .A0(n7), .B0(n19), .C0(n14), .Y(n12) );
  NOR3X2M U4 ( .A(n5), .B(n16), .C(n12), .Y(n11) );
  XNOR2X2M U5 ( .A(n5), .B(n23), .Y(n35) );
  NAND2X2M U6 ( .A(winc), .B(n10), .Y(n24) );
  INVX2M U7 ( .A(n10), .Y(wfull) );
  NAND2X2M U8 ( .A(n20), .B(n7), .Y(n13) );
  INVX2M U9 ( .A(n29), .Y(n1) );
  AOI221XLM U10 ( .A0(n5), .A1(waddr[0]), .B0(g_wptr[0]), .B1(n11), .C0(n30), 
        .Y(n29) );
  INVX2M U11 ( .A(n17), .Y(n4) );
  AOI221XLM U12 ( .A0(n6), .A1(n16), .B0(g_wptr[1]), .B1(n11), .C0(n18), .Y(
        n17) );
  OAI211X2M U13 ( .A0(n14), .A1(n5), .B0(n13), .C0(n19), .Y(n18) );
  NAND3X2M U14 ( .A(n13), .B(n14), .C(n15), .Y(n32) );
  AOI22X1M U15 ( .A0(n16), .A1(waddr[2]), .B0(n11), .B1(g_wptr[2]), .Y(n15) );
  XNOR2X2M U16 ( .A(g_wptr[3]), .B(n7), .Y(n27) );
  XNOR2X2M U17 ( .A(waddr[0]), .B(n24), .Y(n36) );
  XNOR2X2M U18 ( .A(waddr[2]), .B(n22), .Y(n34) );
  INVX2M U19 ( .A(waddr[1]), .Y(n5) );
  NOR2X2M U20 ( .A(n24), .B(n3), .Y(n23) );
  INVX2M U21 ( .A(waddr[0]), .Y(n3) );
  NAND4X2M U22 ( .A(n25), .B(n26), .C(n27), .D(n28), .Y(n10) );
  XNOR2X2M U23 ( .A(n6), .B(g_wptr[2]), .Y(n28) );
  XNOR2X2M U24 ( .A(g_wptr[0]), .B(waddr[0]), .Y(n25) );
  XNOR2X2M U25 ( .A(g_wptr[1]), .B(waddr[1]), .Y(n26) );
  OAI211X2M U26 ( .A0(n2), .A1(n7), .B0(n21), .C0(n14), .Y(n33) );
  NAND3X2M U27 ( .A(waddr[2]), .B(n7), .C(n2), .Y(n21) );
  INVX2M U28 ( .A(n22), .Y(n2) );
  NAND2X2M U29 ( .A(n23), .B(waddr[1]), .Y(n22) );
  INVX2M U30 ( .A(\bn_wptr[3] ), .Y(n7) );
  NOR2X2M U31 ( .A(n5), .B(waddr[0]), .Y(n30) );
  INVX2M U32 ( .A(waddr[2]), .Y(n6) );
  NOR2X2M U33 ( .A(n6), .B(waddr[1]), .Y(n20) );
  NOR2X2M U34 ( .A(n5), .B(\bn_wptr[3] ), .Y(n16) );
  NAND2X2M U35 ( .A(\bn_wptr[3] ), .B(n6), .Y(n14) );
  NAND2X2M U36 ( .A(n20), .B(\bn_wptr[3] ), .Y(n19) );
  AO21XLM U37 ( .A0(g_wptr[3]), .A1(n11), .B0(n12), .Y(n31) );
endmodule


module Asynch_FIFO ( winc, wclk, wrst_n, rinc, rclk, rrst_n, wdata, rdata, 
        wfull, rempty );
  input [7:0] wdata;
  output [7:0] rdata;
  input winc, wclk, wrst_n, rinc, rclk, rrst_n;
  output wfull, rempty;
  wire   n1, n2;
  wire   [3:0] g_rptr;
  wire   [3:0] wq2_rptr;
  wire   [3:0] g_wptr;
  wire   [3:0] rq2_wptr;
  wire   [2:0] waddr;
  wire   [2:0] raddr;

  BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_0 u_r2w_sync ( .CLK(wclk), .RST(n1), .ASYNC(
        g_rptr), .SYNC(wq2_rptr) );
  BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_1 u_w2r_sync ( .CLK(rclk), .RST(rrst_n), 
        .ASYNC(g_wptr), .SYNC(rq2_wptr) );
  FIFO_mem_Data_Width8_DEPTH8_POI_SIZE4 fifomem ( .wclk(wclk), .wrst_n(n1), 
        .winc(winc), .wfull(wfull), .wdata(wdata), .waddr(waddr), .raddr(raddr), .rdata(rdata) );
  r_empty_P_SIZE4 rptr_empty ( .rinc(rinc), .rclk(rclk), .rrst_n(rrst_n), 
        .rq2_wptr(rq2_wptr), .rempty(rempty), .raddr(raddr), .g_rptr(g_rptr)
         );
  w_full_POI_SIZE4 wptr_full ( .winc(winc), .wclk(wclk), .wrst_n(n1), 
        .wq2_rptr(wq2_rptr), .wfull(wfull), .waddr(waddr), .g_wptr(g_wptr) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(wrst_n), .Y(n2) );
endmodule


module SYS_CTRL ( RX_P_DATA, RX_D_VLD, FIFO_FULL, ALU_OUT, OUT_Valid, Rd_D_Vld, 
        Rd_D, CLK, RST, WR_DATA, WR_INC, ALU_EN, ALU_FUN, Wr_D, Addr, RdEn, 
        CLK_EN, CLK_DIV_EN, WrEn );
  input [7:0] RX_P_DATA;
  input [15:0] ALU_OUT;
  input [7:0] Rd_D;
  output [7:0] WR_DATA;
  output [3:0] ALU_FUN;
  output [7:0] Wr_D;
  output [3:0] Addr;
  input RX_D_VLD, FIFO_FULL, OUT_Valid, Rd_D_Vld, CLK, RST;
  output WR_INC, ALU_EN, RdEn, CLK_EN, CLK_DIV_EN, WrEn;
  wire   n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n60, n61,
         n62;
  wire   [3:0] current_state;
  wire   [3:0] next_state;

  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  DFFRQX2M \current_state_reg[3]  ( .D(next_state[3]), .CK(CLK), .RN(RST), .Q(
        current_state[3]) );
  INVX2M U3 ( .A(1'b0), .Y(CLK_DIV_EN) );
  INVX2M U5 ( .A(1'b1), .Y(CLK_EN) );
  NOR2X2M U7 ( .A(n36), .B(n60), .Y(Addr[1]) );
  NOR2X2M U8 ( .A(n18), .B(n8), .Y(ALU_FUN[2]) );
  INVX2M U9 ( .A(ALU_EN), .Y(n8) );
  NAND2X2M U10 ( .A(n47), .B(n35), .Y(WrEn) );
  OA21X2M U11 ( .A0(n20), .A1(n62), .B0(n23), .Y(n47) );
  NOR2X2M U12 ( .A(n17), .B(n8), .Y(ALU_FUN[3]) );
  NOR2X2M U13 ( .A(n61), .B(n8), .Y(ALU_FUN[0]) );
  NOR2X2M U14 ( .A(n62), .B(n38), .Y(ALU_EN) );
  NOR2X2M U15 ( .A(n61), .B(n36), .Y(Addr[0]) );
  NOR2X2M U16 ( .A(n60), .B(n8), .Y(ALU_FUN[1]) );
  NOR2BX2M U17 ( .AN(n29), .B(n26), .Y(n20) );
  NOR2X2M U18 ( .A(n18), .B(n36), .Y(Addr[2]) );
  NOR2X2M U19 ( .A(n47), .B(n15), .Y(Wr_D[5]) );
  NOR2X2M U20 ( .A(n47), .B(n60), .Y(Wr_D[1]) );
  NOR2X2M U21 ( .A(n47), .B(n18), .Y(Wr_D[2]) );
  NOR2X2M U22 ( .A(n47), .B(n17), .Y(Wr_D[3]) );
  NOR2X2M U23 ( .A(n47), .B(n16), .Y(Wr_D[4]) );
  NOR2X2M U24 ( .A(n47), .B(n61), .Y(Wr_D[0]) );
  NAND2X2M U25 ( .A(n28), .B(n12), .Y(n35) );
  NOR2X2M U26 ( .A(n17), .B(n36), .Y(Addr[3]) );
  INVX2M U27 ( .A(n50), .Y(n5) );
  NAND2X2M U28 ( .A(n45), .B(n48), .Y(n23) );
  INVX2M U29 ( .A(n36), .Y(RdEn) );
  INVX2M U30 ( .A(n51), .Y(n11) );
  INVX2M U31 ( .A(n31), .Y(n10) );
  INVX2M U32 ( .A(n27), .Y(n6) );
  NOR3BX2M U33 ( .AN(n48), .B(current_state[0]), .C(n14), .Y(n26) );
  NOR3X2M U34 ( .A(current_state[1]), .B(current_state[3]), .C(n14), .Y(n49)
         );
  NAND3X2M U35 ( .A(n48), .B(n14), .C(current_state[0]), .Y(n36) );
  NOR2X2M U36 ( .A(n13), .B(current_state[3]), .Y(n48) );
  NAND2X2M U37 ( .A(n49), .B(current_state[0]), .Y(n29) );
  INVX2M U38 ( .A(RX_P_DATA[0]), .Y(n61) );
  NAND3X2M U39 ( .A(current_state[0]), .B(n48), .C(current_state[2]), .Y(n38)
         );
  INVX2M U40 ( .A(RX_P_DATA[1]), .Y(n60) );
  INVX2M U41 ( .A(RX_P_DATA[2]), .Y(n18) );
  INVX2M U42 ( .A(current_state[1]), .Y(n13) );
  INVX2M U43 ( .A(current_state[2]), .Y(n14) );
  INVX2M U44 ( .A(RX_D_VLD), .Y(n62) );
  NAND4X2M U45 ( .A(n31), .B(n22), .C(n32), .D(n33), .Y(next_state[0]) );
  NAND3X2M U46 ( .A(n61), .B(n16), .C(n42), .Y(n32) );
  AOI211X2M U47 ( .A0(n26), .A1(RX_D_VLD), .B0(n30), .C0(n34), .Y(n33) );
  AOI21X2M U48 ( .A0(n29), .A1(n35), .B0(RX_D_VLD), .Y(n34) );
  OAI2B11X2M U49 ( .A1N(OUT_Valid), .A0(n27), .B0(n50), .C0(n51), .Y(WR_INC)
         );
  NOR3X2M U50 ( .A(current_state[1]), .B(current_state[2]), .C(n7), .Y(n28) );
  OAI211X2M U51 ( .A0(RX_D_VLD), .A1(n36), .B0(n37), .C0(n19), .Y(n30) );
  NAND3X2M U52 ( .A(RX_P_DATA[4]), .B(RX_P_DATA[0]), .C(n42), .Y(n37) );
  NOR2X2M U53 ( .A(current_state[2]), .B(current_state[0]), .Y(n45) );
  NAND4BX1M U54 ( .AN(FIFO_FULL), .B(n7), .C(Rd_D_Vld), .D(n49), .Y(n50) );
  NOR2BX2M U55 ( .AN(RX_P_DATA[6]), .B(n47), .Y(Wr_D[6]) );
  NOR2BX2M U56 ( .AN(RX_P_DATA[7]), .B(n47), .Y(Wr_D[7]) );
  NAND4X2M U57 ( .A(OUT_Valid), .B(n45), .C(current_state[1]), .D(
        current_state[3]), .Y(n51) );
  AND4X2M U58 ( .A(RX_P_DATA[3]), .B(n45), .C(RX_P_DATA[7]), .D(n46), .Y(n41)
         );
  NOR3X2M U59 ( .A(n62), .B(current_state[3]), .C(current_state[1]), .Y(n46)
         );
  NAND2X2M U60 ( .A(n28), .B(current_state[3]), .Y(n27) );
  OAI2BB1X2M U61 ( .A0N(ALU_OUT[0]), .A1N(n10), .B0(n59), .Y(WR_DATA[0]) );
  AOI22X1M U62 ( .A0(Rd_D[0]), .A1(n5), .B0(ALU_OUT[8]), .B1(n11), .Y(n59) );
  OAI2BB1X2M U63 ( .A0N(ALU_OUT[1]), .A1N(n10), .B0(n58), .Y(WR_DATA[1]) );
  AOI22X1M U64 ( .A0(Rd_D[1]), .A1(n5), .B0(ALU_OUT[9]), .B1(n11), .Y(n58) );
  OAI2BB1X2M U65 ( .A0N(ALU_OUT[2]), .A1N(n10), .B0(n57), .Y(WR_DATA[2]) );
  AOI22X1M U66 ( .A0(Rd_D[2]), .A1(n5), .B0(ALU_OUT[10]), .B1(n11), .Y(n57) );
  OAI2BB1X2M U67 ( .A0N(ALU_OUT[3]), .A1N(n10), .B0(n56), .Y(WR_DATA[3]) );
  AOI22X1M U68 ( .A0(Rd_D[3]), .A1(n5), .B0(ALU_OUT[11]), .B1(n11), .Y(n56) );
  OAI2BB1X2M U69 ( .A0N(ALU_OUT[4]), .A1N(n10), .B0(n55), .Y(WR_DATA[4]) );
  AOI22X1M U70 ( .A0(Rd_D[4]), .A1(n5), .B0(ALU_OUT[12]), .B1(n11), .Y(n55) );
  OAI2BB1X2M U71 ( .A0N(ALU_OUT[5]), .A1N(n10), .B0(n54), .Y(WR_DATA[5]) );
  AOI22X1M U72 ( .A0(Rd_D[5]), .A1(n5), .B0(ALU_OUT[13]), .B1(n11), .Y(n54) );
  OAI2BB1X2M U73 ( .A0N(ALU_OUT[6]), .A1N(n10), .B0(n53), .Y(WR_DATA[6]) );
  AOI22X1M U74 ( .A0(Rd_D[6]), .A1(n5), .B0(ALU_OUT[14]), .B1(n11), .Y(n53) );
  OAI2BB1X2M U75 ( .A0N(ALU_OUT[7]), .A1N(n10), .B0(n52), .Y(WR_DATA[7]) );
  AOI22X1M U76 ( .A0(Rd_D[7]), .A1(n5), .B0(ALU_OUT[15]), .B1(n11), .Y(n52) );
  AND4X2M U77 ( .A(RX_P_DATA[5]), .B(RX_P_DATA[1]), .C(n43), .D(n41), .Y(n42)
         );
  NOR2X2M U78 ( .A(RX_P_DATA[6]), .B(RX_P_DATA[2]), .Y(n43) );
  OA22X2M U79 ( .A0(RX_D_VLD), .A1(n38), .B0(n39), .B1(n40), .Y(n19) );
  NAND3X2M U80 ( .A(RX_P_DATA[0]), .B(RX_P_DATA[6]), .C(RX_P_DATA[4]), .Y(n40)
         );
  NAND4X2M U81 ( .A(RX_P_DATA[2]), .B(n41), .C(n60), .D(n15), .Y(n39) );
  INVX2M U82 ( .A(current_state[3]), .Y(n12) );
  INVX2M U83 ( .A(current_state[0]), .Y(n7) );
  INVX2M U84 ( .A(RX_P_DATA[3]), .Y(n17) );
  OAI211X2M U85 ( .A0(RX_D_VLD), .A1(n23), .B0(n9), .C0(n24), .Y(next_state[1]) );
  AOI211X2M U86 ( .A0(RX_D_VLD), .A1(n25), .B0(n6), .C0(n26), .Y(n24) );
  INVX2M U87 ( .A(n30), .Y(n9) );
  NAND2BX2M U88 ( .AN(n28), .B(n29), .Y(n25) );
  OAI31X1M U89 ( .A0(n12), .A1(current_state[2]), .A2(current_state[1]), .B0(
        n8), .Y(next_state[3]) );
  NAND4X2M U90 ( .A(OUT_Valid), .B(n45), .C(current_state[3]), .D(n13), .Y(n31) );
  NAND4X2M U91 ( .A(RX_P_DATA[2]), .B(n41), .C(RX_P_DATA[6]), .D(n44), .Y(n22)
         );
  NOR4X1M U92 ( .A(RX_P_DATA[5]), .B(RX_P_DATA[4]), .C(RX_P_DATA[1]), .D(
        RX_P_DATA[0]), .Y(n44) );
  INVX2M U93 ( .A(RX_P_DATA[4]), .Y(n16) );
  INVX2M U94 ( .A(RX_P_DATA[5]), .Y(n15) );
  NAND3X2M U95 ( .A(n19), .B(n20), .C(n21), .Y(next_state[2]) );
  AOI21BX2M U96 ( .A0(RdEn), .A1(RX_D_VLD), .B0N(n22), .Y(n21) );
endmodule


module Pulse_Gen ( CLK, RST, en_sig, Pulse_en );
  input CLK, RST, en_sig;
  output Pulse_en;
  wire   sync_flop, meta_flop;

  DFFRQX2M meta_flop_reg ( .D(en_sig), .CK(CLK), .RN(RST), .Q(meta_flop) );
  DFFRQX2M sync_flop_reg ( .D(meta_flop), .CK(CLK), .RN(RST), .Q(sync_flop) );
  NOR2BX2M U3 ( .AN(meta_flop), .B(sync_flop), .Y(Pulse_en) );
endmodule


module SYSTEM ( REF_CLK, RST, UART_CLK, UART_RX_IN, UART_TX_OUT );
  input REF_CLK, RST, UART_CLK, UART_RX_IN;
  output UART_TX_OUT;
  wire   SYNC_UART_RST, UART_TX_CLK, UART_RX_CLK, UART_RX_Vld_OUT,
         UART_TX_Busy, F_EMPTY, SYNC_REF_RST, UART_RX_Vld_SYNC, ALU_CLK,
         RF_WrEn, RF_RdEn, RF_RdData_VLD, ALU_EN, ALU_OUT_VLD, WR_INC, RD_INC,
         FIFO_FULL, n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [7:0] UART_Config;
  wire   [7:0] UART_RX_OUT;
  wire   [7:0] RD_DATA;
  wire   [7:0] UART_RX_SYNC;
  wire   [7:0] DIV_RATIO;
  wire   [3:0] Addr;
  wire   [7:0] Wr_D;
  wire   [7:0] RF_RdData;
  wire   [7:0] Op_A;
  wire   [7:0] Op_B;
  wire   [3:0] ALU_FUN;
  wire   [15:0] ALU_OUT;
  wire   [7:0] WR_DATA;

  UART U0_UART ( .RST(n8), .TX_CLK(UART_TX_CLK), .RX_CLK(UART_RX_CLK), 
        .RX_IN_S(UART_RX_IN), .RX_OUT_P(UART_RX_OUT), .RX_OUT_V(
        UART_RX_Vld_OUT), .TX_IN_P(RD_DATA), .TX_IN_V(n1), .TX_OUT_S(
        UART_TX_OUT), .TX_OUT_V(UART_TX_Busy), .Prescale(UART_Config[7:2]), 
        .parity_enable(UART_Config[0]), .parity_type(UART_Config[1]) );
  RST_SYNC_0 RST_SYNC_1 ( .RST(RST), .CLK(REF_CLK), .SYNC_RST(SYNC_REF_RST) );
  RST_SYNC_1 RST_SYNC_2 ( .RST(RST), .CLK(UART_CLK), .SYNC_RST(SYNC_UART_RST)
         );
  DATA_SYNC U0_ref_sync ( .CLK(REF_CLK), .RST(n6), .unsync_bus(UART_RX_OUT), 
        .bus_enable(UART_RX_Vld_OUT), .sync_bus(UART_RX_SYNC), 
        .enable_pulse_d(UART_RX_Vld_SYNC) );
  ClkDiv_0 U0_ClkDiv ( .i_ref_clk(UART_CLK), .i_rst(n8), .i_clk_en(1'b1), 
        .i_div_ratio(DIV_RATIO), .o_div_clk(UART_TX_CLK) );
  ClkDiv_1 U1_ClkDiv ( .i_ref_clk(UART_CLK), .i_rst(n8), .i_clk_en(1'b1), 
        .i_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0}), 
        .o_div_clk(UART_RX_CLK) );
  CLK_GATE U0_CLK_GATE ( .CLK_EN(1'b0), .CLK(REF_CLK), .GATED_CLK(ALU_CLK) );
  REG_FILE U0_RegFile ( .WrData(Wr_D), .Address(Addr), .WrEn(RF_WrEn), .RdEn(
        RF_RdEn), .CLK(REF_CLK), .RST(n6), .RdData(RF_RdData), .RdData_VLD(
        RF_RdData_VLD), .REG0(Op_A), .REG1(Op_B), .REG2(UART_Config), .REG3(
        DIV_RATIO) );
  ALU U0_ALU ( .A(Op_A), .B({Op_B[7:5], n3, Op_B[3:1], n5}), .ALU_FUN(ALU_FUN), 
        .EN(ALU_EN), .CLK(ALU_CLK), .RST(n6), .ALU_OUT(ALU_OUT), .OUT_VALID(
        ALU_OUT_VLD) );
  Asynch_FIFO F1_fifo ( .winc(WR_INC), .wclk(REF_CLK), .wrst_n(n6), .rinc(
        RD_INC), .rclk(UART_TX_CLK), .rrst_n(n8), .wdata(WR_DATA), .rdata(
        RD_DATA), .wfull(FIFO_FULL), .rempty(F_EMPTY) );
  SYS_CTRL C0_CTRL ( .RX_P_DATA(UART_RX_SYNC), .RX_D_VLD(UART_RX_Vld_SYNC), 
        .FIFO_FULL(FIFO_FULL), .ALU_OUT(ALU_OUT), .OUT_Valid(ALU_OUT_VLD), 
        .Rd_D_Vld(RF_RdData_VLD), .Rd_D(RF_RdData), .CLK(REF_CLK), .RST(n6), 
        .WR_DATA(WR_DATA), .WR_INC(WR_INC), .ALU_EN(ALU_EN), .ALU_FUN(ALU_FUN), 
        .Wr_D(Wr_D), .Addr(Addr), .RdEn(RF_RdEn), .WrEn(RF_WrEn) );
  Pulse_Gen PUL_GEN_1 ( .CLK(UART_TX_CLK), .RST(n8), .en_sig(UART_TX_Busy), 
        .Pulse_en(RD_INC) );
  INVX2M U4 ( .A(n4), .Y(n5) );
  INVX2M U5 ( .A(Op_B[0]), .Y(n4) );
  INVX2M U6 ( .A(n2), .Y(n3) );
  INVX2M U7 ( .A(Op_B[4]), .Y(n2) );
  INVX2M U8 ( .A(F_EMPTY), .Y(n1) );
  INVX4M U9 ( .A(n7), .Y(n6) );
  INVX2M U10 ( .A(SYNC_REF_RST), .Y(n7) );
  INVX4M U11 ( .A(n9), .Y(n8) );
  INVX2M U12 ( .A(SYNC_UART_RST), .Y(n9) );
endmodule

