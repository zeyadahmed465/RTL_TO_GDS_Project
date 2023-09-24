/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sat Sep 23 17:42:53 2023
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module mux2X1_4 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module RST_SYNC_test_0 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  SDFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(\sync_reg[0] ) );
  SDFFRQX1M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .SI(\sync_reg[0] ), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module mux2X1_6 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module RST_SYNC_test_1 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  SDFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(\sync_reg[0] ) );
  SDFFRQX1M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .SI(\sync_reg[0] ), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module mux2X1_5 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module DATA_SYNC_test_1 ( CLK, RST, unsync_bus, bus_enable, sync_bus, 
        enable_pulse_d, test_si, test_so, test_se );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input CLK, RST, bus_enable, test_si, test_se;
  output enable_pulse_d, test_so;
  wire   enable_flop, n1, n4, n6, n8, n10, n12, n14, n16, n18, n23;
  wire   [1:0] sync_reg;
  assign test_so = sync_reg[1];

  SDFFRQX2M enable_flop_reg ( .D(sync_reg[1]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(enable_flop) );
  SDFFRQX2M \sync_bus_reg[7]  ( .D(n18), .SI(sync_bus[6]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[7]) );
  SDFFRQX2M \sync_bus_reg[5]  ( .D(n14), .SI(sync_bus[4]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[5]) );
  SDFFRQX2M \sync_bus_reg[6]  ( .D(n16), .SI(sync_bus[5]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[6]) );
  SDFFRQX2M \sync_bus_reg[4]  ( .D(n12), .SI(sync_bus[3]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[4]) );
  SDFFRQX2M \sync_bus_reg[3]  ( .D(n10), .SI(sync_bus[2]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[3]) );
  SDFFRQX2M \sync_bus_reg[1]  ( .D(n6), .SI(sync_bus[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[1]) );
  SDFFRQX2M enable_pulse_d_reg ( .D(n23), .SI(enable_flop), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(enable_pulse_d) );
  SDFFRQX2M \sync_bus_reg[2]  ( .D(n8), .SI(sync_bus[1]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_bus[2]) );
  SDFFRQX2M \sync_bus_reg[0]  ( .D(n4), .SI(enable_pulse_d), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(sync_bus[0]) );
  SDFFRQX2M \sync_reg_reg[0]  ( .D(bus_enable), .SI(sync_bus[7]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(sync_reg[0]) );
  SDFFRQX1M \sync_reg_reg[1]  ( .D(sync_reg[0]), .SI(sync_reg[0]), .SE(test_se), .CK(CLK), .RN(RST), .Q(sync_reg[1]) );
  INVX2M U4 ( .A(n1), .Y(n23) );
  NAND2BX2M U5 ( .AN(enable_flop), .B(sync_reg[1]), .Y(n1) );
  AO22X1M U6 ( .A0(unsync_bus[0]), .A1(n23), .B0(sync_bus[0]), .B1(n1), .Y(n4)
         );
  AO22X1M U7 ( .A0(unsync_bus[1]), .A1(n23), .B0(sync_bus[1]), .B1(n1), .Y(n6)
         );
  AO22X1M U8 ( .A0(unsync_bus[2]), .A1(n23), .B0(sync_bus[2]), .B1(n1), .Y(n8)
         );
  AO22X1M U9 ( .A0(unsync_bus[3]), .A1(n23), .B0(sync_bus[3]), .B1(n1), .Y(n10) );
  AO22X1M U10 ( .A0(unsync_bus[4]), .A1(n23), .B0(sync_bus[4]), .B1(n1), .Y(
        n12) );
  AO22X1M U11 ( .A0(unsync_bus[5]), .A1(n23), .B0(sync_bus[5]), .B1(n1), .Y(
        n14) );
  AO22X1M U12 ( .A0(unsync_bus[6]), .A1(n23), .B0(sync_bus[6]), .B1(n1), .Y(
        n16) );
  AO22X1M U25 ( .A0(unsync_bus[7]), .A1(n23), .B0(sync_bus[7]), .B1(n1), .Y(
        n18) );
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


module ClkDiv_test_0 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk, 
        test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   N2, div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n3, n4, n5, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;
  assign test_so = odd_edge_tog;

  SDFFRQX2M \count_reg[6]  ( .D(n28), .SI(count[5]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[6]) );
  SDFFRQX2M \count_reg[0]  ( .D(n34), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[0]) );
  SDFFRQX2M \count_reg[5]  ( .D(n29), .SI(count[4]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[5]) );
  SDFFRQX2M \count_reg[4]  ( .D(n30), .SI(count[3]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[4]) );
  SDFFRQX2M \count_reg[3]  ( .D(n31), .SI(count[2]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[3]) );
  SDFFRQX2M \count_reg[2]  ( .D(n32), .SI(count[1]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[2]) );
  SDFFRQX2M \count_reg[1]  ( .D(n33), .SI(count[0]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[1]) );
  SDFFSQX1M odd_edge_tog_reg ( .D(n26), .SI(div_clk), .SE(test_se), .CK(
        i_ref_clk), .SN(i_rst), .Q(odd_edge_tog) );
  SDFFRQX1M div_clk_reg ( .D(n27), .SI(count[6]), .SE(test_se), .CK(i_ref_clk), 
        .RN(i_rst), .Q(div_clk) );
  OR2X2M U11 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n3) );
  NAND2BX2M U15 ( .AN(n52), .B(i_clk_en), .Y(n18) );
  INVX2M U16 ( .A(i_div_ratio[5]), .Y(n17) );
  MX2X2M U17 ( .A(i_ref_clk), .B(div_clk), .S0(N2), .Y(o_div_clk) );
  CLKINVX1M U18 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  OAI2BB1X1M U19 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n3), .Y(
        edge_flip_half[1]) );
  OR2X1M U20 ( .A(n3), .B(i_div_ratio[3]), .Y(n4) );
  OAI2BB1X1M U21 ( .A0N(n3), .A1N(i_div_ratio[3]), .B0(n4), .Y(
        edge_flip_half[2]) );
  NOR2X1M U22 ( .A(n4), .B(i_div_ratio[4]), .Y(n5) );
  AO21XLM U23 ( .A0(n4), .A1(i_div_ratio[4]), .B0(n5), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U24 ( .A(n5), .B(n17), .Y(n15) );
  OAI21X1M U25 ( .A0(n5), .A1(n17), .B0(n15), .Y(edge_flip_half[4]) );
  XNOR2X1M U26 ( .A(i_div_ratio[6]), .B(n15), .Y(edge_flip_half[5]) );
  NOR2X1M U27 ( .A(i_div_ratio[6]), .B(n15), .Y(n16) );
  CLKXOR2X2M U28 ( .A(i_div_ratio[7]), .B(n16), .Y(edge_flip_half[6]) );
  AO22X1M U29 ( .A0(n18), .A1(count[0]), .B0(N16), .B1(n19), .Y(n34) );
  AO22X1M U30 ( .A0(n18), .A1(count[1]), .B0(N17), .B1(n19), .Y(n33) );
  AO22X1M U31 ( .A0(n18), .A1(count[2]), .B0(N18), .B1(n19), .Y(n32) );
  AO22X1M U32 ( .A0(n18), .A1(count[3]), .B0(N19), .B1(n19), .Y(n31) );
  AO22X1M U33 ( .A0(n18), .A1(count[4]), .B0(N20), .B1(n19), .Y(n30) );
  AO22X1M U34 ( .A0(n18), .A1(count[5]), .B0(N21), .B1(n19), .Y(n29) );
  AO22X1M U35 ( .A0(n18), .A1(count[6]), .B0(N22), .B1(n19), .Y(n28) );
  AND3X1M U36 ( .A(n20), .B(n21), .C(N2), .Y(n19) );
  CLKXOR2X2M U37 ( .A(div_clk), .B(n22), .Y(n27) );
  AOI21X1M U38 ( .A0(n21), .A1(n20), .B0(n18), .Y(n22) );
  OR2X1M U39 ( .A(n23), .B(i_div_ratio[0]), .Y(n20) );
  XNOR2X1M U40 ( .A(odd_edge_tog), .B(n24), .Y(n26) );
  OR2X1M U41 ( .A(n21), .B(n18), .Y(n24) );
  CLKNAND2X2M U42 ( .A(n25), .B(i_div_ratio[0]), .Y(n21) );
  MXI2X1M U43 ( .A(n35), .B(n23), .S0(odd_edge_tog), .Y(n25) );
  NAND4X1M U44 ( .A(n36), .B(n37), .C(n38), .D(n39), .Y(n23) );
  NOR4X1M U45 ( .A(n40), .B(n41), .C(n42), .D(n43), .Y(n39) );
  CLKXOR2X2M U46 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n43) );
  CLKXOR2X2M U47 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n42) );
  CLKXOR2X2M U48 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n41) );
  CLKXOR2X2M U49 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n40) );
  XNOR2X1M U50 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n38) );
  XNOR2X1M U51 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n37) );
  XNOR2X1M U52 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n36) );
  NAND4X1M U53 ( .A(n44), .B(n45), .C(n46), .D(n47), .Y(n35) );
  NOR4X1M U54 ( .A(n48), .B(n49), .C(n50), .D(n51), .Y(n47) );
  CLKXOR2X2M U55 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n51) );
  CLKXOR2X2M U56 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n50) );
  CLKXOR2X2M U57 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n49) );
  CLKXOR2X2M U58 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n48) );
  XNOR2X1M U59 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n46) );
  XNOR2X1M U60 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n45) );
  XNOR2X1M U61 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n44) );
  CLKINVX1M U62 ( .A(n18), .Y(N2) );
  NOR4BX1M U63 ( .AN(n53), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n52) );
  NOR4X1M U64 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n53) );
  ClkDiv_0_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
endmodule


module mux2X1_3 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
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


module ClkDiv_test_1 ( i_ref_clk, i_rst, i_clk_en, i_div_ratio, o_div_clk, 
        test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   N2, div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n3, n4,
         n5, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n74, n75,
         n76;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;
  assign test_so = odd_edge_tog;

  SDFFRQX2M \count_reg[5]  ( .D(n59), .SI(count[4]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[5]) );
  SDFFRQX2M \count_reg[4]  ( .D(n58), .SI(count[3]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[4]) );
  SDFFRQX2M \count_reg[3]  ( .D(n57), .SI(count[2]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[3]) );
  SDFFRQX2M \count_reg[6]  ( .D(n60), .SI(count[5]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[6]) );
  SDFFRQX2M \count_reg[0]  ( .D(n54), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[0]) );
  SDFFRQX2M \count_reg[2]  ( .D(n56), .SI(count[1]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[2]) );
  SDFFRQX2M \count_reg[1]  ( .D(n55), .SI(count[0]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst), .Q(count[1]) );
  SDFFRQX1M div_clk_reg ( .D(n61), .SI(count[6]), .SE(test_se), .CK(i_ref_clk), 
        .RN(i_rst), .Q(div_clk) );
  NAND2BX2M U11 ( .AN(n52), .B(i_clk_en), .Y(n18) );
  INVX2M U15 ( .A(i_div_ratio[5]), .Y(n17) );
  OR2X2M U16 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n3) );
  MX2X2M U17 ( .A(i_ref_clk), .B(div_clk), .S0(N2), .Y(o_div_clk) );
  CLKINVX1M U18 ( .A(i_div_ratio[1]), .Y(edge_flip_half[0]) );
  OAI2BB1X1M U19 ( .A0N(i_div_ratio[1]), .A1N(i_div_ratio[2]), .B0(n3), .Y(
        edge_flip_half[1]) );
  OR2X1M U20 ( .A(n3), .B(i_div_ratio[3]), .Y(n4) );
  OAI2BB1X1M U21 ( .A0N(n3), .A1N(i_div_ratio[3]), .B0(n4), .Y(
        edge_flip_half[2]) );
  NOR2X1M U22 ( .A(n4), .B(i_div_ratio[4]), .Y(n5) );
  AO21XLM U23 ( .A0(n4), .A1(i_div_ratio[4]), .B0(n5), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U24 ( .A(n5), .B(n17), .Y(n15) );
  OAI21X1M U25 ( .A0(n5), .A1(n17), .B0(n15), .Y(edge_flip_half[4]) );
  XNOR2X1M U26 ( .A(i_div_ratio[6]), .B(n15), .Y(edge_flip_half[5]) );
  NOR2X1M U27 ( .A(i_div_ratio[6]), .B(n15), .Y(n16) );
  CLKXOR2X2M U28 ( .A(i_div_ratio[7]), .B(n16), .Y(edge_flip_half[6]) );
  AO22X1M U29 ( .A0(n18), .A1(count[0]), .B0(N16), .B1(n19), .Y(n54) );
  AO22X1M U30 ( .A0(n18), .A1(count[1]), .B0(N17), .B1(n19), .Y(n55) );
  AO22X1M U31 ( .A0(n18), .A1(count[2]), .B0(N18), .B1(n19), .Y(n56) );
  AO22X1M U32 ( .A0(n18), .A1(count[3]), .B0(N19), .B1(n19), .Y(n57) );
  AO22X1M U33 ( .A0(n18), .A1(count[4]), .B0(N20), .B1(n19), .Y(n58) );
  AO22X1M U34 ( .A0(n18), .A1(count[5]), .B0(N21), .B1(n19), .Y(n59) );
  AO22X1M U35 ( .A0(n18), .A1(count[6]), .B0(N22), .B1(n19), .Y(n60) );
  AND3X1M U36 ( .A(n20), .B(n21), .C(N2), .Y(n19) );
  CLKXOR2X2M U37 ( .A(div_clk), .B(n22), .Y(n61) );
  AOI21X1M U38 ( .A0(n21), .A1(n20), .B0(n18), .Y(n22) );
  OR2X1M U39 ( .A(n23), .B(i_div_ratio[0]), .Y(n20) );
  XNOR2X1M U40 ( .A(n76), .B(n24), .Y(n62) );
  OR2X1M U41 ( .A(n21), .B(n18), .Y(n24) );
  CLKNAND2X2M U42 ( .A(n25), .B(i_div_ratio[0]), .Y(n21) );
  MXI2X1M U43 ( .A(n35), .B(n23), .S0(n76), .Y(n25) );
  NAND4X1M U44 ( .A(n36), .B(n37), .C(n38), .D(n39), .Y(n23) );
  NOR4X1M U45 ( .A(n40), .B(n41), .C(n42), .D(n43), .Y(n39) );
  CLKXOR2X2M U46 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n43) );
  CLKXOR2X2M U47 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n42) );
  CLKXOR2X2M U48 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n41) );
  CLKXOR2X2M U49 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n40) );
  XNOR2X1M U50 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n38) );
  XNOR2X1M U51 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n37) );
  XNOR2X1M U52 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n36) );
  NAND4X1M U53 ( .A(n44), .B(n45), .C(n46), .D(n47), .Y(n35) );
  NOR4X1M U54 ( .A(n48), .B(n49), .C(n50), .D(n51), .Y(n47) );
  CLKXOR2X2M U55 ( .A(i_div_ratio[3]), .B(count[2]), .Y(n51) );
  CLKXOR2X2M U56 ( .A(i_div_ratio[2]), .B(count[1]), .Y(n50) );
  CLKXOR2X2M U57 ( .A(i_div_ratio[1]), .B(count[0]), .Y(n49) );
  CLKXOR2X2M U58 ( .A(i_div_ratio[7]), .B(count[6]), .Y(n48) );
  XNOR2X1M U59 ( .A(count[4]), .B(i_div_ratio[5]), .Y(n46) );
  XNOR2X1M U60 ( .A(count[5]), .B(i_div_ratio[6]), .Y(n45) );
  XNOR2X1M U61 ( .A(count[3]), .B(i_div_ratio[4]), .Y(n44) );
  CLKINVX1M U62 ( .A(n18), .Y(N2) );
  NOR4BX1M U63 ( .AN(n53), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n52) );
  NOR4X1M U64 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n53) );
  INVXLM U66 ( .A(n74), .Y(n75) );
  DLY1X1M U67 ( .A(n75), .Y(n76) );
  ClkDiv_1_DW01_inc_0 add_49 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  SDFFSX2M odd_edge_tog_reg ( .D(n62), .SI(div_clk), .SE(test_se), .CK(
        i_ref_clk), .SN(i_rst), .Q(odd_edge_tog), .QN(n74) );
endmodule


module mux2X1_2 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;
  wire   N0;
  assign N0 = SEL;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX12M U0_TLATNCAX12M ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module REG_FILE_test_1 ( WrData, Address, WrEn, RdEn, CLK, RST, RdData, 
        RdData_VLD, REG0, REG1, REG2, REG3, test_si3, test_si2, test_si1, 
        test_so2, test_so1, test_se );
  input [7:0] WrData;
  input [3:0] Address;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input WrEn, RdEn, CLK, RST, test_si3, test_si2, test_si1, test_se;
  output RdData_VLD, test_so2, test_so1;
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
         \Reg_File[6][2] , \Reg_File[6][1] , \Reg_File[6][0] , n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n188, n189, n190, n191, n197, n198, n199, n200, n201,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n281, n282, n283, n284,
         n285, n286, n287, n288, n289, n291, n292, n293, n294, n295, n296,
         n297, n298, n299, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n311, n312, n313, n314, n315, n316, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n186, n208, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n236,
         n250, n260, n270, n280, n290, n310, n473, n476, n478, n480, n482,
         n483, n484, n485, n486, n487, n488, n489, n490, n491, n492, n493,
         n494, n495, n496, n497, n498, n499, n500, n501, n502, n503, n504,
         n505, n506, n508, n509, n510, n511, n512, n513, n514, n515, n516,
         n517, n518, n519, n520, n521, n522, n523, n524, n525, n526, n527,
         n528, n529, n530, n531, n532, n533, n534, n535, n536, n537, n538,
         n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549,
         n550, n551, n552, n553, n554, n555, n556, n557, n558, n563, n564,
         n565, n566;
  assign test_so1 = \Reg_File[13][6] ;

  SDFFRHQX4M \Reg_File_reg[1][7]  ( .D(n359), .SI(REG1[6]), .SE(n564), .CK(CLK), .RN(n222), .Q(REG1[7]) );
  SDFFRQX2M \Reg_File_reg[2][2]  ( .D(n362), .SI(REG2[1]), .SE(n563), .CK(CLK), 
        .RN(n222), .Q(REG2[2]) );
  SDFFRQX2M \Reg_File_reg[6][7]  ( .D(n399), .SI(\Reg_File[6][6] ), .SE(n566), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][7] ) );
  SDFFRQX2M \Reg_File_reg[6][6]  ( .D(n398), .SI(\Reg_File[6][5] ), .SE(n565), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][6] ) );
  SDFFRQX2M \Reg_File_reg[6][5]  ( .D(n397), .SI(\Reg_File[6][4] ), .SE(n564), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][5] ) );
  SDFFRQX2M \Reg_File_reg[6][4]  ( .D(n396), .SI(\Reg_File[6][3] ), .SE(n563), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][4] ) );
  SDFFRQX2M \Reg_File_reg[6][3]  ( .D(n395), .SI(\Reg_File[6][2] ), .SE(n566), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][3] ) );
  SDFFRQX2M \Reg_File_reg[6][2]  ( .D(n394), .SI(\Reg_File[6][1] ), .SE(n565), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][2] ) );
  SDFFRQX2M \Reg_File_reg[6][1]  ( .D(n393), .SI(\Reg_File[6][0] ), .SE(n564), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[6][1] ) );
  SDFFRQX2M \Reg_File_reg[6][0]  ( .D(n392), .SI(n539), .SE(n563), .CK(CLK), 
        .RN(n223), .Q(\Reg_File[6][0] ) );
  SDFFRQX2M \RdData_reg[7]  ( .D(n342), .SI(RdData[6]), .SE(n566), .CK(CLK), 
        .RN(n222), .Q(RdData[7]) );
  SDFFRQX2M \RdData_reg[6]  ( .D(n341), .SI(RdData[5]), .SE(n565), .CK(CLK), 
        .RN(n223), .Q(RdData[6]) );
  SDFFRQX2M \RdData_reg[5]  ( .D(n340), .SI(RdData[4]), .SE(n564), .CK(CLK), 
        .RN(n223), .Q(RdData[5]) );
  SDFFRQX2M \RdData_reg[4]  ( .D(n339), .SI(RdData[3]), .SE(n563), .CK(CLK), 
        .RN(n222), .Q(RdData[4]) );
  SDFFRQX2M \RdData_reg[3]  ( .D(n338), .SI(RdData[2]), .SE(n566), .CK(CLK), 
        .RN(n223), .Q(RdData[3]) );
  SDFFRQX2M \RdData_reg[2]  ( .D(n337), .SI(RdData[1]), .SE(n565), .CK(CLK), 
        .RN(n222), .Q(RdData[2]) );
  SDFFRQX2M \RdData_reg[1]  ( .D(n336), .SI(RdData[0]), .SE(n564), .CK(CLK), 
        .RN(n222), .Q(RdData[1]) );
  SDFFRQX2M \RdData_reg[0]  ( .D(n335), .SI(RdData_VLD), .SE(n563), .CK(CLK), 
        .RN(n223), .Q(RdData[0]) );
  SDFFRQX2M \Reg_File_reg[7][7]  ( .D(n407), .SI(\Reg_File[7][6] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[7][7] ) );
  SDFFRQX2M \Reg_File_reg[7][6]  ( .D(n406), .SI(\Reg_File[7][5] ), .SE(n565), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[7][6] ) );
  SDFFRQX2M \Reg_File_reg[7][5]  ( .D(n405), .SI(\Reg_File[7][4] ), .SE(n564), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[7][5] ) );
  SDFFRQX2M \Reg_File_reg[7][4]  ( .D(n404), .SI(\Reg_File[7][3] ), .SE(n563), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[7][4] ) );
  SDFFRQX2M \Reg_File_reg[7][3]  ( .D(n403), .SI(\Reg_File[7][2] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[7][3] ) );
  SDFFRQX2M \Reg_File_reg[7][2]  ( .D(n402), .SI(\Reg_File[7][1] ), .SE(n565), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[7][2] ) );
  SDFFRQX2M \Reg_File_reg[7][1]  ( .D(n401), .SI(\Reg_File[7][0] ), .SE(n564), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[7][1] ) );
  SDFFRQX2M \Reg_File_reg[7][0]  ( .D(n400), .SI(\Reg_File[6][7] ), .SE(n563), 
        .CK(CLK), .RN(n223), .Q(\Reg_File[7][0] ) );
  SDFFRQX2M \Reg_File_reg[13][7]  ( .D(n455), .SI(test_si3), .SE(n566), .CK(
        CLK), .RN(n223), .Q(\Reg_File[13][7] ) );
  SDFFRQX2M \Reg_File_reg[13][6]  ( .D(n454), .SI(\Reg_File[13][5] ), .SE(n565), .CK(CLK), .RN(n236), .Q(\Reg_File[13][6] ) );
  SDFFRQX2M \Reg_File_reg[13][5]  ( .D(n453), .SI(\Reg_File[13][4] ), .SE(n564), .CK(CLK), .RN(n236), .Q(\Reg_File[13][5] ) );
  SDFFRQX2M \Reg_File_reg[13][4]  ( .D(n452), .SI(\Reg_File[13][3] ), .SE(n563), .CK(CLK), .RN(n236), .Q(\Reg_File[13][4] ) );
  SDFFRQX2M \Reg_File_reg[13][3]  ( .D(n451), .SI(\Reg_File[13][2] ), .SE(n566), .CK(CLK), .RN(n236), .Q(\Reg_File[13][3] ) );
  SDFFRQX2M \Reg_File_reg[13][2]  ( .D(n450), .SI(\Reg_File[13][1] ), .SE(n565), .CK(CLK), .RN(n236), .Q(\Reg_File[13][2] ) );
  SDFFRQX2M \Reg_File_reg[13][1]  ( .D(n449), .SI(\Reg_File[13][0] ), .SE(n564), .CK(CLK), .RN(n236), .Q(\Reg_File[13][1] ) );
  SDFFRQX2M \Reg_File_reg[13][0]  ( .D(n448), .SI(\Reg_File[12][7] ), .SE(n563), .CK(CLK), .RN(n236), .Q(\Reg_File[13][0] ) );
  SDFFRQX2M \Reg_File_reg[9][7]  ( .D(n423), .SI(\Reg_File[9][6] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][7] ) );
  SDFFRQX2M \Reg_File_reg[9][6]  ( .D(n422), .SI(\Reg_File[9][5] ), .SE(n565), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][6] ) );
  SDFFRQX2M \Reg_File_reg[9][5]  ( .D(n421), .SI(\Reg_File[9][4] ), .SE(n564), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][5] ) );
  SDFFRQX2M \Reg_File_reg[9][4]  ( .D(n420), .SI(\Reg_File[9][3] ), .SE(n563), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][4] ) );
  SDFFRQX2M \Reg_File_reg[9][3]  ( .D(n419), .SI(\Reg_File[9][2] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][3] ) );
  SDFFRQX2M \Reg_File_reg[9][2]  ( .D(n418), .SI(\Reg_File[9][1] ), .SE(n565), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][2] ) );
  SDFFRQX2M \Reg_File_reg[9][1]  ( .D(n417), .SI(\Reg_File[9][0] ), .SE(n564), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][1] ) );
  SDFFRQX2M \Reg_File_reg[9][0]  ( .D(n416), .SI(\Reg_File[8][7] ), .SE(n563), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[9][0] ) );
  SDFFRQX2M \Reg_File_reg[12][7]  ( .D(n447), .SI(\Reg_File[12][6] ), .SE(n566), .CK(CLK), .RN(n236), .Q(\Reg_File[12][7] ) );
  SDFFRQX2M \Reg_File_reg[12][6]  ( .D(n446), .SI(\Reg_File[12][5] ), .SE(n565), .CK(CLK), .RN(n236), .Q(\Reg_File[12][6] ) );
  SDFFRQX2M \Reg_File_reg[12][5]  ( .D(n445), .SI(\Reg_File[12][4] ), .SE(n564), .CK(CLK), .RN(n236), .Q(\Reg_File[12][5] ) );
  SDFFRQX2M \Reg_File_reg[12][4]  ( .D(n444), .SI(\Reg_File[12][3] ), .SE(n563), .CK(CLK), .RN(n236), .Q(\Reg_File[12][4] ) );
  SDFFRQX2M \Reg_File_reg[12][3]  ( .D(n443), .SI(\Reg_File[12][2] ), .SE(n566), .CK(CLK), .RN(n236), .Q(\Reg_File[12][3] ) );
  SDFFRQX2M \Reg_File_reg[12][2]  ( .D(n442), .SI(\Reg_File[12][1] ), .SE(n565), .CK(CLK), .RN(n236), .Q(\Reg_File[12][2] ) );
  SDFFRQX2M \Reg_File_reg[12][1]  ( .D(n441), .SI(\Reg_File[12][0] ), .SE(n564), .CK(CLK), .RN(n236), .Q(\Reg_File[12][1] ) );
  SDFFRQX2M \Reg_File_reg[12][0]  ( .D(n440), .SI(n523), .SE(n563), .CK(CLK), 
        .RN(n224), .Q(\Reg_File[12][0] ) );
  SDFFRQX2M \Reg_File_reg[8][7]  ( .D(n415), .SI(\Reg_File[8][6] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][7] ) );
  SDFFRQX2M \Reg_File_reg[8][6]  ( .D(n414), .SI(\Reg_File[8][5] ), .SE(n565), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][6] ) );
  SDFFRQX2M \Reg_File_reg[8][5]  ( .D(n413), .SI(\Reg_File[8][4] ), .SE(n564), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][5] ) );
  SDFFRQX2M \Reg_File_reg[8][4]  ( .D(n412), .SI(\Reg_File[8][3] ), .SE(n563), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][4] ) );
  SDFFRQX2M \Reg_File_reg[8][3]  ( .D(n411), .SI(\Reg_File[8][2] ), .SE(n566), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][3] ) );
  SDFFRQX2M \Reg_File_reg[8][2]  ( .D(n410), .SI(\Reg_File[8][1] ), .SE(n565), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][2] ) );
  SDFFRQX2M \Reg_File_reg[8][1]  ( .D(n409), .SI(\Reg_File[8][0] ), .SE(n564), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][1] ) );
  SDFFRQX2M \Reg_File_reg[8][0]  ( .D(n408), .SI(\Reg_File[7][7] ), .SE(n563), 
        .CK(CLK), .RN(n224), .Q(\Reg_File[8][0] ) );
  SDFFRQX2M \Reg_File_reg[3][0]  ( .D(n368), .SI(REG2[7]), .SE(n566), .CK(CLK), 
        .RN(n222), .Q(REG3[0]) );
  SDFFRQX2M \Reg_File_reg[2][1]  ( .D(n361), .SI(REG2[0]), .SE(n565), .CK(CLK), 
        .RN(n223), .Q(REG2[1]) );
  SDFFRQX2M \Reg_File_reg[3][4]  ( .D(n372), .SI(REG3[3]), .SE(n564), .CK(CLK), 
        .RN(n222), .Q(REG3[4]) );
  SDFFRQX2M \Reg_File_reg[3][2]  ( .D(n370), .SI(REG3[1]), .SE(n563), .CK(CLK), 
        .RN(n223), .Q(REG3[2]) );
  SDFFRQX2M \Reg_File_reg[3][3]  ( .D(n371), .SI(test_si2), .SE(n566), .CK(CLK), .RN(n222), .Q(REG3[3]) );
  SDFFRX1M \Reg_File_reg[14][7]  ( .D(n463), .SI(n516), .SE(n564), .CK(CLK), 
        .RN(n217), .Q(n515), .QN(n146) );
  SDFFRX1M \Reg_File_reg[14][6]  ( .D(n462), .SI(n517), .SE(n563), .CK(CLK), 
        .RN(n217), .Q(n516), .QN(n147) );
  SDFFRX1M \Reg_File_reg[14][5]  ( .D(n461), .SI(n518), .SE(n566), .CK(CLK), 
        .RN(n217), .Q(n517), .QN(n148) );
  SDFFRX1M \Reg_File_reg[14][4]  ( .D(n460), .SI(n519), .SE(n565), .CK(CLK), 
        .RN(n218), .Q(n518), .QN(n149) );
  SDFFRX1M \Reg_File_reg[14][3]  ( .D(n459), .SI(n520), .SE(n564), .CK(CLK), 
        .RN(n218), .Q(n519), .QN(n150) );
  SDFFRX1M \Reg_File_reg[14][2]  ( .D(n458), .SI(n521), .SE(n563), .CK(CLK), 
        .RN(n217), .Q(n520), .QN(n151) );
  SDFFRX1M \Reg_File_reg[14][1]  ( .D(n457), .SI(n522), .SE(n566), .CK(CLK), 
        .RN(n218), .Q(n521), .QN(n152) );
  SDFFRX1M \Reg_File_reg[14][0]  ( .D(n456), .SI(\Reg_File[13][7] ), .SE(n565), 
        .CK(CLK), .RN(n218), .Q(n522), .QN(n153) );
  SDFFRX1M \Reg_File_reg[10][7]  ( .D(n431), .SI(n532), .SE(n564), .CK(CLK), 
        .RN(n219), .Q(n531), .QN(n162) );
  SDFFRX1M \Reg_File_reg[10][6]  ( .D(n430), .SI(n533), .SE(n563), .CK(CLK), 
        .RN(n220), .Q(n532), .QN(n163) );
  SDFFRX1M \Reg_File_reg[10][5]  ( .D(n429), .SI(n534), .SE(n566), .CK(CLK), 
        .RN(n220), .Q(n533), .QN(n164) );
  SDFFRX1M \Reg_File_reg[10][4]  ( .D(n428), .SI(n535), .SE(n565), .CK(CLK), 
        .RN(n219), .Q(n534), .QN(n165) );
  SDFFRX1M \Reg_File_reg[10][3]  ( .D(n427), .SI(n536), .SE(n564), .CK(CLK), 
        .RN(n220), .Q(n535), .QN(n166) );
  SDFFRX1M \Reg_File_reg[10][2]  ( .D(n426), .SI(n537), .SE(n563), .CK(CLK), 
        .RN(n219), .Q(n536), .QN(n167) );
  SDFFRX1M \Reg_File_reg[10][1]  ( .D(n425), .SI(n538), .SE(n566), .CK(CLK), 
        .RN(n219), .Q(n537), .QN(n168) );
  SDFFRX1M \Reg_File_reg[10][0]  ( .D(n424), .SI(\Reg_File[9][7] ), .SE(n565), 
        .CK(CLK), .RN(n220), .Q(n538), .QN(n169) );
  SDFFRX1M \Reg_File_reg[15][7]  ( .D(n471), .SI(n508), .SE(n564), .CK(CLK), 
        .RN(n217), .Q(test_so2), .QN(n138) );
  SDFFRX1M \Reg_File_reg[15][6]  ( .D(n470), .SI(n509), .SE(n563), .CK(CLK), 
        .RN(n217), .Q(n508), .QN(n139) );
  SDFFRX1M \Reg_File_reg[15][5]  ( .D(n469), .SI(n510), .SE(n566), .CK(CLK), 
        .RN(n217), .Q(n509), .QN(n140) );
  SDFFRX1M \Reg_File_reg[15][4]  ( .D(n468), .SI(n511), .SE(n565), .CK(CLK), 
        .RN(n217), .Q(n510), .QN(n141) );
  SDFFRX1M \Reg_File_reg[15][3]  ( .D(n467), .SI(n512), .SE(n564), .CK(CLK), 
        .RN(n217), .Q(n511), .QN(n142) );
  SDFFRX1M \Reg_File_reg[15][2]  ( .D(n466), .SI(n513), .SE(n563), .CK(CLK), 
        .RN(n217), .Q(n512), .QN(n143) );
  SDFFRX1M \Reg_File_reg[15][1]  ( .D(n465), .SI(n514), .SE(n566), .CK(CLK), 
        .RN(n217), .Q(n513), .QN(n144) );
  SDFFRX1M \Reg_File_reg[15][0]  ( .D(n464), .SI(n515), .SE(n565), .CK(CLK), 
        .RN(n217), .Q(n514), .QN(n145) );
  SDFFRX1M \Reg_File_reg[11][6]  ( .D(n438), .SI(n525), .SE(n564), .CK(CLK), 
        .RN(n219), .Q(n524), .QN(n155) );
  SDFFRX1M \Reg_File_reg[11][5]  ( .D(n437), .SI(n526), .SE(n563), .CK(CLK), 
        .RN(n218), .Q(n525), .QN(n156) );
  SDFFRX1M \Reg_File_reg[11][4]  ( .D(n436), .SI(n527), .SE(n566), .CK(CLK), 
        .RN(n219), .Q(n526), .QN(n157) );
  SDFFRX1M \Reg_File_reg[11][3]  ( .D(n435), .SI(n528), .SE(n565), .CK(CLK), 
        .RN(n219), .Q(n527), .QN(n158) );
  SDFFRX1M \Reg_File_reg[11][2]  ( .D(n434), .SI(n529), .SE(n564), .CK(CLK), 
        .RN(n218), .Q(n528), .QN(n159) );
  SDFFRX1M \Reg_File_reg[11][1]  ( .D(n433), .SI(n530), .SE(n563), .CK(CLK), 
        .RN(n219), .Q(n529), .QN(n160) );
  SDFFRX1M \Reg_File_reg[11][0]  ( .D(n432), .SI(n531), .SE(n566), .CK(CLK), 
        .RN(n220), .Q(n530), .QN(n161) );
  SDFFRX1M \Reg_File_reg[5][7]  ( .D(n391), .SI(n540), .SE(n565), .CK(CLK), 
        .RN(n221), .Q(n539), .QN(n170) );
  SDFFRX1M \Reg_File_reg[5][6]  ( .D(n390), .SI(n541), .SE(n564), .CK(CLK), 
        .RN(n221), .Q(n540), .QN(n171) );
  SDFFRX1M \Reg_File_reg[5][5]  ( .D(n389), .SI(n542), .SE(n563), .CK(CLK), 
        .RN(n221), .Q(n541), .QN(n172) );
  SDFFRX1M \Reg_File_reg[5][4]  ( .D(n388), .SI(n543), .SE(n566), .CK(CLK), 
        .RN(n221), .Q(n542), .QN(n173) );
  SDFFRX1M \Reg_File_reg[5][3]  ( .D(n387), .SI(n544), .SE(n565), .CK(CLK), 
        .RN(n222), .Q(n543), .QN(n174) );
  SDFFRX1M \Reg_File_reg[5][2]  ( .D(n386), .SI(n545), .SE(n564), .CK(CLK), 
        .RN(n220), .Q(n544), .QN(n175) );
  SDFFRX1M \Reg_File_reg[5][1]  ( .D(n385), .SI(n546), .SE(n563), .CK(CLK), 
        .RN(n221), .Q(n545), .QN(n176) );
  SDFFRX1M \Reg_File_reg[5][0]  ( .D(n384), .SI(n547), .SE(n566), .CK(CLK), 
        .RN(n221), .Q(n546), .QN(n177) );
  SDFFRX1M \Reg_File_reg[4][7]  ( .D(n383), .SI(n548), .SE(n565), .CK(CLK), 
        .RN(n220), .Q(n547), .QN(n178) );
  SDFFRX1M \Reg_File_reg[4][6]  ( .D(n382), .SI(n549), .SE(n564), .CK(CLK), 
        .RN(n221), .Q(n548), .QN(n179) );
  SDFFRX1M \Reg_File_reg[4][5]  ( .D(n381), .SI(n550), .SE(n563), .CK(CLK), 
        .RN(n221), .Q(n549), .QN(n180) );
  SDFFRX1M \Reg_File_reg[4][4]  ( .D(n380), .SI(n551), .SE(n566), .CK(CLK), 
        .RN(n221), .Q(n550), .QN(n181) );
  SDFFRX1M \Reg_File_reg[4][3]  ( .D(n379), .SI(n552), .SE(n565), .CK(CLK), 
        .RN(n220), .Q(n551), .QN(n182) );
  SDFFRX1M \Reg_File_reg[4][2]  ( .D(n378), .SI(n553), .SE(n564), .CK(CLK), 
        .RN(n221), .Q(n552), .QN(n183) );
  SDFFRX1M \Reg_File_reg[4][1]  ( .D(n377), .SI(n554), .SE(n563), .CK(CLK), 
        .RN(n221), .Q(n553), .QN(n184) );
  SDFFRX1M \Reg_File_reg[4][0]  ( .D(n376), .SI(REG3[7]), .SE(n566), .CK(CLK), 
        .RN(n220), .Q(n554), .QN(n185) );
  SDFFRQX2M \Reg_File_reg[3][1]  ( .D(n369), .SI(REG3[0]), .SE(n565), .CK(CLK), 
        .RN(n222), .Q(REG3[1]) );
  SDFFRQX2M \Reg_File_reg[2][3]  ( .D(n363), .SI(REG2[2]), .SE(n564), .CK(CLK), 
        .RN(n222), .Q(REG2[3]) );
  SDFFSQX2M \Reg_File_reg[2][0]  ( .D(n360), .SI(REG1[7]), .SE(n563), .CK(CLK), 
        .SN(n222), .Q(REG2[0]) );
  SDFFRQX2M \Reg_File_reg[2][4]  ( .D(n364), .SI(REG2[3]), .SE(n563), .CK(CLK), 
        .RN(n223), .Q(REG2[4]) );
  SDFFRQX2M RdData_VLD_reg ( .D(n343), .SI(test_si1), .SE(n566), .CK(CLK), 
        .RN(n222), .Q(RdData_VLD) );
  SDFFRQX2M \Reg_File_reg[2][7]  ( .D(n367), .SI(REG2[6]), .SE(n565), .CK(CLK), 
        .RN(n223), .Q(REG2[7]) );
  SDFFRQX2M \Reg_File_reg[2][6]  ( .D(n366), .SI(REG2[5]), .SE(n563), .CK(CLK), 
        .RN(n222), .Q(REG2[6]) );
  SDFFRQX2M \Reg_File_reg[3][6]  ( .D(n374), .SI(REG3[5]), .SE(n566), .CK(CLK), 
        .RN(n223), .Q(REG3[6]) );
  SDFFRQX2M \Reg_File_reg[3][7]  ( .D(n375), .SI(REG3[6]), .SE(n565), .CK(CLK), 
        .RN(n223), .Q(REG3[7]) );
  SDFFRX1M \Reg_File_reg[1][2]  ( .D(n354), .SI(REG1[1]), .SE(n565), .CK(CLK), 
        .RN(n220), .Q(n558), .QN(n191) );
  SDFFSQX1M \Reg_File_reg[3][5]  ( .D(n373), .SI(REG3[4]), .SE(n566), .CK(CLK), 
        .SN(RST), .Q(REG3[5]) );
  SDFFRX1M \Reg_File_reg[11][7]  ( .D(n439), .SI(n524), .SE(n564), .CK(CLK), 
        .RN(RST), .Q(n523), .QN(n154) );
  SDFFRHQX1M \Reg_File_reg[1][1]  ( .D(n353), .SI(REG1[0]), .SE(n566), .CK(CLK), .RN(RST), .Q(REG1[1]) );
  SDFFRX1M \Reg_File_reg[0][4]  ( .D(n348), .SI(n198), .SE(n563), .CK(CLK), 
        .RN(RST), .Q(REG0[4]), .QN(n197) );
  SDFFRX1M \Reg_File_reg[0][3]  ( .D(n347), .SI(n199), .SE(n566), .CK(CLK), 
        .RN(n218), .Q(REG0[3]), .QN(n198) );
  SDFFRX1M \Reg_File_reg[0][2]  ( .D(n346), .SI(n200), .SE(n565), .CK(CLK), 
        .RN(n219), .Q(REG0[2]), .QN(n199) );
  SDFFRX1M \Reg_File_reg[0][1]  ( .D(n345), .SI(n201), .SE(n564), .CK(CLK), 
        .RN(n218), .Q(REG0[1]), .QN(n200) );
  SDFFRX1M \Reg_File_reg[0][0]  ( .D(n344), .SI(RdData[7]), .SE(n563), .CK(CLK), .RN(n218), .Q(REG0[0]), .QN(n201) );
  SDFFRQX1M \Reg_File_reg[0][6]  ( .D(n350), .SI(REG0[5]), .SE(n564), .CK(CLK), 
        .RN(RST), .Q(REG0[6]) );
  SDFFRQX1M \Reg_File_reg[0][5]  ( .D(n349), .SI(n197), .SE(n564), .CK(CLK), 
        .RN(n219), .Q(REG0[5]) );
  SDFFSQX1M \Reg_File_reg[2][5]  ( .D(n365), .SI(REG2[4]), .SE(n565), .CK(CLK), 
        .SN(RST), .Q(REG2[5]) );
  SDFFRX1M \Reg_File_reg[1][5]  ( .D(n357), .SI(n556), .SE(n566), .CK(CLK), 
        .RN(n218), .Q(n555), .QN(n188) );
  SDFFRX1M \Reg_File_reg[1][4]  ( .D(n356), .SI(n557), .SE(n565), .CK(CLK), 
        .RN(n220), .Q(n556), .QN(n189) );
  SDFFRX1M \Reg_File_reg[1][3]  ( .D(n355), .SI(n558), .SE(test_se), .CK(CLK), 
        .RN(n221), .Q(n557), .QN(n190) );
  SDFFRHQX2M \Reg_File_reg[1][6]  ( .D(n358), .SI(n555), .SE(n563), .CK(CLK), 
        .RN(RST), .Q(REG1[6]) );
  SDFFRHQX1M \Reg_File_reg[1][0]  ( .D(n352), .SI(REG0[7]), .SE(n565), .CK(CLK), .RN(RST), .Q(n484) );
  SDFFRHQX1M \Reg_File_reg[0][7]  ( .D(n351), .SI(REG0[6]), .SE(n564), .CK(CLK), .RN(n220), .Q(REG0[7]) );
  INVX2M U140 ( .A(n189), .Y(REG1[4]) );
  INVX2M U141 ( .A(n188), .Y(REG1[5]) );
  NOR2X2M U142 ( .A(n280), .B(n492), .Y(n186) );
  INVX2M U143 ( .A(n190), .Y(REG1[3]) );
  INVX2M U155 ( .A(n484), .Y(n208) );
  INVX4M U156 ( .A(n208), .Y(REG1[0]) );
  MX2XLM U157 ( .A(REG1[0]), .B(WrData[0]), .S0(n186), .Y(n352) );
  NOR2BX2M U158 ( .AN(n314), .B(n233), .Y(n321) );
  INVX2M U159 ( .A(n315), .Y(n491) );
  INVX2M U160 ( .A(n328), .Y(n488) );
  INVX2M U161 ( .A(n329), .Y(n487) );
  INVX2M U162 ( .A(n333), .Y(n486) );
  INVX2M U163 ( .A(n334), .Y(n485) );
  INVX2M U164 ( .A(n320), .Y(n490) );
  INVX2M U165 ( .A(n322), .Y(n489) );
  NAND2X2M U166 ( .A(n316), .B(n493), .Y(n318) );
  NAND2X2M U167 ( .A(n316), .B(n495), .Y(n319) );
  NAND2X2M U168 ( .A(n321), .B(n493), .Y(n323) );
  NAND2X2M U169 ( .A(n321), .B(n495), .Y(n324) );
  NAND2X2M U170 ( .A(n326), .B(n215), .Y(n325) );
  NAND2X2M U171 ( .A(n326), .B(n213), .Y(n327) );
  NAND2X2M U172 ( .A(n331), .B(n215), .Y(n330) );
  NAND2X2M U173 ( .A(n331), .B(n213), .Y(n332) );
  NAND2BX2M U174 ( .AN(n280), .B(n215), .Y(n315) );
  NAND2X2M U175 ( .A(n326), .B(n493), .Y(n328) );
  NAND2X2M U176 ( .A(n326), .B(n495), .Y(n329) );
  NAND2X2M U177 ( .A(n331), .B(n493), .Y(n333) );
  NAND2X2M U178 ( .A(n331), .B(n495), .Y(n334) );
  NAND2X2M U179 ( .A(n321), .B(n215), .Y(n320) );
  NAND2X2M U180 ( .A(n321), .B(n213), .Y(n322) );
  INVX2M U181 ( .A(n213), .Y(n492) );
  INVX2M U182 ( .A(n215), .Y(n496) );
  INVX2M U183 ( .A(n316), .Y(n280) );
  NOR2BX2M U184 ( .AN(n314), .B(n235), .Y(n316) );
  INVX2M U185 ( .A(n238), .Y(n493) );
  INVX2M U186 ( .A(n239), .Y(n495) );
  AND2X2M U187 ( .A(n314), .B(n229), .Y(n331) );
  AND2X2M U188 ( .A(n314), .B(n227), .Y(n326) );
  BUFX2M U189 ( .A(n241), .Y(n215) );
  BUFX2M U190 ( .A(n242), .Y(n213) );
  BUFX2M U191 ( .A(n241), .Y(n216) );
  BUFX2M U192 ( .A(n242), .Y(n214) );
  NAND2X2M U193 ( .A(Address[1]), .B(n494), .Y(n238) );
  NAND2X2M U194 ( .A(Address[1]), .B(Address[0]), .Y(n239) );
  NOR2BX2M U195 ( .AN(WrEn), .B(RdEn), .Y(n314) );
  NOR2X2M U196 ( .A(n494), .B(Address[1]), .Y(n242) );
  NOR2X2M U197 ( .A(Address[0]), .B(Address[1]), .Y(n241) );
  INVX2M U198 ( .A(Address[0]), .Y(n494) );
  NAND2BX2M U199 ( .AN(WrEn), .B(RdEn), .Y(n226) );
  INVX2M U200 ( .A(WrData[0]), .Y(n499) );
  INVX2M U201 ( .A(WrData[1]), .Y(n500) );
  INVX2M U202 ( .A(WrData[2]), .Y(n501) );
  INVX2M U203 ( .A(WrData[3]), .Y(n502) );
  INVX2M U204 ( .A(WrData[4]), .Y(n503) );
  INVX2M U205 ( .A(WrData[5]), .Y(n504) );
  NOR2X2M U206 ( .A(n498), .B(n497), .Y(n229) );
  NOR2X2M U207 ( .A(n498), .B(Address[2]), .Y(n227) );
  NAND2X2M U208 ( .A(n497), .B(n498), .Y(n235) );
  NAND2X2M U209 ( .A(Address[2]), .B(n498), .Y(n233) );
  INVX2M U210 ( .A(Address[2]), .Y(n497) );
  BUFX2M U211 ( .A(n250), .Y(n224) );
  BUFX2M U212 ( .A(n250), .Y(n223) );
  BUFX2M U213 ( .A(n260), .Y(n221) );
  BUFX2M U214 ( .A(n260), .Y(n220) );
  BUFX2M U215 ( .A(n270), .Y(n218) );
  BUFX2M U216 ( .A(n270), .Y(n217) );
  BUFX2M U217 ( .A(n270), .Y(n219) );
  BUFX2M U218 ( .A(n260), .Y(n222) );
  BUFX2M U219 ( .A(n250), .Y(n236) );
  MX2X2M U220 ( .A(REG0[5]), .B(WrData[5]), .S0(n491), .Y(n349) );
  MX2X2M U221 ( .A(REG0[6]), .B(WrData[6]), .S0(n491), .Y(n350) );
  MX2X2M U222 ( .A(REG1[2]), .B(WrData[2]), .S0(n186), .Y(n354) );
  MX2X2M U223 ( .A(REG1[3]), .B(WrData[3]), .S0(n186), .Y(n355) );
  MX2XLM U224 ( .A(REG1[4]), .B(WrData[4]), .S0(n186), .Y(n356) );
  MX2XLM U225 ( .A(REG1[5]), .B(WrData[5]), .S0(n186), .Y(n357) );
  INVX2M U226 ( .A(WrData[6]), .Y(n505) );
  INVX2M U227 ( .A(WrData[7]), .Y(n506) );
  INVX2M U228 ( .A(Address[3]), .Y(n498) );
  BUFX2M U229 ( .A(RST), .Y(n260) );
  BUFX2M U230 ( .A(RST), .Y(n250) );
  BUFX2M U231 ( .A(RST), .Y(n270) );
  OAI22X1M U232 ( .A0(n308), .A1(n233), .B0(n309), .B1(n235), .Y(n307) );
  AOI221XLM U233 ( .A0(\Reg_File[6][7] ), .A1(n493), .B0(\Reg_File[7][7] ), 
        .B1(n495), .C0(n311), .Y(n308) );
  OAI22X1M U234 ( .A0(n492), .A1(n170), .B0(n496), .B1(n178), .Y(n311) );
  OAI2BB2X1M U235 ( .B0(n225), .B1(n226), .A0N(RdData[0]), .A1N(n226), .Y(n335) );
  AOI221XLM U236 ( .A0(n227), .A1(n228), .B0(n229), .B1(n230), .C0(n231), .Y(
        n225) );
  OAI221X1M U237 ( .A0(n238), .A1(n169), .B0(n239), .B1(n161), .C0(n243), .Y(
        n228) );
  OAI221X1M U238 ( .A0(n238), .A1(n153), .B0(n239), .B1(n145), .C0(n240), .Y(
        n230) );
  OAI2BB2X1M U239 ( .B0(n244), .B1(n226), .A0N(RdData[1]), .A1N(n226), .Y(n336) );
  AOI221XLM U240 ( .A0(n227), .A1(n245), .B0(n229), .B1(n246), .C0(n247), .Y(
        n244) );
  OAI221X1M U241 ( .A0(n238), .A1(n168), .B0(n239), .B1(n160), .C0(n253), .Y(
        n245) );
  OAI221X1M U242 ( .A0(n238), .A1(n152), .B0(n239), .B1(n144), .C0(n252), .Y(
        n246) );
  OAI2BB2X1M U243 ( .B0(n254), .B1(n226), .A0N(RdData[2]), .A1N(n226), .Y(n337) );
  AOI221XLM U244 ( .A0(n227), .A1(n255), .B0(n229), .B1(n256), .C0(n257), .Y(
        n254) );
  OAI221X1M U245 ( .A0(n238), .A1(n167), .B0(n239), .B1(n159), .C0(n263), .Y(
        n255) );
  OAI221X1M U246 ( .A0(n238), .A1(n151), .B0(n239), .B1(n143), .C0(n262), .Y(
        n256) );
  OAI2BB2X1M U247 ( .B0(n264), .B1(n226), .A0N(RdData[3]), .A1N(n226), .Y(n338) );
  AOI221XLM U248 ( .A0(n227), .A1(n265), .B0(n229), .B1(n266), .C0(n267), .Y(
        n264) );
  OAI221X1M U249 ( .A0(n238), .A1(n166), .B0(n239), .B1(n158), .C0(n273), .Y(
        n265) );
  OAI221X1M U250 ( .A0(n238), .A1(n150), .B0(n239), .B1(n142), .C0(n272), .Y(
        n266) );
  OAI2BB2X1M U251 ( .B0(n274), .B1(n226), .A0N(RdData[4]), .A1N(n226), .Y(n339) );
  AOI221XLM U252 ( .A0(n227), .A1(n275), .B0(n229), .B1(n276), .C0(n277), .Y(
        n274) );
  OAI221X1M U253 ( .A0(n238), .A1(n165), .B0(n239), .B1(n157), .C0(n283), .Y(
        n275) );
  OAI221X1M U254 ( .A0(n238), .A1(n149), .B0(n239), .B1(n141), .C0(n282), .Y(
        n276) );
  OAI2BB2X1M U255 ( .B0(n284), .B1(n226), .A0N(RdData[5]), .A1N(n226), .Y(n340) );
  AOI221XLM U256 ( .A0(n227), .A1(n285), .B0(n229), .B1(n286), .C0(n287), .Y(
        n284) );
  OAI221X1M U257 ( .A0(n238), .A1(n164), .B0(n239), .B1(n156), .C0(n293), .Y(
        n285) );
  OAI221X1M U258 ( .A0(n238), .A1(n148), .B0(n239), .B1(n140), .C0(n292), .Y(
        n286) );
  OAI2BB2X1M U259 ( .B0(n294), .B1(n226), .A0N(RdData[6]), .A1N(n226), .Y(n341) );
  AOI221XLM U260 ( .A0(n227), .A1(n295), .B0(n229), .B1(n296), .C0(n297), .Y(
        n294) );
  OAI221X1M U261 ( .A0(n238), .A1(n163), .B0(n239), .B1(n155), .C0(n303), .Y(
        n295) );
  OAI221X1M U262 ( .A0(n238), .A1(n147), .B0(n239), .B1(n139), .C0(n302), .Y(
        n296) );
  OAI2BB2X1M U263 ( .B0(n304), .B1(n226), .A0N(RdData[7]), .A1N(n226), .Y(n342) );
  AOI221XLM U264 ( .A0(n227), .A1(n305), .B0(n229), .B1(n306), .C0(n307), .Y(
        n304) );
  OAI221X1M U265 ( .A0(n238), .A1(n162), .B0(n239), .B1(n154), .C0(n313), .Y(
        n305) );
  OAI221X1M U266 ( .A0(n238), .A1(n146), .B0(n239), .B1(n138), .C0(n312), .Y(
        n306) );
  OAI22X1M U267 ( .A0(n298), .A1(n233), .B0(n299), .B1(n235), .Y(n297) );
  AOI221XLM U268 ( .A0(\Reg_File[6][6] ), .A1(n493), .B0(\Reg_File[7][6] ), 
        .B1(n495), .C0(n301), .Y(n298) );
  OAI22X1M U269 ( .A0(n492), .A1(n171), .B0(n496), .B1(n179), .Y(n301) );
  OAI22X1M U270 ( .A0(n248), .A1(n233), .B0(n249), .B1(n235), .Y(n247) );
  AOI221XLM U271 ( .A0(\Reg_File[6][1] ), .A1(n493), .B0(\Reg_File[7][1] ), 
        .B1(n495), .C0(n251), .Y(n248) );
  AOI221XLM U272 ( .A0(n216), .A1(REG0[1]), .B0(REG1[1]), .B1(n214), .C0(n482), 
        .Y(n249) );
  OAI22X1M U273 ( .A0(n492), .A1(n176), .B0(n496), .B1(n184), .Y(n251) );
  OAI22X1M U274 ( .A0(n258), .A1(n233), .B0(n259), .B1(n235), .Y(n257) );
  AOI221XLM U275 ( .A0(\Reg_File[6][2] ), .A1(n493), .B0(\Reg_File[7][2] ), 
        .B1(n495), .C0(n261), .Y(n258) );
  AOI221XLM U276 ( .A0(n216), .A1(REG0[2]), .B0(REG1[2]), .B1(n214), .C0(n480), 
        .Y(n259) );
  OAI22X1M U277 ( .A0(n492), .A1(n175), .B0(n496), .B1(n183), .Y(n261) );
  OAI22X1M U278 ( .A0(n268), .A1(n233), .B0(n269), .B1(n235), .Y(n267) );
  AOI221XLM U279 ( .A0(\Reg_File[6][3] ), .A1(n493), .B0(\Reg_File[7][3] ), 
        .B1(n495), .C0(n271), .Y(n268) );
  AOI221XLM U280 ( .A0(n216), .A1(REG0[3]), .B0(REG1[3]), .B1(n214), .C0(n478), 
        .Y(n269) );
  OAI22X1M U281 ( .A0(n492), .A1(n174), .B0(n496), .B1(n182), .Y(n271) );
  OAI22X1M U282 ( .A0(n278), .A1(n233), .B0(n279), .B1(n235), .Y(n277) );
  AOI221XLM U283 ( .A0(\Reg_File[6][4] ), .A1(n493), .B0(\Reg_File[7][4] ), 
        .B1(n495), .C0(n281), .Y(n278) );
  AOI221XLM U284 ( .A0(n216), .A1(REG0[4]), .B0(REG1[4]), .B1(n214), .C0(n476), 
        .Y(n279) );
  OAI22X1M U285 ( .A0(n492), .A1(n173), .B0(n496), .B1(n181), .Y(n281) );
  OAI22X1M U286 ( .A0(n288), .A1(n233), .B0(n289), .B1(n235), .Y(n287) );
  AOI221XLM U287 ( .A0(\Reg_File[6][5] ), .A1(n493), .B0(\Reg_File[7][5] ), 
        .B1(n495), .C0(n291), .Y(n288) );
  AOI221XLM U288 ( .A0(REG0[5]), .A1(n216), .B0(REG1[5]), .B1(n214), .C0(n473), 
        .Y(n289) );
  OAI22X1M U289 ( .A0(n492), .A1(n172), .B0(n496), .B1(n180), .Y(n291) );
  OAI22X1M U290 ( .A0(n232), .A1(n233), .B0(n234), .B1(n235), .Y(n231) );
  AOI221XLM U291 ( .A0(\Reg_File[6][0] ), .A1(n493), .B0(\Reg_File[7][0] ), 
        .B1(n495), .C0(n237), .Y(n232) );
  AOI221XLM U292 ( .A0(n216), .A1(REG0[0]), .B0(REG1[0]), .B1(n214), .C0(n483), 
        .Y(n234) );
  OAI22X1M U293 ( .A0(n492), .A1(n177), .B0(n496), .B1(n185), .Y(n237) );
  OAI22X1M U294 ( .A0(n499), .A1(n328), .B0(n488), .B1(n169), .Y(n424) );
  OAI22X1M U295 ( .A0(n500), .A1(n328), .B0(n488), .B1(n168), .Y(n425) );
  OAI22X1M U296 ( .A0(n501), .A1(n328), .B0(n488), .B1(n167), .Y(n426) );
  OAI22X1M U297 ( .A0(n502), .A1(n328), .B0(n488), .B1(n166), .Y(n427) );
  OAI22X1M U298 ( .A0(n503), .A1(n328), .B0(n488), .B1(n165), .Y(n428) );
  OAI22X1M U299 ( .A0(n504), .A1(n328), .B0(n488), .B1(n164), .Y(n429) );
  OAI22X1M U300 ( .A0(n505), .A1(n328), .B0(n488), .B1(n163), .Y(n430) );
  OAI22X1M U301 ( .A0(n506), .A1(n328), .B0(n488), .B1(n162), .Y(n431) );
  OAI22X1M U302 ( .A0(n499), .A1(n329), .B0(n487), .B1(n161), .Y(n432) );
  OAI22X1M U303 ( .A0(n500), .A1(n329), .B0(n487), .B1(n160), .Y(n433) );
  OAI22X1M U304 ( .A0(n501), .A1(n329), .B0(n487), .B1(n159), .Y(n434) );
  OAI22X1M U305 ( .A0(n502), .A1(n329), .B0(n487), .B1(n158), .Y(n435) );
  OAI22X1M U306 ( .A0(n503), .A1(n329), .B0(n487), .B1(n157), .Y(n436) );
  OAI22X1M U307 ( .A0(n504), .A1(n329), .B0(n487), .B1(n156), .Y(n437) );
  OAI22X1M U308 ( .A0(n505), .A1(n329), .B0(n487), .B1(n155), .Y(n438) );
  OAI22X1M U309 ( .A0(n506), .A1(n329), .B0(n487), .B1(n154), .Y(n439) );
  OAI22X1M U310 ( .A0(n499), .A1(n333), .B0(n486), .B1(n153), .Y(n456) );
  OAI22X1M U311 ( .A0(n500), .A1(n333), .B0(n486), .B1(n152), .Y(n457) );
  OAI22X1M U312 ( .A0(n501), .A1(n333), .B0(n486), .B1(n151), .Y(n458) );
  OAI22X1M U313 ( .A0(n502), .A1(n333), .B0(n486), .B1(n150), .Y(n459) );
  OAI22X1M U314 ( .A0(n503), .A1(n333), .B0(n486), .B1(n149), .Y(n460) );
  OAI22X1M U315 ( .A0(n504), .A1(n333), .B0(n486), .B1(n148), .Y(n461) );
  OAI22X1M U316 ( .A0(n505), .A1(n333), .B0(n486), .B1(n147), .Y(n462) );
  OAI22X1M U317 ( .A0(n506), .A1(n333), .B0(n486), .B1(n146), .Y(n463) );
  OAI22X1M U318 ( .A0(n499), .A1(n334), .B0(n485), .B1(n145), .Y(n464) );
  OAI22X1M U319 ( .A0(n500), .A1(n334), .B0(n485), .B1(n144), .Y(n465) );
  OAI22X1M U320 ( .A0(n501), .A1(n334), .B0(n485), .B1(n143), .Y(n466) );
  OAI22X1M U321 ( .A0(n502), .A1(n334), .B0(n485), .B1(n142), .Y(n467) );
  OAI22X1M U322 ( .A0(n503), .A1(n334), .B0(n485), .B1(n141), .Y(n468) );
  OAI22X1M U323 ( .A0(n504), .A1(n334), .B0(n485), .B1(n140), .Y(n469) );
  OAI22X1M U324 ( .A0(n505), .A1(n334), .B0(n485), .B1(n139), .Y(n470) );
  OAI22X1M U325 ( .A0(n506), .A1(n334), .B0(n485), .B1(n138), .Y(n471) );
  OAI22X1M U326 ( .A0(n315), .A1(n499), .B0(n491), .B1(n201), .Y(n344) );
  OAI22X1M U327 ( .A0(n315), .A1(n500), .B0(n491), .B1(n200), .Y(n345) );
  OAI22X1M U328 ( .A0(n315), .A1(n501), .B0(n491), .B1(n199), .Y(n346) );
  OAI22X1M U329 ( .A0(n315), .A1(n502), .B0(n491), .B1(n198), .Y(n347) );
  OAI22X1M U330 ( .A0(n315), .A1(n503), .B0(n491), .B1(n197), .Y(n348) );
  OAI22X1M U331 ( .A0(n499), .A1(n320), .B0(n490), .B1(n185), .Y(n376) );
  OAI22X1M U332 ( .A0(n500), .A1(n320), .B0(n490), .B1(n184), .Y(n377) );
  OAI22X1M U333 ( .A0(n501), .A1(n320), .B0(n490), .B1(n183), .Y(n378) );
  OAI22X1M U334 ( .A0(n502), .A1(n320), .B0(n490), .B1(n182), .Y(n379) );
  OAI22X1M U335 ( .A0(n503), .A1(n320), .B0(n490), .B1(n181), .Y(n380) );
  OAI22X1M U336 ( .A0(n504), .A1(n320), .B0(n490), .B1(n180), .Y(n381) );
  OAI22X1M U337 ( .A0(n505), .A1(n320), .B0(n490), .B1(n179), .Y(n382) );
  OAI22X1M U338 ( .A0(n506), .A1(n320), .B0(n490), .B1(n178), .Y(n383) );
  OAI22X1M U339 ( .A0(n499), .A1(n322), .B0(n489), .B1(n177), .Y(n384) );
  OAI22X1M U340 ( .A0(n500), .A1(n322), .B0(n489), .B1(n176), .Y(n385) );
  OAI22X1M U341 ( .A0(n501), .A1(n322), .B0(n489), .B1(n175), .Y(n386) );
  OAI22X1M U342 ( .A0(n502), .A1(n322), .B0(n489), .B1(n174), .Y(n387) );
  OAI22X1M U343 ( .A0(n503), .A1(n322), .B0(n489), .B1(n173), .Y(n388) );
  OAI22X1M U344 ( .A0(n504), .A1(n322), .B0(n489), .B1(n172), .Y(n389) );
  OAI22X1M U345 ( .A0(n505), .A1(n322), .B0(n489), .B1(n171), .Y(n390) );
  OAI22X1M U346 ( .A0(n506), .A1(n322), .B0(n489), .B1(n170), .Y(n391) );
  OAI2BB2X1M U347 ( .B0(n499), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][0] ), 
        .Y(n392) );
  OAI2BB2X1M U348 ( .B0(n500), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][1] ), 
        .Y(n393) );
  OAI2BB2X1M U349 ( .B0(n501), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][2] ), 
        .Y(n394) );
  OAI2BB2X1M U350 ( .B0(n502), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][3] ), 
        .Y(n395) );
  OAI2BB2X1M U351 ( .B0(n503), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][4] ), 
        .Y(n396) );
  OAI2BB2X1M U352 ( .B0(n504), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][5] ), 
        .Y(n397) );
  OAI2BB2X1M U353 ( .B0(n505), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][6] ), 
        .Y(n398) );
  OAI2BB2X1M U354 ( .B0(n506), .B1(n323), .A0N(n323), .A1N(\Reg_File[6][7] ), 
        .Y(n399) );
  OAI2BB2X1M U355 ( .B0(n499), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][0] ), 
        .Y(n400) );
  OAI2BB2X1M U356 ( .B0(n500), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][1] ), 
        .Y(n401) );
  OAI2BB2X1M U357 ( .B0(n501), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][2] ), 
        .Y(n402) );
  OAI2BB2X1M U358 ( .B0(n502), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][3] ), 
        .Y(n403) );
  OAI2BB2X1M U359 ( .B0(n503), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][4] ), 
        .Y(n404) );
  OAI2BB2X1M U360 ( .B0(n504), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][5] ), 
        .Y(n405) );
  OAI2BB2X1M U361 ( .B0(n505), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][6] ), 
        .Y(n406) );
  OAI2BB2X1M U362 ( .B0(n506), .B1(n324), .A0N(n324), .A1N(\Reg_File[7][7] ), 
        .Y(n407) );
  OAI2BB2X1M U363 ( .B0(n500), .B1(n318), .A0N(n318), .A1N(REG2[1]), .Y(n361)
         );
  OAI2BB2X1M U364 ( .B0(n501), .B1(n318), .A0N(n318), .A1N(REG2[2]), .Y(n362)
         );
  OAI2BB2X1M U365 ( .B0(n502), .B1(n318), .A0N(n318), .A1N(REG2[3]), .Y(n363)
         );
  OAI2BB2X1M U366 ( .B0(n503), .B1(n318), .A0N(n318), .A1N(REG2[4]), .Y(n364)
         );
  OAI2BB2X1M U367 ( .B0(n505), .B1(n318), .A0N(n318), .A1N(REG2[6]), .Y(n366)
         );
  OAI2BB2X1M U368 ( .B0(n506), .B1(n318), .A0N(n318), .A1N(REG2[7]), .Y(n367)
         );
  OAI2BB2X1M U369 ( .B0(n499), .B1(n319), .A0N(n319), .A1N(REG3[0]), .Y(n368)
         );
  OAI2BB2X1M U370 ( .B0(n500), .B1(n319), .A0N(n319), .A1N(REG3[1]), .Y(n369)
         );
  OAI2BB2X1M U371 ( .B0(n501), .B1(n319), .A0N(n319), .A1N(REG3[2]), .Y(n370)
         );
  OAI2BB2X1M U372 ( .B0(n502), .B1(n319), .A0N(n319), .A1N(REG3[3]), .Y(n371)
         );
  OAI2BB2X1M U373 ( .B0(n503), .B1(n319), .A0N(n319), .A1N(REG3[4]), .Y(n372)
         );
  OAI2BB2X1M U374 ( .B0(n505), .B1(n319), .A0N(n319), .A1N(REG3[6]), .Y(n374)
         );
  OAI2BB2X1M U375 ( .B0(n506), .B1(n319), .A0N(n319), .A1N(REG3[7]), .Y(n375)
         );
  OAI2BB2X1M U376 ( .B0(n499), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][0] ), 
        .Y(n408) );
  OAI2BB2X1M U377 ( .B0(n500), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][1] ), 
        .Y(n409) );
  OAI2BB2X1M U378 ( .B0(n501), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][2] ), 
        .Y(n410) );
  OAI2BB2X1M U379 ( .B0(n502), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][3] ), 
        .Y(n411) );
  OAI2BB2X1M U380 ( .B0(n503), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][4] ), 
        .Y(n412) );
  OAI2BB2X1M U381 ( .B0(n504), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][5] ), 
        .Y(n413) );
  OAI2BB2X1M U382 ( .B0(n505), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][6] ), 
        .Y(n414) );
  OAI2BB2X1M U383 ( .B0(n506), .B1(n325), .A0N(n325), .A1N(\Reg_File[8][7] ), 
        .Y(n415) );
  OAI2BB2X1M U384 ( .B0(n499), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][0] ), 
        .Y(n416) );
  OAI2BB2X1M U385 ( .B0(n500), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][1] ), 
        .Y(n417) );
  OAI2BB2X1M U386 ( .B0(n501), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][2] ), 
        .Y(n418) );
  OAI2BB2X1M U387 ( .B0(n502), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][3] ), 
        .Y(n419) );
  OAI2BB2X1M U388 ( .B0(n503), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][4] ), 
        .Y(n420) );
  OAI2BB2X1M U389 ( .B0(n504), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][5] ), 
        .Y(n421) );
  OAI2BB2X1M U390 ( .B0(n505), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][6] ), 
        .Y(n422) );
  OAI2BB2X1M U391 ( .B0(n506), .B1(n327), .A0N(n327), .A1N(\Reg_File[9][7] ), 
        .Y(n423) );
  OAI2BB2X1M U392 ( .B0(n499), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][0] ), 
        .Y(n440) );
  OAI2BB2X1M U393 ( .B0(n500), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][1] ), 
        .Y(n441) );
  OAI2BB2X1M U394 ( .B0(n501), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][2] ), 
        .Y(n442) );
  OAI2BB2X1M U395 ( .B0(n502), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][3] ), 
        .Y(n443) );
  OAI2BB2X1M U396 ( .B0(n503), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][4] ), 
        .Y(n444) );
  OAI2BB2X1M U397 ( .B0(n504), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][5] ), 
        .Y(n445) );
  OAI2BB2X1M U398 ( .B0(n505), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][6] ), 
        .Y(n446) );
  OAI2BB2X1M U399 ( .B0(n506), .B1(n330), .A0N(n330), .A1N(\Reg_File[12][7] ), 
        .Y(n447) );
  OAI2BB2X1M U400 ( .B0(n499), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][0] ), 
        .Y(n448) );
  OAI2BB2X1M U401 ( .B0(n500), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][1] ), 
        .Y(n449) );
  OAI2BB2X1M U402 ( .B0(n501), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][2] ), 
        .Y(n450) );
  OAI2BB2X1M U403 ( .B0(n502), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][3] ), 
        .Y(n451) );
  OAI2BB2X1M U404 ( .B0(n503), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][4] ), 
        .Y(n452) );
  OAI2BB2X1M U405 ( .B0(n504), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][5] ), 
        .Y(n453) );
  OAI2BB2X1M U406 ( .B0(n505), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][6] ), 
        .Y(n454) );
  OAI2BB2X1M U407 ( .B0(n506), .B1(n332), .A0N(n332), .A1N(\Reg_File[13][7] ), 
        .Y(n455) );
  OAI2BB2X1M U408 ( .B0(n499), .B1(n318), .A0N(n318), .A1N(REG2[0]), .Y(n360)
         );
  OAI2BB2X1M U409 ( .B0(n504), .B1(n318), .A0N(n318), .A1N(REG2[5]), .Y(n365)
         );
  OAI2BB2X1M U410 ( .B0(n504), .B1(n319), .A0N(n319), .A1N(REG3[5]), .Y(n373)
         );
  MX2XLM U411 ( .A(REG1[1]), .B(WrData[1]), .S0(n186), .Y(n353) );
  AO22X1M U412 ( .A0(REG2[0]), .A1(n493), .B0(REG3[0]), .B1(n495), .Y(n483) );
  AO22X1M U413 ( .A0(REG2[1]), .A1(n493), .B0(REG3[1]), .B1(n495), .Y(n482) );
  AO22X1M U414 ( .A0(REG2[2]), .A1(n493), .B0(REG3[2]), .B1(n495), .Y(n480) );
  AO22X1M U415 ( .A0(REG2[3]), .A1(n493), .B0(REG3[3]), .B1(n495), .Y(n478) );
  AO22X1M U416 ( .A0(REG2[4]), .A1(n493), .B0(REG3[4]), .B1(n495), .Y(n476) );
  AO22X1M U417 ( .A0(REG2[5]), .A1(n493), .B0(REG3[5]), .B1(n495), .Y(n473) );
  AO22X1M U418 ( .A0(REG2[6]), .A1(n493), .B0(REG3[6]), .B1(n495), .Y(n310) );
  AO22X1M U419 ( .A0(REG2[7]), .A1(n493), .B0(REG3[7]), .B1(n495), .Y(n290) );
  AOI22X1M U420 ( .A0(\Reg_File[12][0] ), .A1(n216), .B0(\Reg_File[13][0] ), 
        .B1(n214), .Y(n240) );
  AOI22X1M U421 ( .A0(\Reg_File[8][0] ), .A1(n216), .B0(\Reg_File[9][0] ), 
        .B1(n214), .Y(n243) );
  AOI22X1M U422 ( .A0(\Reg_File[12][1] ), .A1(n216), .B0(\Reg_File[13][1] ), 
        .B1(n214), .Y(n252) );
  AOI22X1M U423 ( .A0(\Reg_File[8][1] ), .A1(n216), .B0(\Reg_File[9][1] ), 
        .B1(n214), .Y(n253) );
  AOI22X1M U424 ( .A0(\Reg_File[12][2] ), .A1(n216), .B0(\Reg_File[13][2] ), 
        .B1(n214), .Y(n262) );
  AOI22X1M U425 ( .A0(\Reg_File[8][2] ), .A1(n216), .B0(\Reg_File[9][2] ), 
        .B1(n214), .Y(n263) );
  AOI22X1M U426 ( .A0(\Reg_File[12][3] ), .A1(n216), .B0(\Reg_File[13][3] ), 
        .B1(n214), .Y(n272) );
  AOI22X1M U427 ( .A0(\Reg_File[8][3] ), .A1(n216), .B0(\Reg_File[9][3] ), 
        .B1(n214), .Y(n273) );
  AOI22X1M U428 ( .A0(\Reg_File[12][4] ), .A1(n216), .B0(\Reg_File[13][4] ), 
        .B1(n214), .Y(n282) );
  AOI22X1M U429 ( .A0(\Reg_File[8][4] ), .A1(n216), .B0(\Reg_File[9][4] ), 
        .B1(n214), .Y(n283) );
  AOI22X1M U430 ( .A0(\Reg_File[12][5] ), .A1(n216), .B0(\Reg_File[13][5] ), 
        .B1(n214), .Y(n292) );
  AOI22X1M U431 ( .A0(\Reg_File[8][5] ), .A1(n216), .B0(\Reg_File[9][5] ), 
        .B1(n214), .Y(n293) );
  AOI22X1M U432 ( .A0(\Reg_File[12][6] ), .A1(n216), .B0(\Reg_File[13][6] ), 
        .B1(n214), .Y(n302) );
  AOI22X1M U433 ( .A0(\Reg_File[8][6] ), .A1(n216), .B0(\Reg_File[9][6] ), 
        .B1(n214), .Y(n303) );
  AOI22X1M U434 ( .A0(\Reg_File[12][7] ), .A1(n216), .B0(\Reg_File[13][7] ), 
        .B1(n214), .Y(n312) );
  AOI22X1M U435 ( .A0(\Reg_File[8][7] ), .A1(n215), .B0(\Reg_File[9][7] ), 
        .B1(n213), .Y(n313) );
  OAI2BB1X2M U436 ( .A0N(RdData_VLD), .A1N(n314), .B0(n226), .Y(n343) );
  INVX2M U437 ( .A(n191), .Y(REG1[2]) );
  AOI221XLM U441 ( .A0(REG0[7]), .A1(n216), .B0(REG1[7]), .B1(n214), .C0(n290), 
        .Y(n309) );
  MX2XLM U442 ( .A(REG1[7]), .B(WrData[7]), .S0(n186), .Y(n359) );
  MX2XLM U443 ( .A(REG1[6]), .B(WrData[6]), .S0(n186), .Y(n358) );
  AOI221XLM U444 ( .A0(REG0[6]), .A1(n216), .B0(REG1[6]), .B1(n214), .C0(n310), 
        .Y(n299) );
  MX2XLM U445 ( .A(REG0[7]), .B(WrData[7]), .S0(n491), .Y(n351) );
  DLY1X1M U446 ( .A(test_se), .Y(n563) );
  DLY1X1M U447 ( .A(test_se), .Y(n564) );
  DLY1X1M U448 ( .A(test_se), .Y(n565) );
  DLY1X1M U449 ( .A(test_se), .Y(n566) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFXLM U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n8), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n6), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n4), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  INVX2M U1 ( .A(B[4]), .Y(n5) );
  INVX2M U2 ( .A(B[5]), .Y(n4) );
  XNOR2X2M U3 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  NAND2X2M U4 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX2M U5 ( .A(A[0]), .Y(n1) );
  INVXLM U6 ( .A(B[1]), .Y(n8) );
  INVXLM U7 ( .A(B[3]), .Y(n6) );
  INVXLM U8 ( .A(B[2]), .Y(n7) );
  INVXLM U9 ( .A(B[6]), .Y(n3) );
  INVXLM U10 ( .A(B[7]), .Y(n2) );
  INVXLM U11 ( .A(B[0]), .Y(n9) );
  CLKINVX1M U12 ( .A(carry[8]), .Y(DIFF[8]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [8:1] carry;

  ADDFX1M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X1M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XNOR2XLM U2 ( .A(B[0]), .B(n2), .Y(SUM[0]) );
  INVX2M U3 ( .A(A[0]), .Y(n2) );
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
  NAND2X2M U3 ( .A(A[7]), .B(B[7]), .Y(n15) );
  XNOR2X2M U4 ( .A(B[13]), .B(n1), .Y(SUM[13]) );
  XNOR2X2M U5 ( .A(A[7]), .B(n8), .Y(SUM[7]) );
  INVX2M U6 ( .A(B[7]), .Y(n8) );
  INVX2M U7 ( .A(n9), .Y(SUM[6]) );
  INVX2M U8 ( .A(A[6]), .Y(n9) );
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

  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n7), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n4), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n9), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n6), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n5), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n8), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n3), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
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
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  AND2X2M U2 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  CLKXOR2X2M U10 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  AND2X2M U11 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n11) );
  INVX2M U12 ( .A(B[4]), .Y(n27) );
  CLKXOR2X2M U13 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  AND2X2M U14 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n12) );
  CLKXOR2X2M U15 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U16 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U17 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  CLKXOR2X2M U18 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  INVX2M U19 ( .A(\ab[0][7] ), .Y(n23) );
  INVX2M U20 ( .A(\ab[0][6] ), .Y(n22) );
  INVX2M U21 ( .A(\ab[0][4] ), .Y(n20) );
  INVX2M U22 ( .A(\ab[0][3] ), .Y(n19) );
  INVX2M U23 ( .A(\ab[0][2] ), .Y(n18) );
  INVX2M U24 ( .A(\ab[0][5] ), .Y(n21) );
  INVX2M U25 ( .A(B[5]), .Y(n26) );
  XNOR2X2M U26 ( .A(\ab[1][2] ), .B(n19), .Y(\SUMB[1][2] ) );
  XNOR2X2M U27 ( .A(\ab[1][6] ), .B(n23), .Y(\SUMB[1][6] ) );
  XNOR2X2M U28 ( .A(\ab[1][5] ), .B(n22), .Y(\SUMB[1][5] ) );
  AND2X2M U29 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n13) );
  AND2X2M U30 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n14) );
  AND2X2M U31 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n15) );
  XNOR2X2M U32 ( .A(\CARRYB[7][0] ), .B(n17), .Y(\A1[6] ) );
  INVX2M U33 ( .A(\SUMB[7][1] ), .Y(n17) );
  AND2X2M U34 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n16) );
  XNOR2X2M U35 ( .A(\ab[1][4] ), .B(n21), .Y(\SUMB[1][4] ) );
  XNOR2X2M U36 ( .A(\ab[1][3] ), .B(n20), .Y(\SUMB[1][3] ) );
  XNOR2X2M U37 ( .A(\ab[1][1] ), .B(n18), .Y(\SUMB[1][1] ) );
  INVX2M U38 ( .A(A[2]), .Y(n37) );
  INVX2M U39 ( .A(A[4]), .Y(n35) );
  INVX2M U40 ( .A(A[3]), .Y(n36) );
  INVX2M U41 ( .A(A[5]), .Y(n34) );
  INVX2M U42 ( .A(A[6]), .Y(n33) );
  CLKXOR2X2M U43 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  INVX2M U44 ( .A(A[0]), .Y(n39) );
  INVX2M U45 ( .A(A[1]), .Y(n38) );
  INVXLM U46 ( .A(B[1]), .Y(n30) );
  INVXLM U47 ( .A(B[3]), .Y(n28) );
  INVXLM U48 ( .A(B[2]), .Y(n29) );
  INVXLM U49 ( .A(A[7]), .Y(n32) );
  INVXLM U50 ( .A(B[6]), .Y(n25) );
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
  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n12, n11, n16, n15, n14, n13, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
endmodule


module ALU_DW_div_uns_1 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] , \u_div/SumTmp[1][3] ,
         \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] , \u_div/SumTmp[1][6] ,
         \u_div/SumTmp[2][0] , \u_div/SumTmp[2][1] , \u_div/SumTmp[2][2] ,
         \u_div/SumTmp[2][3] , \u_div/SumTmp[2][4] , \u_div/SumTmp[2][5] ,
         \u_div/SumTmp[3][0] , \u_div/SumTmp[3][1] , \u_div/SumTmp[3][2] ,
         \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] , \u_div/SumTmp[4][0] ,
         \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] , \u_div/SumTmp[4][3] ,
         \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] , \u_div/SumTmp[5][2] ,
         \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] , \u_div/SumTmp[7][0] ,
         \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] , \u_div/CryTmp[0][3] ,
         \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] , \u_div/CryTmp[0][6] ,
         \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] , \u_div/CryTmp[1][2] ,
         \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] , \u_div/CryTmp[1][5] ,
         \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] , \u_div/CryTmp[2][1] ,
         \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] , \u_div/CryTmp[2][4] ,
         \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] , \u_div/CryTmp[3][1] ,
         \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] , \u_div/CryTmp[3][4] ,
         \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] , \u_div/CryTmp[4][2] ,
         \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] , \u_div/CryTmp[5][1] ,
         \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] , \u_div/CryTmp[6][1] ,
         \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] , \u_div/PartRem[1][1] ,
         \u_div/PartRem[1][2] , \u_div/PartRem[1][3] , \u_div/PartRem[1][4] ,
         \u_div/PartRem[1][5] , \u_div/PartRem[1][6] , \u_div/PartRem[1][7] ,
         \u_div/PartRem[2][1] , \u_div/PartRem[2][2] , \u_div/PartRem[2][3] ,
         \u_div/PartRem[2][4] , \u_div/PartRem[2][5] , \u_div/PartRem[2][6] ,
         \u_div/PartRem[4][1] , \u_div/PartRem[4][2] , \u_div/PartRem[5][1] ,
         \u_div/PartRem[6][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n24, n25, n26,
         n27, n28, n29, n31, n32, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92;
  wire   [7:0] \u_div/BInv ;

  ADDFHX8M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), 
        .S(\u_div/SumTmp[3][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(
        \u_div/BInv [7]), .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(
        \u_div/BInv [6]), .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), 
        .S(\u_div/SumTmp[1][6] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_3  ( .A(n35), .B(\u_div/BInv [3]), .CI(
        \u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), 
        .S(\u_div/SumTmp[1][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(
        \u_div/BInv [5]), .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), 
        .S(\u_div/SumTmp[1][5] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(
        \u_div/BInv [3]), .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), 
        .S(\u_div/SumTmp[1][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_3_3  ( .A(n34), .B(\u_div/BInv [3]), .CI(
        \u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(
        \u_div/BInv [2]), .CI(\u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), 
        .S(\u_div/SumTmp[3][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(
        \u_div/BInv [4]), .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_4  ( .A(n38), .B(\u_div/BInv [4]), .CI(
        \u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_2_5  ( .A(n31), .B(\u_div/BInv [5]), .CI(
        \u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(
        \u_div/BInv [3]), .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(
        \u_div/BInv [2]), .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/CryTmp[0][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/PartRem[1][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/BInv [1]), .B(
        \u_div/PartRem[2][1] ), .CI(\u_div/CryTmp[1][1] ), .CO(
        \u_div/CryTmp[1][2] ), .S(\u_div/SumTmp[1][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(
        \u_div/BInv [5]), .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] )
         );
  ADDFHX4M \u_div/u_fa_PartRem_0_3_4  ( .A(n36), .B(\u_div/BInv [4]), .CI(
        \u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/BInv [1]), .B(
        \u_div/PartRem[5][1] ), .CI(\u_div/CryTmp[4][1] ), .CO(
        \u_div/CryTmp[4][2] ), .S(\u_div/SumTmp[4][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/BInv [1]), .B(n1), .CI(
        \u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(
        \u_div/BInv [2]), .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), 
        .S(\u_div/SumTmp[1][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(
        \u_div/BInv [1]), .CI(\u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), 
        .S(\u_div/SumTmp[5][1] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_5_2  ( .A(n48), .B(\u_div/BInv [2]), .CI(
        \u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_4_2  ( .A(n21), .B(\u_div/BInv [2]), .CI(
        \u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  CLKINVX6M U1 ( .A(n82), .Y(n26) );
  NOR2X8M U2 ( .A(n67), .B(n52), .Y(n51) );
  NAND2X12M U3 ( .A(n87), .B(\u_div/BInv [3]), .Y(n67) );
  CLKNAND2X2M U4 ( .A(\u_div/CryTmp[3][5] ), .B(n90), .Y(n89) );
  NAND2X3M U5 ( .A(n53), .B(\u_div/BInv [1]), .Y(n4) );
  INVX4M U6 ( .A(\u_div/CryTmp[5][3] ), .Y(n68) );
  AND2X4M U7 ( .A(\u_div/CryTmp[5][3] ), .B(n85), .Y(quotient[5]) );
  MX2X1M U8 ( .A(n21), .B(\u_div/SumTmp[4][2] ), .S0(quotient[4]), .Y(n34) );
  NOR2X4M U9 ( .A(b[5]), .B(b[4]), .Y(n88) );
  NAND2X4M U10 ( .A(\u_div/BInv [1]), .B(n3), .Y(n52) );
  CLKINVX12M U11 ( .A(b[1]), .Y(\u_div/BInv [1]) );
  NOR2X8M U12 ( .A(n68), .B(n92), .Y(n66) );
  CLKINVX4M U13 ( .A(n27), .Y(n22) );
  NOR2BX2M U14 ( .AN(\u_div/CryTmp[2][6] ), .B(n82), .Y(n27) );
  MXI2XLM U15 ( .A(n58), .B(n75), .S0(quotient[1]), .Y(\u_div/PartRem[1][3] )
         );
  NOR2X3M U16 ( .A(n82), .B(n83), .Y(n24) );
  INVX3M U17 ( .A(n58), .Y(\u_div/PartRem[2][2] ) );
  CLKINVX4M U18 ( .A(\u_div/CryTmp[2][6] ), .Y(n83) );
  MX2X4M U19 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(n51), .Y(n1) );
  NOR2X5M U20 ( .A(n73), .B(n74), .Y(n72) );
  MXI2X6M U21 ( .A(n64), .B(n65), .S0(n66), .Y(\u_div/PartRem[5][1] ) );
  MXI2X2M U22 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(n24), .Y(n25) );
  INVX4M U23 ( .A(a[7]), .Y(n45) );
  NAND2X4M U24 ( .A(n53), .B(\u_div/CryTmp[2][1] ), .Y(n5) );
  INVX2M U25 ( .A(\u_div/SumTmp[1][1] ), .Y(n80) );
  MXI2X2M U26 ( .A(n53), .B(\u_div/SumTmp[2][1] ), .S0(quotient[2]), .Y(n58)
         );
  MX2X2M U27 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(n35) );
  INVX2M U28 ( .A(b[0]), .Y(\u_div/BInv [0]) );
  INVX4M U29 ( .A(b[3]), .Y(\u_div/BInv [3]) );
  INVX2M U30 ( .A(n78), .Y(n90) );
  INVX2M U31 ( .A(b[2]), .Y(\u_div/BInv [2]) );
  NAND2X2M U32 ( .A(b[0]), .B(n45), .Y(\u_div/CryTmp[7][1] ) );
  INVX2M U33 ( .A(b[2]), .Y(n49) );
  NAND2X6M U34 ( .A(n16), .B(n17), .Y(\u_div/PartRem[6][1] ) );
  NAND2X4M U35 ( .A(a[6]), .B(n15), .Y(n16) );
  CLKINVX4M U36 ( .A(quotient[5]), .Y(n18) );
  CLKINVX8M U37 ( .A(n73), .Y(n87) );
  NAND3X4M U38 ( .A(n14), .B(n13), .C(n12), .Y(\u_div/CryTmp[4][4] ) );
  NAND2X2M U39 ( .A(\u_div/SumTmp[5][1] ), .B(quotient[5]), .Y(n20) );
  NAND3X4M U40 ( .A(n9), .B(n8), .C(n10), .Y(\u_div/CryTmp[2][3] ) );
  INVX8M U41 ( .A(n76), .Y(n53) );
  NOR2X4M U42 ( .A(n79), .B(n78), .Y(n77) );
  INVX3M U43 ( .A(n25), .Y(\u_div/PartRem[2][1] ) );
  AND2X2M U44 ( .A(n85), .B(\u_div/BInv [2]), .Y(n2) );
  AND2X2M U45 ( .A(\u_div/CryTmp[7][1] ), .B(n49), .Y(n3) );
  NAND2X6M U46 ( .A(n88), .B(n26), .Y(n73) );
  OR2X6M U47 ( .A(b[6]), .B(b[7]), .Y(n82) );
  NAND2X2M U48 ( .A(\u_div/CryTmp[4][3] ), .B(\u_div/BInv [3]), .Y(n14) );
  XOR2XLM U49 ( .A(\u_div/BInv [3]), .B(\u_div/CryTmp[4][3] ), .Y(n11) );
  NAND2X4M U50 ( .A(n19), .B(n20), .Y(n21) );
  NAND2X2M U51 ( .A(n37), .B(\u_div/CryTmp[2][2] ), .Y(n9) );
  NAND2X4M U52 ( .A(\u_div/CryTmp[2][2] ), .B(\u_div/BInv [2]), .Y(n10) );
  MX2X1M U53 ( .A(n34), .B(\u_div/SumTmp[3][3] ), .S0(quotient[3]), .Y(n38) );
  MX2XLM U54 ( .A(n36), .B(\u_div/SumTmp[3][4] ), .S0(quotient[3]), .Y(n31) );
  NAND3X4M U55 ( .A(n4), .B(n5), .C(n6), .Y(\u_div/CryTmp[2][2] ) );
  XOR3XLM U56 ( .A(n53), .B(\u_div/BInv [1]), .C(\u_div/CryTmp[2][1] ), .Y(
        \u_div/SumTmp[2][1] ) );
  NAND2XLM U57 ( .A(\u_div/BInv [1]), .B(\u_div/CryTmp[2][1] ), .Y(n6) );
  XOR2XLM U58 ( .A(n37), .B(\u_div/BInv [2]), .Y(n7) );
  XOR2XLM U59 ( .A(n7), .B(\u_div/CryTmp[2][2] ), .Y(\u_div/SumTmp[2][2] ) );
  NAND2XLM U60 ( .A(n37), .B(\u_div/BInv [2]), .Y(n8) );
  XOR2XLM U61 ( .A(n11), .B(n39), .Y(\u_div/SumTmp[4][3] ) );
  NAND2X3M U62 ( .A(n39), .B(\u_div/CryTmp[4][3] ), .Y(n12) );
  NAND2XLM U63 ( .A(n39), .B(\u_div/BInv [3]), .Y(n13) );
  MX2X1M U64 ( .A(n1), .B(\u_div/SumTmp[6][1] ), .S0(quotient[6]), .Y(n48) );
  INVXLM U65 ( .A(n92), .Y(n85) );
  INVX2M U66 ( .A(quotient[6]), .Y(n15) );
  MX2XLM U67 ( .A(n48), .B(\u_div/SumTmp[5][2] ), .S0(quotient[5]), .Y(n39) );
  NAND2X2M U68 ( .A(\u_div/SumTmp[6][0] ), .B(quotient[6]), .Y(n17) );
  MXI2XLM U69 ( .A(n38), .B(\u_div/SumTmp[2][4] ), .S0(quotient[2]), .Y(n55)
         );
  MXI2XLM U70 ( .A(n31), .B(\u_div/SumTmp[2][5] ), .S0(quotient[2]), .Y(n54)
         );
  INVX4M U71 ( .A(n22), .Y(quotient[2]) );
  INVX4M U72 ( .A(n86), .Y(quotient[6]) );
  INVX4M U73 ( .A(\u_div/CryTmp[4][4] ), .Y(n74) );
  CLKINVX1M U74 ( .A(b[4]), .Y(\u_div/BInv [4]) );
  CLKINVX4M U75 ( .A(\u_div/CryTmp[3][5] ), .Y(n79) );
  MXI2X6M U76 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(n77), .Y(n76) );
  CLKNAND2X4M U77 ( .A(\u_div/CryTmp[6][2] ), .B(n2), .Y(n86) );
  NAND2X1M U78 ( .A(\u_div/PartRem[6][1] ), .B(n18), .Y(n19) );
  INVX2M U79 ( .A(n54), .Y(\u_div/PartRem[2][6] ) );
  INVX2M U80 ( .A(\u_div/SumTmp[3][1] ), .Y(n28) );
  MXI2X6M U81 ( .A(n70), .B(n71), .S0(n72), .Y(\u_div/PartRem[4][1] ) );
  NOR2XLM U82 ( .A(n82), .B(n83), .Y(n81) );
  BUFX2M U83 ( .A(n32), .Y(quotient[4]) );
  NOR2X2M U84 ( .A(n74), .B(n73), .Y(n32) );
  MXI2X1M U85 ( .A(n28), .B(n29), .S0(n89), .Y(n37) );
  INVXLM U86 ( .A(\u_div/PartRem[4][1] ), .Y(n29) );
  MX2XLM U87 ( .A(n39), .B(\u_div/SumTmp[4][3] ), .S0(quotient[4]), .Y(n36) );
  MXI2XLM U88 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(n81), .Y(n59) );
  MXI2X4M U89 ( .A(n59), .B(n80), .S0(quotient[1]), .Y(\u_div/PartRem[1][2] )
         );
  MXI2XLM U90 ( .A(n37), .B(\u_div/SumTmp[2][2] ), .S0(quotient[2]), .Y(n57)
         );
  INVX3M U91 ( .A(n91), .Y(quotient[1]) );
  INVX2M U92 ( .A(n57), .Y(\u_div/PartRem[2][3] ) );
  INVX2M U93 ( .A(n63), .Y(\u_div/PartRem[4][2] ) );
  INVX2M U94 ( .A(n89), .Y(quotient[3]) );
  INVX2M U95 ( .A(n55), .Y(\u_div/PartRem[2][5] ) );
  INVX2M U96 ( .A(\u_div/SumTmp[1][6] ), .Y(n60) );
  NAND2X2M U97 ( .A(n26), .B(\u_div/BInv [5]), .Y(n78) );
  MXI2X1M U98 ( .A(n57), .B(n69), .S0(quotient[1]), .Y(\u_div/PartRem[1][4] )
         );
  INVX2M U99 ( .A(\u_div/SumTmp[1][3] ), .Y(n69) );
  MXI2X1M U100 ( .A(n55), .B(n61), .S0(quotient[1]), .Y(\u_div/PartRem[1][6] )
         );
  INVX2M U101 ( .A(\u_div/SumTmp[1][5] ), .Y(n61) );
  MXI2X1M U102 ( .A(n47), .B(\u_div/SumTmp[4][1] ), .S0(n32), .Y(n63) );
  MXI2XLM U103 ( .A(n35), .B(\u_div/SumTmp[2][3] ), .S0(quotient[2]), .Y(n56)
         );
  INVX2M U104 ( .A(n56), .Y(\u_div/PartRem[2][4] ) );
  MXI2X1M U105 ( .A(n56), .B(n62), .S0(quotient[1]), .Y(\u_div/PartRem[1][5] )
         );
  INVX2M U106 ( .A(\u_div/SumTmp[1][4] ), .Y(n62) );
  CLKINVX1M U107 ( .A(b[5]), .Y(\u_div/BInv [5]) );
  INVX2M U108 ( .A(a[4]), .Y(n70) );
  INVX2M U109 ( .A(\u_div/SumTmp[4][0] ), .Y(n71) );
  INVX2M U110 ( .A(a[5]), .Y(n64) );
  INVX2M U111 ( .A(\u_div/SumTmp[5][0] ), .Y(n65) );
  XNOR2XLM U112 ( .A(\u_div/BInv [0]), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2XLM U113 ( .A(\u_div/BInv [0]), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  XNOR2XLM U114 ( .A(\u_div/BInv [0]), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  INVX2M U115 ( .A(\u_div/SumTmp[1][2] ), .Y(n75) );
  NAND2BX1M U116 ( .AN(\u_div/BInv [0]), .B(n41), .Y(\u_div/CryTmp[0][1] ) );
  NAND2X2M U117 ( .A(n43), .B(n44), .Y(\u_div/CryTmp[2][1] ) );
  INVXLM U118 ( .A(\u_div/BInv [0]), .Y(n43) );
  OR2X1M U119 ( .A(\u_div/BInv [0]), .B(a[3]), .Y(\u_div/CryTmp[3][1] ) );
  MXI2XLM U120 ( .A(n54), .B(n60), .S0(quotient[1]), .Y(\u_div/PartRem[1][7] )
         );
  NAND2BX1M U121 ( .AN(\u_div/BInv [0]), .B(n42), .Y(\u_div/CryTmp[1][1] ) );
  INVX2M U122 ( .A(a[2]), .Y(n44) );
  INVX2M U123 ( .A(a[1]), .Y(n42) );
  XOR2XLM U124 ( .A(\u_div/BInv [0]), .B(a[1]), .Y(n40) );
  INVX2M U125 ( .A(a[0]), .Y(n41) );
  INVXLM U126 ( .A(\u_div/PartRem[5][1] ), .Y(n46) );
  INVX2M U127 ( .A(n46), .Y(n47) );
  NOR2XLM U128 ( .A(n52), .B(n92), .Y(quotient[7]) );
  INVXLM U129 ( .A(b[6]), .Y(\u_div/BInv [6]) );
  INVXLM U130 ( .A(b[7]), .Y(\u_div/BInv [7]) );
  MXI2X6M U131 ( .A(n42), .B(n40), .S0(n84), .Y(\u_div/PartRem[1][1] ) );
  NAND2BX1M U132 ( .AN(b[7]), .B(\u_div/CryTmp[1][7] ), .Y(n91) );
  NOR2BX8M U133 ( .AN(\u_div/CryTmp[1][7] ), .B(b[7]), .Y(n84) );
  CLKBUFX40M U134 ( .A(n67), .Y(n92) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_0  ( .A(a[4]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[4][1] ), .S(\u_div/SumTmp[4][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_0  ( .A(a[5]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[5][1] ), .S(\u_div/SumTmp[5][0] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_6_0  ( .A(a[6]), .B(\u_div/BInv [0]), .CI(1'b1), .CO(\u_div/CryTmp[6][1] ), .S(\u_div/SumTmp[6][0] ) );
endmodule


module ALU_test_1 ( A, B, ALU_FUN, EN, CLK, RST, ALU_OUT, OUT_VALID, test_si, 
        test_se );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST, test_si, test_se;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n48, n49,
         n50, n51, n53, n60, n61, n62, n63, n64, n65, n71, n72, n73, n77, n78,
         n79, n83, n84, n85, n89, n90, n91, n95, n96, n97, n105, n106, n107,
         n109, n118, n120, n121, n123, n3, n6, n7, n8, n9, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n52, n54, n55, n56, n57, n58, n59, n66, n67, n68, n69,
         n70, n74, n75, n76, n80, n81, n82, n86, n87, n88, n92, n93, n94, n98,
         n99, n100, n101, n102, n103, n104, n108, n110, n111, n112, n113, n114,
         n115, n116, n117, n119, n122, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n203, n204;
  wire   [15:0] ALU_OUT_Comb;

  SDFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .SI(ALU_OUT[6]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[7]) );
  SDFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .SI(ALU_OUT[5]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[6]) );
  SDFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .SI(ALU_OUT[4]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[5]) );
  SDFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .SI(ALU_OUT[3]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[4]) );
  SDFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .SI(ALU_OUT[2]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[3]) );
  SDFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .SI(ALU_OUT[1]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[2]) );
  SDFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .SI(ALU_OUT[14]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[15]) );
  SDFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .SI(ALU_OUT[13]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[14]) );
  SDFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .SI(ALU_OUT[12]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[13]) );
  SDFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .SI(ALU_OUT[11]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[12]) );
  SDFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .SI(ALU_OUT[10]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[11]) );
  SDFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .SI(ALU_OUT[9]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[10]) );
  SDFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .SI(ALU_OUT[8]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[9]) );
  SDFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .SI(ALU_OUT[7]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[8]) );
  SDFFRHQX1M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[0]) );
  SDFFRQX1M OUT_VALID_reg ( .D(EN), .SI(ALU_OUT[15]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(OUT_VALID) );
  SDFFRQX1M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .SI(ALU_OUT[0]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[1]) );
  BUFX4M U7 ( .A(A[7]), .Y(n45) );
  INVX2M U23 ( .A(n32), .Y(n33) );
  BUFX4M U24 ( .A(B[5]), .Y(n35) );
  INVX2M U25 ( .A(n6), .Y(n7) );
  BUFX4M U26 ( .A(B[1]), .Y(n38) );
  BUFX4M U27 ( .A(B[6]), .Y(n39) );
  AO22X1M U28 ( .A0(N110), .A1(n148), .B0(N92), .B1(n27), .Y(n144) );
  BUFX2M U29 ( .A(A[5]), .Y(n43) );
  BUFX2M U30 ( .A(A[6]), .Y(n44) );
  CLKINVX2M U31 ( .A(B[4]), .Y(n32) );
  AND2X2M U32 ( .A(n120), .B(n111), .Y(n3) );
  BUFX10M U35 ( .A(B[7]), .Y(n28) );
  DLY1X1M U36 ( .A(B[7]), .Y(n30) );
  DLY1X1M U37 ( .A(B[7]), .Y(n29) );
  INVX2M U38 ( .A(B[2]), .Y(n6) );
  INVXLM U39 ( .A(n6), .Y(n8) );
  NOR2X4M U40 ( .A(N125), .B(n102), .Y(n128) );
  INVX2M U41 ( .A(n64), .Y(n130) );
  INVX2M U42 ( .A(n65), .Y(n133) );
  INVX2M U43 ( .A(n129), .Y(n150) );
  INVX2M U44 ( .A(n116), .Y(n142) );
  INVX2M U45 ( .A(n131), .Y(n149) );
  INVX2M U46 ( .A(n135), .Y(n152) );
  OAI2BB1X2M U47 ( .A0N(N123), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U48 ( .A0N(N122), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U49 ( .A0N(N124), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X2M U50 ( .A0N(N118), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[9]) );
  OAI2BB1X2M U51 ( .A0N(N119), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U52 ( .A0N(N120), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U53 ( .A0N(N121), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U54 ( .A0N(n150), .A1N(n153), .B0(n118), .Y(n64) );
  OAI2BB1X2M U55 ( .A0N(n151), .A1N(n154), .B0(n118), .Y(n65) );
  OR2X2M U56 ( .A(n156), .B(n55), .Y(n129) );
  INVX2M U57 ( .A(n46), .Y(n154) );
  NAND3BX2M U58 ( .AN(n156), .B(n153), .C(n55), .Y(n116) );
  OR2X2M U59 ( .A(n47), .B(n46), .Y(n135) );
  OR2X2M U60 ( .A(n56), .B(n129), .Y(n131) );
  INVX2M U61 ( .A(n52), .Y(n148) );
  NAND3BX2M U62 ( .AN(n156), .B(n151), .C(n55), .Y(n52) );
  NOR2X2M U63 ( .A(n54), .B(n47), .Y(n9) );
  NOR2X2M U64 ( .A(n56), .B(n54), .Y(n27) );
  INVX2M U65 ( .A(n123), .Y(n54) );
  INVX2M U66 ( .A(n63), .Y(n134) );
  INVX2M U67 ( .A(n56), .Y(n151) );
  INVX2M U68 ( .A(n47), .Y(n153) );
  NOR2BX2M U69 ( .AN(n148), .B(n191), .Y(n48) );
  INVX2M U70 ( .A(n140), .Y(n88) );
  NOR2X2M U71 ( .A(n125), .B(n124), .Y(n126) );
  NOR2X2M U72 ( .A(n113), .B(n112), .Y(n127) );
  AOI31X2M U73 ( .A0(n101), .A1(n100), .A2(n99), .B0(n191), .Y(ALU_OUT_Comb[7]) );
  AOI21X2M U74 ( .A0(n50), .A1(n51), .B0(n191), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U75 ( .A0(N99), .A1(n27), .B0(n190), .Y(n50) );
  AOI2BB2XLM U76 ( .B0(N117), .B1(n148), .A0N(n194), .A1N(n53), .Y(n51) );
  INVX2M U77 ( .A(ALU_FUN[2]), .Y(n55) );
  OR2X2M U78 ( .A(ALU_FUN[1]), .B(n55), .Y(n46) );
  NAND3BX2M U79 ( .AN(ALU_FUN[0]), .B(ALU_FUN[3]), .C(n150), .Y(n53) );
  NOR2X2M U80 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n123) );
  NAND3BX2M U81 ( .AN(n157), .B(ALU_FUN[3]), .C(n154), .Y(n140) );
  NOR3X2M U82 ( .A(n157), .B(ALU_FUN[2]), .C(n156), .Y(n106) );
  AND3X2M U83 ( .A(n123), .B(n157), .C(ALU_FUN[3]), .Y(n63) );
  NAND2X2M U84 ( .A(EN), .B(n190), .Y(n49) );
  INVX2M U85 ( .A(n109), .Y(n190) );
  AOI211X2M U86 ( .A0(N108), .A1(n9), .B0(n149), .C0(n64), .Y(n109) );
  INVX2M U87 ( .A(ALU_FUN[0]), .Y(n157) );
  OR2X2M U88 ( .A(ALU_FUN[3]), .B(n157), .Y(n47) );
  OR2X2M U89 ( .A(ALU_FUN[0]), .B(ALU_FUN[3]), .Y(n56) );
  INVX2M U90 ( .A(ALU_FUN[1]), .Y(n156) );
  NAND3X2M U91 ( .A(n123), .B(ALU_FUN[0]), .C(ALU_FUN[3]), .Y(n118) );
  AND4X2M U92 ( .A(N159), .B(n154), .C(ALU_FUN[3]), .D(n157), .Y(n107) );
  AO22X1M U93 ( .A0(N95), .A1(n27), .B0(n197), .B1(n149), .Y(n74) );
  AO22X1M U94 ( .A0(N96), .A1(n27), .B0(n196), .B1(n149), .Y(n81) );
  AO22X1M U95 ( .A0(N97), .A1(n27), .B0(n195), .B1(n149), .Y(n92) );
  NOR3X2M U96 ( .A(n156), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n121) );
  INVX2M U97 ( .A(EN), .Y(n191) );
  INVX2M U98 ( .A(n122), .Y(n113) );
  AOI31X2M U99 ( .A0(n66), .A1(n59), .A2(n58), .B0(n191), .Y(ALU_OUT_Comb[2])
         );
  AOI22X1M U100 ( .A0(N102), .A1(n9), .B0(n152), .B1(n40), .Y(n59) );
  AOI211X2M U101 ( .A0(N111), .A1(n148), .B0(n57), .C0(n95), .Y(n58) );
  AOI22XLM U102 ( .A0(n41), .A1(n88), .B0(N127), .B1(n142), .Y(n66) );
  BUFX2M U103 ( .A(B[5]), .Y(n36) );
  AOI31X2M U104 ( .A0(n70), .A1(n69), .A2(n68), .B0(n191), .Y(ALU_OUT_Comb[3])
         );
  AOI22X1M U105 ( .A0(N103), .A1(n9), .B0(n41), .B1(n152), .Y(n69) );
  AOI211X2M U106 ( .A0(N112), .A1(n148), .B0(n67), .C0(n89), .Y(n68) );
  AOI22XLM U107 ( .A0(n42), .A1(n88), .B0(N128), .B1(n142), .Y(n70) );
  AOI31X2M U108 ( .A0(n80), .A1(n76), .A2(n75), .B0(n191), .Y(ALU_OUT_Comb[4])
         );
  AOI22X1M U109 ( .A0(N104), .A1(n9), .B0(n42), .B1(n152), .Y(n76) );
  AOI211X2M U110 ( .A0(N113), .A1(n148), .B0(n74), .C0(n83), .Y(n75) );
  BUFX2M U111 ( .A(A[7]), .Y(n31) );
  AOI22X1M U112 ( .A0(N106), .A1(n9), .B0(n44), .B1(n152), .Y(n94) );
  AOI211X2M U113 ( .A0(N115), .A1(n148), .B0(n92), .C0(n71), .Y(n93) );
  AOI31X2M U114 ( .A0(n87), .A1(n86), .A2(n82), .B0(n191), .Y(ALU_OUT_Comb[5])
         );
  AOI22X1M U115 ( .A0(N105), .A1(n9), .B0(n43), .B1(n152), .Y(n86) );
  AOI22XLM U116 ( .A0(n44), .A1(n88), .B0(N130), .B1(n142), .Y(n87) );
  AOI211X2M U117 ( .A0(N114), .A1(n148), .B0(n81), .C0(n77), .Y(n82) );
  INVX2M U118 ( .A(n169), .Y(n187) );
  NAND3X2M U119 ( .A(n122), .B(n3), .C(n119), .Y(n124) );
  NAND2X2M U120 ( .A(n114), .B(n3), .Y(n112) );
  AOI221XLM U121 ( .A0(n63), .A1(n195), .B0(n44), .B1(n65), .C0(n152), .Y(n72)
         );
  AOI221XLM U122 ( .A0(n44), .A1(n63), .B0(n64), .B1(n195), .C0(n149), .Y(n73)
         );
  OAI222X1M U123 ( .A0(n84), .A1(n32), .B0(n34), .B1(n85), .C0(n53), .C1(n198), 
        .Y(n83) );
  AOI221XLM U124 ( .A0(n42), .A1(n63), .B0(n64), .B1(n197), .C0(n149), .Y(n85)
         );
  AOI221XLM U125 ( .A0(n63), .A1(n197), .B0(n42), .B1(n65), .C0(n152), .Y(n84)
         );
  OAI222X1M U126 ( .A0(n78), .A1(n193), .B0(n36), .B1(n79), .C0(n53), .C1(n197), .Y(n77) );
  INVX2M U127 ( .A(n37), .Y(n193) );
  AOI221XLM U128 ( .A0(n43), .A1(n63), .B0(n64), .B1(n196), .C0(n149), .Y(n79)
         );
  AOI221XLM U129 ( .A0(n63), .A1(n196), .B0(n43), .B1(n65), .C0(n152), .Y(n78)
         );
  NAND4X2M U130 ( .A(n117), .B(n116), .C(n115), .D(n114), .Y(n125) );
  NAND3X2M U131 ( .A(n115), .B(n119), .C(n117), .Y(n102) );
  OR2X2M U132 ( .A(n155), .B(n140), .Y(n114) );
  MX2X2M U133 ( .A(n149), .B(n152), .S0(n38), .Y(n143) );
  MX2X2M U134 ( .A(n130), .B(n134), .S0(n38), .Y(n132) );
  AND2X2M U135 ( .A(n136), .B(n135), .Y(n137) );
  MX2X2M U136 ( .A(n134), .B(n133), .S0(n38), .Y(n136) );
  AO22X1M U137 ( .A0(N93), .A1(n27), .B0(n199), .B1(n149), .Y(n57) );
  AO22X1M U138 ( .A0(N94), .A1(n27), .B0(n198), .B1(n149), .Y(n67) );
  BUFX2M U139 ( .A(B[5]), .Y(n37) );
  NAND2X2M U140 ( .A(N109), .B(n148), .Y(n122) );
  INVX2M U141 ( .A(n42), .Y(n197) );
  INVX2M U142 ( .A(n41), .Y(n198) );
  INVX2M U143 ( .A(n40), .Y(n199) );
  INVX2M U144 ( .A(n44), .Y(n195) );
  INVX2M U145 ( .A(n43), .Y(n196) );
  AOI21X2M U146 ( .A0(n147), .A1(n146), .B0(n191), .Y(ALU_OUT_Comb[1]) );
  AOI211X2M U147 ( .A0(A[0]), .A1(n145), .B0(n144), .C0(n143), .Y(n146) );
  INVX2M U148 ( .A(n53), .Y(n145) );
  BUFX2M U149 ( .A(A[4]), .Y(n42) );
  BUFX2M U150 ( .A(A[3]), .Y(n41) );
  BUFX2M U151 ( .A(A[2]), .Y(n40) );
  OAI2B11X2M U152 ( .A1N(n40), .A0(n140), .B0(n105), .C0(n139), .Y(n141) );
  MX2X2M U153 ( .A(n138), .B(n137), .S0(A[1]), .Y(n139) );
  AOI31X2M U154 ( .A0(N158), .A1(ALU_FUN[3]), .A2(n106), .B0(n107), .Y(n105)
         );
  AND2X2M U155 ( .A(n132), .B(n131), .Y(n138) );
  INVX2M U156 ( .A(A[1]), .Y(n155) );
  MX2X2M U157 ( .A(n110), .B(n108), .S0(A[0]), .Y(n111) );
  AOI31X2M U158 ( .A0(N157), .A1(ALU_FUN[3]), .A2(n121), .B0(n107), .Y(n120)
         );
  AND2X2M U159 ( .A(n103), .B(n131), .Y(n110) );
  AND2X2M U160 ( .A(n104), .B(n135), .Y(n108) );
  AOI221XLM U161 ( .A0(n63), .A1(n199), .B0(n40), .B1(n65), .C0(n152), .Y(n96)
         );
  AOI221XLM U162 ( .A0(n40), .A1(n63), .B0(n64), .B1(n199), .C0(n149), .Y(n97)
         );
  AOI221XLM U163 ( .A0(n63), .A1(n198), .B0(n41), .B1(n65), .C0(n152), .Y(n90)
         );
  AOI221XLM U164 ( .A0(n41), .A1(n63), .B0(n64), .B1(n198), .C0(n149), .Y(n91)
         );
  INVX2M U165 ( .A(n158), .Y(n185) );
  NAND2X2M U166 ( .A(N100), .B(n9), .Y(n115) );
  NAND2X2M U167 ( .A(N91), .B(n27), .Y(n119) );
  AOI21XLM U168 ( .A0(n158), .A1(n155), .B0(n38), .Y(n159) );
  INVXLM U169 ( .A(B[3]), .Y(n188) );
  AOI211X2M U170 ( .A0(n128), .A1(n127), .B0(n126), .C0(n191), .Y(
        ALU_OUT_Comb[0]) );
  OAI222XLM U171 ( .A0(n96), .A1(n186), .B0(n8), .B1(n97), .C0(n53), .C1(n155), 
        .Y(n95) );
  INVXLM U172 ( .A(n8), .Y(n186) );
  INVXLM U173 ( .A(n31), .Y(n194) );
  AOI31X2M U174 ( .A0(n98), .A1(n94), .A2(n93), .B0(n191), .Y(ALU_OUT_Comb[6])
         );
  OA22X2M U175 ( .A0(n135), .A1(n194), .B0(n131), .B1(n31), .Y(n100) );
  AOI22XLM U176 ( .A0(N132), .A1(n142), .B0(N107), .B1(n9), .Y(n101) );
  AOI221XLM U177 ( .A0(N98), .A1(n27), .B0(N116), .B1(n148), .C0(n60), .Y(n99)
         );
  INVXLM U178 ( .A(n203), .Y(n189) );
  INVXLM U179 ( .A(n30), .Y(n192) );
  OAI222XLM U180 ( .A0(n72), .A1(n189), .B0(n203), .B1(n73), .C0(n53), .C1(
        n196), .Y(n71) );
  AOI32XLM U181 ( .A0(n164), .A1(n174), .A2(n177), .B0(n204), .B1(n195), .Y(
        n165) );
  XNOR2XLM U182 ( .A(n44), .B(n203), .Y(n177) );
  INVXLM U183 ( .A(n32), .Y(n34) );
  AOI22XLM U184 ( .A0(n31), .A1(n88), .B0(N131), .B1(n142), .Y(n98) );
  AOI221XLM U185 ( .A0(n63), .A1(n194), .B0(n31), .B1(n65), .C0(n152), .Y(n61)
         );
  AOI221XLM U186 ( .A0(n63), .A1(n31), .B0(n64), .B1(n194), .C0(n149), .Y(n62)
         );
  OAI222XLM U187 ( .A0(n90), .A1(n188), .B0(B[3]), .B1(n91), .C0(n53), .C1(
        n199), .Y(n89) );
  NAND2XLM U188 ( .A(n30), .B(n194), .Y(n181) );
  MX2XLM U189 ( .A(n134), .B(n133), .S0(B[0]), .Y(n104) );
  MX2XLM U190 ( .A(n131), .B(n135), .S0(B[0]), .Y(n117) );
  MX2XLM U191 ( .A(n130), .B(n134), .S0(B[0]), .Y(n103) );
  INVXLM U192 ( .A(B[0]), .Y(n184) );
  OAI222XLM U193 ( .A0(n61), .A1(n192), .B0(n29), .B1(n62), .C0(n53), .C1(n195), .Y(n60) );
  NOR2XLM U194 ( .A(n194), .B(n30), .Y(n180) );
  AOI221XLM U195 ( .A0(N126), .A1(n142), .B0(N101), .B1(n9), .C0(n141), .Y(
        n147) );
  AOI22XLM U196 ( .A0(n43), .A1(n88), .B0(N129), .B1(n142), .Y(n80) );
  NAND2BX1M U197 ( .AN(n34), .B(n42), .Y(n173) );
  NAND2BX1M U198 ( .AN(n42), .B(n34), .Y(n162) );
  CLKNAND2X2M U199 ( .A(n173), .B(n162), .Y(n175) );
  NOR2X1M U200 ( .A(n188), .B(n41), .Y(n170) );
  NOR2X1M U201 ( .A(n186), .B(n40), .Y(n161) );
  NOR2X1M U202 ( .A(n184), .B(A[0]), .Y(n158) );
  CLKNAND2X2M U203 ( .A(n40), .B(n186), .Y(n172) );
  NAND2BX1M U204 ( .AN(n161), .B(n172), .Y(n167) );
  AOI211X1M U205 ( .A0(A[1]), .A1(n185), .B0(n167), .C0(n159), .Y(n160) );
  CLKNAND2X2M U206 ( .A(n41), .B(n188), .Y(n171) );
  OAI31X1M U207 ( .A0(n170), .A1(n161), .A2(n160), .B0(n171), .Y(n163) );
  NAND2BX1M U208 ( .AN(n43), .B(n36), .Y(n178) );
  OAI211X1M U209 ( .A0(n175), .A1(n163), .B0(n162), .C0(n178), .Y(n164) );
  NAND2BX1M U210 ( .AN(n36), .B(n43), .Y(n174) );
  OAI21X1M U211 ( .A0(n180), .A1(n165), .B0(n181), .Y(N159) );
  CLKNAND2X2M U212 ( .A(A[0]), .B(n184), .Y(n168) );
  OA21X1M U213 ( .A0(n168), .A1(n155), .B0(n38), .Y(n166) );
  AOI211X1M U214 ( .A0(n168), .A1(n155), .B0(n167), .C0(n166), .Y(n169) );
  AOI31X1M U215 ( .A0(n187), .A1(n172), .A2(n171), .B0(n170), .Y(n176) );
  OAI2B11X1M U216 ( .A1N(n176), .A0(n175), .B0(n174), .C0(n173), .Y(n179) );
  AOI32X1M U217 ( .A0(n179), .A1(n178), .A2(n177), .B0(n44), .B1(n189), .Y(
        n182) );
  AOI2B1X1M U218 ( .A1N(n182), .A0(n181), .B0(n180), .Y(n183) );
  CLKINVX1M U219 ( .A(n183), .Y(N158) );
  NOR2X1M U220 ( .A(N159), .B(N158), .Y(N157) );
  BUFX4M U222 ( .A(B[6]), .Y(n203) );
  BUFX4M U223 ( .A(B[6]), .Y(n204) );
  ALU_DW01_sub_0 sub_52 ( .A({1'b0, n31, n44, n43, n42, n41, n40, A[1:0]}), 
        .B({1'b0, n30, n203, n37, n34, B[3], n8, n38, B[0]}), .CI(1'b0), 
        .DIFF({N108, N107, N106, N105, N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_48 ( .A({1'b0, n31, n44, n43, n42, n41, n40, A[1:0]}), 
        .B({1'b0, n29, n204, n36, n34, B[3], n8, n38, B[0]}), .CI(1'b0), .SUM(
        {N99, N98, N97, N96, N95, N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_56 ( .A({n31, n44, n43, n42, n41, n40, A[1:0]}), .B({
        n29, n204, n36, n34, B[3], n8, n38, B[0]}), .TC(1'b0), .PRODUCT({N124, 
        N123, N122, N121, N120, N119, N118, N117, N116, N115, N114, N113, N112, 
        N111, N110, N109}) );
  ALU_DW_div_uns_1 div_60 ( .a({n45, n44, n43, n42, n41, n40, A[1:0]}), .b({
        n28, n39, n35, n33, B[3], n7, n38, B[0]}), .quotient({N132, N131, N130, 
        N129, N128, N127, N126, N125}) );
endmodule


module tx_controller_test_1 ( Data_Valid, PAR_EN, ser_done, CLK, RST, ser_en, 
        mux_sel, busy, test_si, test_so, test_se );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, CLK, RST, test_si, test_se;
  output ser_en, busy, test_so;
  wire   n9, n10, n11, n12, n4, n5, n6, n7, n8;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = current_state[2];

  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(n5), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[1]) );
  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(n6), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(current_state[0]) );
  OAI21X2M U6 ( .A0(n10), .A1(n5), .B0(n12), .Y(mux_sel[1]) );
  NAND2X2M U7 ( .A(n5), .B(n6), .Y(n12) );
  OAI33X2M U8 ( .A0(n5), .A1(current_state[2]), .A2(current_state[1]), .B0(n10), .B1(ser_done), .B2(current_state[0]), .Y(ser_en) );
  NAND2X2M U9 ( .A(current_state[1]), .B(n7), .Y(n10) );
  INVX2M U10 ( .A(current_state[0]), .Y(n5) );
  INVX2M U11 ( .A(current_state[2]), .Y(n7) );
  OAI221X1M U12 ( .A0(n12), .A1(n7), .B0(current_state[2]), .B1(n5), .C0(n10), 
        .Y(busy) );
  OAI31X1M U13 ( .A0(n8), .A1(current_state[0]), .A2(n10), .B0(n4), .Y(
        next_state[1]) );
  INVX2M U14 ( .A(ser_en), .Y(n4) );
  NOR3X2M U15 ( .A(n11), .B(current_state[2]), .C(current_state[0]), .Y(
        next_state[0]) );
  AOI32X1M U16 ( .A0(ser_done), .A1(current_state[1]), .A2(PAR_EN), .B0(
        Data_Valid), .B1(n6), .Y(n11) );
  NOR2X2M U17 ( .A(n9), .B(n10), .Y(next_state[2]) );
  AOI21X2M U18 ( .A0(ser_done), .A1(n8), .B0(current_state[0]), .Y(n9) );
  INVX2M U19 ( .A(current_state[1]), .Y(n6) );
  INVX2M U20 ( .A(PAR_EN), .Y(n8) );
  OAI21X2M U21 ( .A0(current_state[2]), .A1(current_state[0]), .B0(n12), .Y(
        mux_sel[0]) );
endmodule


module Parity_Calc_test_1 ( CLK, RST, PAR_EN, PAR_TYP, P_DATA, busy, 
        Data_Valid, par_bit, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, busy, Data_Valid, test_si, test_se;
  output par_bit;
  wire   n1, n2, n3, n4, n5, n6, n8;

  SDFFRQX2M par_bit_reg ( .D(n8), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(par_bit) );
  XNOR2X2M U2 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  XOR3XLM U3 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U4 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n2), .A0N(par_bit), .A1N(n2), .Y(n8) );
  NAND3BX2M U6 ( .AN(busy), .B(Data_Valid), .C(PAR_EN), .Y(n2) );
  XOR3XLM U7 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
endmodule


module Serializer_test_1 ( P_DATA, Data_Valid, busy, ser_en, CLK, RST, 
        ser_data, ser_done, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input Data_Valid, busy, ser_en, CLK, RST, test_si, test_se;
  output ser_data, ser_done, test_so;
  wire   n17, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n15, n16, n18, n48, n49, n52, n53;
  wire   [7:0] temp_data;
  wire   [3:0] count;
  assign test_so = temp_data[7];

  SDFFRQX2M \temp_data_reg[6]  ( .D(n38), .SI(temp_data[5]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[6]) );
  SDFFRQX2M \temp_data_reg[5]  ( .D(n39), .SI(temp_data[4]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[5]) );
  SDFFRQX2M \temp_data_reg[4]  ( .D(n40), .SI(temp_data[3]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[4]) );
  SDFFRQX2M \temp_data_reg[3]  ( .D(n41), .SI(temp_data[2]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[3]) );
  SDFFRQX2M \temp_data_reg[2]  ( .D(n42), .SI(temp_data[1]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[2]) );
  SDFFRQX2M \temp_data_reg[1]  ( .D(n43), .SI(temp_data[0]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[1]) );
  SDFFRQX2M \temp_data_reg[0]  ( .D(n44), .SI(ser_data), .SE(n53), .CK(CLK), 
        .RN(RST), .Q(temp_data[0]) );
  SDFFRQX2M ser_data_reg ( .D(n36), .SI(n49), .SE(n53), .CK(CLK), .RN(RST), 
        .Q(ser_data) );
  SDFFRQX2M \temp_data_reg[7]  ( .D(n37), .SI(temp_data[6]), .SE(n53), .CK(CLK), .RN(RST), .Q(temp_data[7]) );
  SDFFRQX2M \count_reg[2]  ( .D(n15), .SI(count[1]), .SE(n53), .CK(CLK), .RN(
        RST), .Q(count[2]) );
  SDFFRQX2M \count_reg[0]  ( .D(n47), .SI(test_si), .SE(n53), .CK(CLK), .RN(
        RST), .Q(count[0]) );
  SDFFRQX2M \count_reg[1]  ( .D(n45), .SI(count[0]), .SE(n53), .CK(CLK), .RN(
        RST), .Q(count[1]) );
  SDFFRX1M \count_reg[3]  ( .D(n46), .SI(n48), .SE(n53), .CK(CLK), .RN(RST), 
        .Q(n49), .QN(n17) );
  NOR4X1M U17 ( .A(n17), .B(count[0]), .C(count[1]), .D(count[2]), .Y(ser_done) );
  NOR2X2M U18 ( .A(n16), .B(n21), .Y(n19) );
  NOR2X2M U19 ( .A(n21), .B(n19), .Y(n20) );
  INVX2M U20 ( .A(n35), .Y(n16) );
  NOR2BX2M U21 ( .AN(ser_en), .B(ser_done), .Y(n35) );
  INVX2M U22 ( .A(n32), .Y(n18) );
  NOR2BX2M U23 ( .AN(Data_Valid), .B(busy), .Y(n21) );
  AOI2BB2XLM U24 ( .B0(n16), .B1(ser_en), .A0N(count[0]), .A1N(n16), .Y(n31)
         );
  OAI2B2X1M U25 ( .A1N(count[1]), .A0(n31), .B0(count[1]), .B1(n32), .Y(n45)
         );
  OAI21X2M U26 ( .A0(count[1]), .A1(n16), .B0(n31), .Y(n30) );
  OAI21X2M U27 ( .A0(n33), .A1(n17), .B0(n34), .Y(n46) );
  NAND4X2M U28 ( .A(count[2]), .B(count[1]), .C(n18), .D(n17), .Y(n34) );
  AOI21X2M U29 ( .A0(n35), .A1(n48), .B0(n30), .Y(n33) );
  NAND2X2M U30 ( .A(count[0]), .B(n35), .Y(n32) );
  NOR2X2M U31 ( .A(count[0]), .B(n16), .Y(n47) );
  INVX2M U32 ( .A(n29), .Y(n15) );
  AOI32X1M U33 ( .A0(count[1]), .A1(n48), .A2(n18), .B0(n30), .B1(count[2]), 
        .Y(n29) );
  OAI2BB1X2M U34 ( .A0N(temp_data[0]), .A1N(n20), .B0(n28), .Y(n44) );
  AOI22X1M U35 ( .A0(temp_data[1]), .A1(n19), .B0(P_DATA[0]), .B1(n21), .Y(n28) );
  OAI2BB1X2M U36 ( .A0N(n20), .A1N(temp_data[1]), .B0(n27), .Y(n43) );
  AOI22X1M U37 ( .A0(temp_data[2]), .A1(n19), .B0(P_DATA[1]), .B1(n21), .Y(n27) );
  OAI2BB1X2M U38 ( .A0N(n20), .A1N(temp_data[2]), .B0(n26), .Y(n42) );
  AOI22X1M U39 ( .A0(temp_data[3]), .A1(n19), .B0(P_DATA[2]), .B1(n21), .Y(n26) );
  OAI2BB1X2M U40 ( .A0N(n20), .A1N(temp_data[3]), .B0(n25), .Y(n41) );
  AOI22X1M U41 ( .A0(temp_data[4]), .A1(n19), .B0(P_DATA[3]), .B1(n21), .Y(n25) );
  OAI2BB1X2M U42 ( .A0N(n20), .A1N(temp_data[4]), .B0(n24), .Y(n40) );
  AOI22X1M U43 ( .A0(temp_data[5]), .A1(n19), .B0(P_DATA[4]), .B1(n21), .Y(n24) );
  OAI2BB1X2M U44 ( .A0N(n20), .A1N(temp_data[5]), .B0(n23), .Y(n39) );
  AOI22X1M U45 ( .A0(temp_data[6]), .A1(n19), .B0(P_DATA[5]), .B1(n21), .Y(n23) );
  OAI2BB1X2M U46 ( .A0N(n20), .A1N(temp_data[6]), .B0(n22), .Y(n38) );
  AOI22X1M U47 ( .A0(temp_data[7]), .A1(n19), .B0(P_DATA[6]), .B1(n21), .Y(n22) );
  AO22X1M U48 ( .A0(n19), .A1(temp_data[0]), .B0(ser_data), .B1(n20), .Y(n36)
         );
  AO22X1M U49 ( .A0(n20), .A1(temp_data[7]), .B0(P_DATA[7]), .B1(n21), .Y(n37)
         );
  INVX2M U50 ( .A(count[2]), .Y(n48) );
  INVXLM U51 ( .A(test_se), .Y(n52) );
  INVXLM U52 ( .A(n52), .Y(n53) );
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


module UART_TX_test_1 ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, CLK, RST, TX_OUT, 
        busy, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, CLK, RST, test_si, test_se;
  output TX_OUT, busy, test_so;
  wire   ser_done, ser_en, par_bit, ser_data, n1, n2, n4;
  wire   [1:0] mux_sel;

  INVX2M U4 ( .A(n2), .Y(n1) );
  INVX2M U5 ( .A(RST), .Y(n2) );
  tx_controller_test_1 U1 ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), 
        .ser_done(ser_done), .CLK(CLK), .RST(n1), .ser_en(ser_en), .mux_sel(
        mux_sel), .busy(busy), .test_si(n4), .test_so(test_so), .test_se(
        test_se) );
  Parity_Calc_test_1 P1 ( .CLK(CLK), .RST(n1), .PAR_EN(PAR_EN), .PAR_TYP(
        PAR_TYP), .P_DATA(P_DATA), .busy(busy), .Data_Valid(Data_Valid), 
        .par_bit(par_bit), .test_si(test_si), .test_se(test_se) );
  Serializer_test_1 S1 ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), .busy(busy), 
        .ser_en(ser_en), .CLK(CLK), .RST(n1), .ser_data(ser_data), .ser_done(
        ser_done), .test_si(par_bit), .test_so(n4), .test_se(test_se) );
  mux_4_1 M1 ( .A(1'b0), .B(ser_data), .C(par_bit), .D(1'b1), .sel(mux_sel), 
        .out(TX_OUT) );
endmodule


module data_sampling_test_1 ( RX_IN, Prescale, enable, edge_count, CLK, RST, 
        sampled_bit, test_si, test_so, test_se );
  input [5:0] Prescale;
  input [2:0] edge_count;
  input RX_IN, enable, CLK, RST, test_si, test_se;
  output sampled_bit, test_so;
  wire   \half_minus_one[0] , n12, n13, n14, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n2, n3, n4, n5, n7, n8;
  assign \half_minus_one[0]  = Prescale[1];

  SDFFRX1M \sample_test_reg[0]  ( .D(n30), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), .Q(n8), .QN(n14) );
  SDFFRX1M \sample_test_reg[1]  ( .D(n31), .SI(n8), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n7), .QN(n13) );
  SDFFRX1M \sample_test_reg[2]  ( .D(n32), .SI(n7), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(test_so), .QN(n12) );
  AOI21X2M U7 ( .A0(n14), .A1(n12), .B0(n13), .Y(sampled_bit) );
  OAI32X1M U8 ( .A0(n14), .A1(n3), .A2(n2), .B0(n19), .B1(n20), .Y(n30) );
  INVX2M U9 ( .A(enable), .Y(n2) );
  INVX2M U10 ( .A(n20), .Y(n3) );
  NAND3X2M U11 ( .A(n21), .B(n22), .C(n23), .Y(n20) );
  OAI2B2X1M U12 ( .A1N(n25), .A0(n19), .B0(n13), .B1(n25), .Y(n31) );
  OAI31X1M U13 ( .A0(n21), .A1(n4), .A2(n26), .B0(enable), .Y(n25) );
  INVX2M U14 ( .A(n27), .Y(n4) );
  XOR3XLM U15 ( .A(edge_count[2]), .B(Prescale[3]), .C(n5), .Y(n26) );
  OAI2B2X1M U16 ( .A1N(n28), .A0(n19), .B0(n28), .B1(n12), .Y(n32) );
  OAI31X1M U17 ( .A0(n29), .A1(n21), .A2(n27), .B0(enable), .Y(n28) );
  CLKXOR2X2M U18 ( .A(edge_count[2]), .B(Prescale[3]), .Y(n29) );
  XOR3XLM U19 ( .A(edge_count[2]), .B(Prescale[3]), .C(n24), .Y(n23) );
  NAND2BX2M U20 ( .AN(\half_minus_one[0] ), .B(n5), .Y(n24) );
  XOR3XLM U21 ( .A(\half_minus_one[0] ), .B(edge_count[1]), .C(Prescale[2]), 
        .Y(n22) );
  NAND2X2M U22 ( .A(RX_IN), .B(enable), .Y(n19) );
  CLKXOR2X2M U23 ( .A(\half_minus_one[0] ), .B(edge_count[0]), .Y(n21) );
  CLKXOR2X2M U24 ( .A(edge_count[1]), .B(Prescale[2]), .Y(n27) );
  INVX2M U25 ( .A(Prescale[2]), .Y(n5) );
endmodule


module edge_bit_counter_test_1 ( enable, CLK, RST, bit_cnt, edge_cnt, test_si, 
        test_se );
  output [3:0] bit_cnt;
  output [2:0] edge_cnt;
  input enable, CLK, RST, test_si, test_se;
  wire   n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n8, n9, n10, n11;

  SDFFRQX2M \bit_cnt_reg[3]  ( .D(n28), .SI(bit_cnt[2]), .SE(test_se), .CK(CLK), .RN(RST), .Q(bit_cnt[3]) );
  SDFFRQX2M \bit_cnt_reg[2]  ( .D(n23), .SI(n9), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(bit_cnt[2]) );
  SDFFRQX2M \edge_cnt_reg[2]  ( .D(n27), .SI(n8), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(edge_cnt[2]) );
  SDFFRQX2M \edge_cnt_reg[0]  ( .D(n26), .SI(n11), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(edge_cnt[0]) );
  SDFFRQX2M \edge_cnt_reg[1]  ( .D(n25), .SI(edge_cnt[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(edge_cnt[1]) );
  SDFFRQX2M \bit_cnt_reg[0]  ( .D(n29), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(bit_cnt[0]) );
  SDFFRQX2M \bit_cnt_reg[1]  ( .D(n24), .SI(bit_cnt[0]), .SE(test_se), .CK(CLK), .RN(RST), .Q(bit_cnt[1]) );
  OAI21X2M U10 ( .A0(n19), .A1(n20), .B0(enable), .Y(n17) );
  NOR2BX2M U11 ( .AN(enable), .B(n19), .Y(n22) );
  NOR2BX2M U12 ( .AN(n14), .B(n9), .Y(n13) );
  OAI32X1M U13 ( .A0(n21), .A1(n12), .A2(n10), .B0(n13), .B1(n11), .Y(n28) );
  NAND2X2M U14 ( .A(bit_cnt[1]), .B(n11), .Y(n21) );
  INVX2M U15 ( .A(bit_cnt[3]), .Y(n11) );
  OAI32X1M U16 ( .A0(n12), .A1(bit_cnt[2]), .A2(n9), .B0(n13), .B1(n10), .Y(
        n23) );
  OAI22X1M U17 ( .A0(n15), .A1(n8), .B0(edge_cnt[1]), .B1(n16), .Y(n25) );
  OAI22X1M U18 ( .A0(n14), .A1(n9), .B0(bit_cnt[1]), .B1(n12), .Y(n24) );
  NAND3BX2M U19 ( .AN(n17), .B(edge_cnt[0]), .C(n19), .Y(n16) );
  XNOR2X2M U20 ( .A(edge_cnt[0]), .B(n17), .Y(n26) );
  NAND4X2M U21 ( .A(bit_cnt[3]), .B(bit_cnt[1]), .C(bit_cnt[0]), .D(n10), .Y(
        n20) );
  NAND3X2M U22 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .Y(n19) );
  NOR2BX2M U23 ( .AN(edge_cnt[0]), .B(n17), .Y(n15) );
  NAND3X2M U24 ( .A(bit_cnt[0]), .B(n20), .C(n22), .Y(n12) );
  OAI21X2M U25 ( .A0(n8), .A1(n16), .B0(n18), .Y(n27) );
  OAI2B1X2M U26 ( .A1N(n15), .A0(n19), .B0(edge_cnt[2]), .Y(n18) );
  INVX2M U27 ( .A(bit_cnt[1]), .Y(n9) );
  INVX2M U28 ( .A(bit_cnt[2]), .Y(n10) );
  AND2X2M U29 ( .A(n22), .B(bit_cnt[0]), .Y(n14) );
  CLKXOR2X2M U30 ( .A(bit_cnt[0]), .B(n22), .Y(n29) );
  INVX2M U31 ( .A(edge_cnt[1]), .Y(n8) );
endmodule


module RX_controller_test_1 ( RX_IN, PAR_EN, edge_cnt, bit_cnt, stp_err, 
        strt_glitch, par_err, CLK, RST, par_chk_en, strt_chk_en, stp_chk_en, 
        deser_en, samp_en, cnt_en, data_valid, test_so, test_se );
  input [2:0] edge_cnt;
  input [3:0] bit_cnt;
  input RX_IN, PAR_EN, stp_err, strt_glitch, par_err, CLK, RST, test_se;
  output par_chk_en, strt_chk_en, stp_chk_en, deser_en, samp_en, cnt_en,
         data_valid, test_so;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n5,
         n6, n7, n8, n9;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = n8;

  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(par_err), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(current_state[0]) );
  SDFFRX1M \current_state_reg[2]  ( .D(next_state[2]), .SI(n7), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[2]), .QN(n8) );
  NAND2X2M U7 ( .A(n16), .B(n6), .Y(n22) );
  NOR2X2M U8 ( .A(n8), .B(n11), .Y(stp_chk_en) );
  NAND2X2M U9 ( .A(n6), .B(n7), .Y(n11) );
  NAND2X2M U10 ( .A(n10), .B(n22), .Y(cnt_en) );
  INVX2M U11 ( .A(n22), .Y(deser_en) );
  NOR2X2M U12 ( .A(n7), .B(current_state[2]), .Y(n16) );
  OAI22X1M U14 ( .A0(strt_glitch), .A1(n10), .B0(par_err), .B1(n12), .Y(n19)
         );
  OAI31X1M U15 ( .A0(n12), .A1(par_err), .A2(n13), .B0(n14), .Y(next_state[2])
         );
  OAI31X1M U16 ( .A0(n10), .A1(strt_glitch), .A2(n13), .B0(n15), .Y(
        next_state[1]) );
  AOI31X2M U17 ( .A0(n13), .A1(n5), .A2(n16), .B0(deser_en), .Y(n15) );
  INVX2M U18 ( .A(par_err), .Y(n5) );
  NOR3X2M U19 ( .A(n6), .B(current_state[1]), .C(n8), .Y(data_valid) );
  NAND3X2M U20 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .Y(n13) );
  NAND3BX2M U21 ( .AN(stp_err), .B(stp_chk_en), .C(n9), .Y(n14) );
  INVX2M U22 ( .A(n13), .Y(n9) );
  NAND3X2M U23 ( .A(n7), .B(n8), .C(current_state[0]), .Y(n10) );
  NAND2X2M U24 ( .A(current_state[2]), .B(n11), .Y(samp_en) );
  INVX2M U25 ( .A(n12), .Y(par_chk_en) );
  NAND2X2M U26 ( .A(n16), .B(current_state[0]), .Y(n12) );
  INVX2M U27 ( .A(current_state[0]), .Y(n6) );
  AOI2BB1X2M U28 ( .A0N(n11), .A1N(current_state[2]), .B0(data_valid), .Y(n20)
         );
  NAND3X2M U29 ( .A(n17), .B(n14), .C(n18), .Y(next_state[0]) );
  NAND4X2M U30 ( .A(PAR_EN), .B(deser_en), .C(bit_cnt[3]), .D(n21), .Y(n17) );
  AOI2BB2XLM U31 ( .B0(n19), .B1(n13), .A0N(RX_IN), .A1N(n20), .Y(n18) );
  NOR4X1M U32 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .C(bit_cnt[0]), .D(n13), .Y(
        n21) );
  INVX2M U33 ( .A(n10), .Y(strt_chk_en) );
  SDFFRX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(n6), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[1]), .QN(n7) );
endmodule


module stop_check_test_1 ( sampled_bit, enable, CLK, RST, stp_err, test_si, 
        test_se );
  input sampled_bit, enable, CLK, RST, test_si, test_se;
  output stp_err;
  wire   n3, n1;

  SDFFRQX2M stp_err_reg ( .D(n3), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(stp_err) );
  OAI2BB2X1M U2 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n3)
         );
  INVX2M U3 ( .A(enable), .Y(n1) );
endmodule


module strt_check_test_1 ( enable, sampled_bit, CLK, RST, strt_glitch, test_si, 
        test_se );
  input enable, sampled_bit, CLK, RST, test_si, test_se;
  output strt_glitch;
  wire   n2;

  SDFFRQX2M strt_glitch_reg ( .D(n2), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(strt_glitch) );
  AO2B2X2M U2 ( .B0(sampled_bit), .B1(enable), .A0(strt_glitch), .A1N(enable), 
        .Y(n2) );
endmodule


module parity_check_test_1 ( enable, sampled_bit, PAR_TYP, P_DATA, CLK, RST, 
        par_err, test_si, test_se );
  input [7:0] P_DATA;
  input enable, sampled_bit, PAR_TYP, CLK, RST, test_si, test_se;
  output par_err;
  wire   par_bit, N9, n1, n3, n4, n5, n6, n8, n2;

  SDFFRQX2M par_bit_reg ( .D(N9), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(par_bit) );
  SDFFRQX2M par_err_reg ( .D(n8), .SI(par_bit), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(par_err) );
  XNOR2X2M U3 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XOR3XLM U4 ( .A(PAR_TYP), .B(n3), .C(n4), .Y(N9) );
  XOR3XLM U5 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
  XOR3XLM U6 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  XNOR2X2M U7 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  OAI2BB2X1M U8 ( .B0(n1), .B1(n2), .A0N(par_err), .A1N(n2), .Y(n8) );
  XNOR2X2M U9 ( .A(sampled_bit), .B(par_bit), .Y(n1) );
  INVX2M U10 ( .A(enable), .Y(n2) );
endmodule


module deserializer_test_1 ( sampled_bit, edge_cnt, enable, CLK, RST, P_DATA, 
        test_si, test_so, test_se );
  input [2:0] edge_cnt;
  output [7:0] P_DATA;
  input sampled_bit, enable, CLK, RST, test_si, test_se;
  output test_so;
  wire   n1, n2, n4, n5, n8, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n32, n34, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n3, n6, n7, n9;
  wire   [2:0] cnt;
  assign test_so = cnt[2];

  SDFFRQX2M \P_DATA_reg[5]  ( .D(n39), .SI(P_DATA[4]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[5]) );
  SDFFRQX2M \P_DATA_reg[1]  ( .D(n43), .SI(P_DATA[0]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[1]) );
  SDFFRQX2M \P_DATA_reg[4]  ( .D(n40), .SI(P_DATA[3]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[4]) );
  SDFFRQX2M \P_DATA_reg[0]  ( .D(n44), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[0]) );
  SDFFRQX2M \P_DATA_reg[7]  ( .D(n37), .SI(P_DATA[6]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[7]) );
  SDFFRQX2M \P_DATA_reg[3]  ( .D(n41), .SI(P_DATA[2]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[3]) );
  SDFFRQX2M \P_DATA_reg[6]  ( .D(n38), .SI(P_DATA[5]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[6]) );
  SDFFRQX2M \P_DATA_reg[2]  ( .D(n42), .SI(P_DATA[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(P_DATA[2]) );
  SDFFRQX2M \cnt_reg[2]  ( .D(n32), .SI(cnt[1]), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(cnt[2]) );
  SDFFRQX2M \cnt_reg[1]  ( .D(n34), .SI(n3), .SE(test_se), .CK(CLK), .RN(RST), 
        .Q(cnt[1]) );
  SDFFRQX2M \cnt_reg[0]  ( .D(n36), .SI(P_DATA[7]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(cnt[0]) );
  NAND2X2M U3 ( .A(sampled_bit), .B(n22), .Y(n17) );
  INVX2M U4 ( .A(n4), .Y(n9) );
  NAND2BX2M U5 ( .AN(n12), .B(sampled_bit), .Y(n10) );
  INVX2M U6 ( .A(n22), .Y(n7) );
  OAI221X1M U7 ( .A0(n4), .A1(n5), .B0(n9), .B1(n6), .C0(n8), .Y(n34) );
  XNOR2X2M U8 ( .A(n3), .B(n9), .Y(n36) );
  NAND2X2M U9 ( .A(n6), .B(n3), .Y(n15) );
  NAND4BX1M U10 ( .AN(edge_cnt[0]), .B(edge_cnt[1]), .C(enable), .D(
        edge_cnt[2]), .Y(n4) );
  NOR2X2M U11 ( .A(n4), .B(cnt[2]), .Y(n22) );
  OAI2B2X1M U12 ( .A1N(cnt[2]), .A0(n1), .B0(n2), .B1(n7), .Y(n32) );
  NOR2X2M U13 ( .A(n2), .B(n4), .Y(n1) );
  NAND2X2M U14 ( .A(cnt[2]), .B(n9), .Y(n12) );
  OAI21X2M U15 ( .A0(n2), .A1(n17), .B0(n18), .Y(n41) );
  OAI21X2M U16 ( .A0(n2), .A1(n7), .B0(P_DATA[3]), .Y(n18) );
  OAI21X2M U17 ( .A0(n2), .A1(n10), .B0(n11), .Y(n37) );
  OAI21X2M U18 ( .A0(n2), .A1(n12), .B0(P_DATA[7]), .Y(n11) );
  OAI21X2M U19 ( .A0(n8), .A1(n17), .B0(n19), .Y(n42) );
  OAI21X2M U20 ( .A0(n7), .A1(n8), .B0(P_DATA[2]), .Y(n19) );
  OAI21X2M U21 ( .A0(n15), .A1(n17), .B0(n21), .Y(n44) );
  OAI21X2M U22 ( .A0(n7), .A1(n15), .B0(P_DATA[0]), .Y(n21) );
  OAI21X2M U23 ( .A0(n5), .A1(n17), .B0(n20), .Y(n43) );
  OAI21X2M U24 ( .A0(n7), .A1(n5), .B0(P_DATA[1]), .Y(n20) );
  OAI21X2M U25 ( .A0(n5), .A1(n10), .B0(n14), .Y(n39) );
  OAI21X2M U26 ( .A0(n5), .A1(n12), .B0(P_DATA[5]), .Y(n14) );
  OAI21X2M U27 ( .A0(n10), .A1(n8), .B0(n13), .Y(n38) );
  OAI21X2M U28 ( .A0(n12), .A1(n8), .B0(P_DATA[6]), .Y(n13) );
  OAI21X2M U29 ( .A0(n10), .A1(n15), .B0(n16), .Y(n40) );
  OAI21X2M U30 ( .A0(n12), .A1(n15), .B0(P_DATA[4]), .Y(n16) );
  NAND2X2M U31 ( .A(cnt[1]), .B(cnt[0]), .Y(n2) );
  NAND2X2M U32 ( .A(cnt[1]), .B(n3), .Y(n8) );
  NAND2X2M U33 ( .A(cnt[0]), .B(n6), .Y(n5) );
  INVX2M U34 ( .A(cnt[0]), .Y(n3) );
  INVX2M U35 ( .A(cnt[1]), .Y(n6) );
endmodule


module UART_RX_test_1 ( RX_IN, PAR_EN, Prescale, PAR_TYP, RX_CLK, RST, P_DATA, 
        data_Valid, test_si, test_so, test_se );
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input RX_IN, PAR_EN, PAR_TYP, RX_CLK, RST, test_si, test_se;
  output data_Valid, test_so;
  wire   samp_en, sampled_bit, cnt_en, stp_err, strt_glitch, par_err,
         par_chk_en, strt_chk_en, stp_chk_en, deser_en, n1, n2, n3, n4, n5;
  wire   [2:0] edge_cnt;
  wire   [3:0] bit_cnt;
  assign test_so = strt_glitch;

  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
  data_sampling_test_1 D0 ( .RX_IN(RX_IN), .Prescale(Prescale), .enable(
        samp_en), .edge_count(edge_cnt), .CLK(RX_CLK), .RST(n1), .sampled_bit(
        sampled_bit), .test_si(test_si), .test_so(n5), .test_se(test_se) );
  edge_bit_counter_test_1 E_B_c ( .enable(cnt_en), .CLK(RX_CLK), .RST(n1), 
        .bit_cnt(bit_cnt), .edge_cnt(edge_cnt), .test_si(n4), .test_se(test_se) );
  RX_controller_test_1 RX0 ( .RX_IN(RX_IN), .PAR_EN(PAR_EN), .edge_cnt(
        edge_cnt), .bit_cnt(bit_cnt), .stp_err(stp_err), .strt_glitch(
        strt_glitch), .par_err(par_err), .CLK(RX_CLK), .RST(n1), .par_chk_en(
        par_chk_en), .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), 
        .deser_en(deser_en), .samp_en(samp_en), .cnt_en(cnt_en), .data_valid(
        data_Valid), .test_so(n3), .test_se(test_se) );
  stop_check_test_1 STP0 ( .sampled_bit(sampled_bit), .enable(stp_chk_en), 
        .CLK(RX_CLK), .RST(n1), .stp_err(stp_err), .test_si(n3), .test_se(
        test_se) );
  strt_check_test_1 STR0 ( .enable(strt_chk_en), .sampled_bit(sampled_bit), 
        .CLK(RX_CLK), .RST(n1), .strt_glitch(strt_glitch), .test_si(stp_err), 
        .test_se(test_se) );
  parity_check_test_1 Par0 ( .enable(par_chk_en), .sampled_bit(sampled_bit), 
        .PAR_TYP(PAR_TYP), .P_DATA(P_DATA), .CLK(RX_CLK), .RST(n1), .par_err(
        par_err), .test_si(edge_cnt[2]), .test_se(test_se) );
  deserializer_test_1 DSR0 ( .sampled_bit(sampled_bit), .edge_cnt(edge_cnt), 
        .enable(deser_en), .CLK(RX_CLK), .RST(n1), .P_DATA(P_DATA), .test_si(
        n5), .test_so(n4), .test_se(test_se) );
endmodule


module UART_test_1 ( RST, TX_CLK, RX_CLK, RX_IN_S, RX_OUT_P, RX_OUT_V, TX_IN_P, 
        TX_IN_V, TX_OUT_S, TX_OUT_V, Prescale, parity_enable, parity_type, 
        test_si, test_so, test_se );
  output [7:0] RX_OUT_P;
  input [7:0] TX_IN_P;
  input [5:0] Prescale;
  input RST, TX_CLK, RX_CLK, RX_IN_S, TX_IN_V, parity_enable, parity_type,
         test_si, test_se;
  output RX_OUT_V, TX_OUT_S, TX_OUT_V, test_so;
  wire   n1, n2, n4;

  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
  UART_TX_test_1 U0_UART_TX ( .P_DATA(TX_IN_P), .Data_Valid(TX_IN_V), .PAR_EN(
        parity_enable), .PAR_TYP(parity_type), .CLK(TX_CLK), .RST(n1), 
        .TX_OUT(TX_OUT_S), .busy(TX_OUT_V), .test_si(n4), .test_so(test_so), 
        .test_se(test_se) );
  UART_RX_test_1 U0_UART_RX ( .RX_IN(RX_IN_S), .PAR_EN(parity_enable), 
        .Prescale(Prescale), .PAR_TYP(parity_type), .RX_CLK(RX_CLK), .RST(n1), 
        .P_DATA(RX_OUT_P), .data_Valid(RX_OUT_V), .test_si(test_si), .test_so(
        n4), .test_se(test_se) );
endmodule


module BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_test_0 ( CLK, RST, ASYNC, SYNC, test_se
 );
  input [3:0] ASYNC;
  output [3:0] SYNC;
  input CLK, RST, test_se;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] ;

  SDFFRQX2M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .SI(\sync_reg[3][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[3]) );
  SDFFRQX2M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .SI(\sync_reg[2][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[2]) );
  SDFFRQX2M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .SI(\sync_reg[1][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[1]) );
  SDFFRQX2M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .SI(\sync_reg[0][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[0]) );
  SDFFRQX2M \sync_reg_reg[3][0]  ( .D(ASYNC[3]), .SI(SYNC[2]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[3][0] ) );
  SDFFRQX2M \sync_reg_reg[2][0]  ( .D(ASYNC[2]), .SI(SYNC[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[2][0] ) );
  SDFFRQX2M \sync_reg_reg[1][0]  ( .D(ASYNC[1]), .SI(SYNC[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[1][0] ) );
  SDFFRQX2M \sync_reg_reg[0][0]  ( .D(ASYNC[0]), .SI(ASYNC[3]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[0][0] ) );
endmodule


module BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_test_1 ( CLK, RST, ASYNC, SYNC, test_si, 
        test_se );
  input [3:0] ASYNC;
  output [3:0] SYNC;
  input CLK, RST, test_si, test_se;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] ;

  SDFFRQX2M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .SI(\sync_reg[2][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[2]) );
  SDFFRQX2M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .SI(\sync_reg[1][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[1]) );
  SDFFRQX2M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .SI(\sync_reg[0][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[0]) );
  SDFFRQX2M \sync_reg_reg[3][0]  ( .D(ASYNC[3]), .SI(SYNC[2]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[3][0] ) );
  SDFFRQX2M \sync_reg_reg[2][0]  ( .D(ASYNC[2]), .SI(SYNC[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[2][0] ) );
  SDFFRQX2M \sync_reg_reg[1][0]  ( .D(ASYNC[1]), .SI(SYNC[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[1][0] ) );
  SDFFRQX2M \sync_reg_reg[0][0]  ( .D(ASYNC[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(\sync_reg[0][0] ) );
  SDFFRQX1M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .SI(\sync_reg[3][0] ), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(SYNC[3]) );
endmodule


module FIFO_mem_Data_Width8_DEPTH8_POI_SIZE4_test_1 ( wclk, wrst_n, winc, 
        wfull, wdata, waddr, raddr, rdata, test_si, test_so, test_se );
  input [7:0] wdata;
  input [2:0] waddr;
  input [2:0] raddr;
  output [7:0] rdata;
  input wclk, wrst_n, winc, wfull, test_si, test_se;
  output test_so;
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
         \MEM[0][4] , \MEM[0][3] , \MEM[0][2] , \MEM[0][1] , \MEM[0][0] , n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n183, n184,
         n185, n186, n187;
  assign N9 = raddr[0];
  assign N10 = raddr[1];
  assign N11 = raddr[2];
  assign test_so = \MEM[7][7] ;

  SDFFRQX2M \MEM_reg[5][7]  ( .D(n133), .SI(\MEM[5][6] ), .SE(n187), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][7] ) );
  SDFFRQX2M \MEM_reg[5][6]  ( .D(n132), .SI(\MEM[5][5] ), .SE(n186), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][6] ) );
  SDFFRQX2M \MEM_reg[5][5]  ( .D(n131), .SI(\MEM[5][4] ), .SE(n185), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][5] ) );
  SDFFRQX2M \MEM_reg[5][4]  ( .D(n130), .SI(\MEM[5][3] ), .SE(n184), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][4] ) );
  SDFFRQX2M \MEM_reg[5][3]  ( .D(n129), .SI(\MEM[5][2] ), .SE(n187), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][3] ) );
  SDFFRQX2M \MEM_reg[5][2]  ( .D(n128), .SI(\MEM[5][1] ), .SE(n186), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][2] ) );
  SDFFRQX2M \MEM_reg[5][1]  ( .D(n127), .SI(\MEM[5][0] ), .SE(n185), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][1] ) );
  SDFFRQX2M \MEM_reg[5][0]  ( .D(n126), .SI(\MEM[4][7] ), .SE(n184), .CK(wclk), 
        .RN(n166), .Q(\MEM[5][0] ) );
  SDFFRQX2M \MEM_reg[1][7]  ( .D(n101), .SI(\MEM[1][6] ), .SE(n187), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][7] ) );
  SDFFRQX2M \MEM_reg[1][6]  ( .D(n100), .SI(\MEM[1][5] ), .SE(n186), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][6] ) );
  SDFFRQX2M \MEM_reg[1][5]  ( .D(n99), .SI(\MEM[1][4] ), .SE(n185), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][5] ) );
  SDFFRQX2M \MEM_reg[1][4]  ( .D(n98), .SI(\MEM[1][3] ), .SE(n184), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][4] ) );
  SDFFRQX2M \MEM_reg[1][3]  ( .D(n97), .SI(\MEM[1][2] ), .SE(n187), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][3] ) );
  SDFFRQX2M \MEM_reg[1][2]  ( .D(n96), .SI(\MEM[1][1] ), .SE(n186), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][2] ) );
  SDFFRQX2M \MEM_reg[1][1]  ( .D(n95), .SI(\MEM[1][0] ), .SE(n185), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][1] ) );
  SDFFRQX2M \MEM_reg[1][0]  ( .D(n94), .SI(\MEM[0][7] ), .SE(n184), .CK(wclk), 
        .RN(n169), .Q(\MEM[1][0] ) );
  SDFFRQX2M \MEM_reg[7][7]  ( .D(n149), .SI(\MEM[7][6] ), .SE(n187), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][7] ) );
  SDFFRQX2M \MEM_reg[7][6]  ( .D(n148), .SI(\MEM[7][5] ), .SE(n186), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][6] ) );
  SDFFRQX2M \MEM_reg[7][5]  ( .D(n147), .SI(\MEM[7][4] ), .SE(n185), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][5] ) );
  SDFFRQX2M \MEM_reg[7][4]  ( .D(n146), .SI(\MEM[7][3] ), .SE(n184), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][4] ) );
  SDFFRQX2M \MEM_reg[7][3]  ( .D(n145), .SI(\MEM[7][2] ), .SE(n187), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][3] ) );
  SDFFRQX2M \MEM_reg[7][2]  ( .D(n144), .SI(\MEM[7][1] ), .SE(n186), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][2] ) );
  SDFFRQX2M \MEM_reg[7][1]  ( .D(n143), .SI(\MEM[7][0] ), .SE(n185), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][1] ) );
  SDFFRQX2M \MEM_reg[7][0]  ( .D(n142), .SI(\MEM[6][7] ), .SE(n184), .CK(wclk), 
        .RN(n165), .Q(\MEM[7][0] ) );
  SDFFRQX2M \MEM_reg[3][7]  ( .D(n117), .SI(\MEM[3][6] ), .SE(n187), .CK(wclk), 
        .RN(n167), .Q(\MEM[3][7] ) );
  SDFFRQX2M \MEM_reg[3][6]  ( .D(n116), .SI(\MEM[3][5] ), .SE(n186), .CK(wclk), 
        .RN(n167), .Q(\MEM[3][6] ) );
  SDFFRQX2M \MEM_reg[3][5]  ( .D(n115), .SI(\MEM[3][4] ), .SE(n185), .CK(wclk), 
        .RN(n167), .Q(\MEM[3][5] ) );
  SDFFRQX2M \MEM_reg[3][4]  ( .D(n114), .SI(\MEM[3][3] ), .SE(n184), .CK(wclk), 
        .RN(n167), .Q(\MEM[3][4] ) );
  SDFFRQX2M \MEM_reg[3][3]  ( .D(n113), .SI(\MEM[3][2] ), .SE(n187), .CK(wclk), 
        .RN(n168), .Q(\MEM[3][3] ) );
  SDFFRQX2M \MEM_reg[3][2]  ( .D(n112), .SI(\MEM[3][1] ), .SE(n186), .CK(wclk), 
        .RN(n168), .Q(\MEM[3][2] ) );
  SDFFRQX2M \MEM_reg[3][1]  ( .D(n111), .SI(\MEM[3][0] ), .SE(n185), .CK(wclk), 
        .RN(n168), .Q(\MEM[3][1] ) );
  SDFFRQX2M \MEM_reg[3][0]  ( .D(n110), .SI(\MEM[2][7] ), .SE(n184), .CK(wclk), 
        .RN(n168), .Q(\MEM[3][0] ) );
  SDFFRQX2M \MEM_reg[6][7]  ( .D(n141), .SI(\MEM[6][6] ), .SE(n187), .CK(wclk), 
        .RN(n165), .Q(\MEM[6][7] ) );
  SDFFRQX2M \MEM_reg[6][6]  ( .D(n140), .SI(\MEM[6][5] ), .SE(n186), .CK(wclk), 
        .RN(n165), .Q(\MEM[6][6] ) );
  SDFFRQX2M \MEM_reg[6][5]  ( .D(n139), .SI(\MEM[6][4] ), .SE(n185), .CK(wclk), 
        .RN(n165), .Q(\MEM[6][5] ) );
  SDFFRQX2M \MEM_reg[6][4]  ( .D(n138), .SI(\MEM[6][3] ), .SE(n184), .CK(wclk), 
        .RN(n165), .Q(\MEM[6][4] ) );
  SDFFRQX2M \MEM_reg[6][3]  ( .D(n137), .SI(\MEM[6][2] ), .SE(n187), .CK(wclk), 
        .RN(n166), .Q(\MEM[6][3] ) );
  SDFFRQX2M \MEM_reg[6][2]  ( .D(n136), .SI(\MEM[6][1] ), .SE(n186), .CK(wclk), 
        .RN(n166), .Q(\MEM[6][2] ) );
  SDFFRQX2M \MEM_reg[6][1]  ( .D(n135), .SI(\MEM[6][0] ), .SE(n185), .CK(wclk), 
        .RN(n166), .Q(\MEM[6][1] ) );
  SDFFRQX2M \MEM_reg[6][0]  ( .D(n134), .SI(\MEM[5][7] ), .SE(n184), .CK(wclk), 
        .RN(n166), .Q(\MEM[6][0] ) );
  SDFFRQX2M \MEM_reg[2][7]  ( .D(n109), .SI(\MEM[2][6] ), .SE(n187), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][7] ) );
  SDFFRQX2M \MEM_reg[2][6]  ( .D(n108), .SI(\MEM[2][5] ), .SE(n186), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][6] ) );
  SDFFRQX2M \MEM_reg[2][5]  ( .D(n107), .SI(\MEM[2][4] ), .SE(n185), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][5] ) );
  SDFFRQX2M \MEM_reg[2][4]  ( .D(n106), .SI(\MEM[2][3] ), .SE(n184), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][4] ) );
  SDFFRQX2M \MEM_reg[2][3]  ( .D(n105), .SI(\MEM[2][2] ), .SE(n187), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][3] ) );
  SDFFRQX2M \MEM_reg[2][2]  ( .D(n104), .SI(\MEM[2][1] ), .SE(n186), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][2] ) );
  SDFFRQX2M \MEM_reg[2][1]  ( .D(n103), .SI(\MEM[2][0] ), .SE(n185), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][1] ) );
  SDFFRQX2M \MEM_reg[2][0]  ( .D(n102), .SI(\MEM[1][7] ), .SE(n184), .CK(wclk), 
        .RN(n168), .Q(\MEM[2][0] ) );
  SDFFRQX2M \MEM_reg[4][7]  ( .D(n125), .SI(\MEM[4][6] ), .SE(n187), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][7] ) );
  SDFFRQX2M \MEM_reg[4][6]  ( .D(n124), .SI(\MEM[4][5] ), .SE(n186), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][6] ) );
  SDFFRQX2M \MEM_reg[4][5]  ( .D(n123), .SI(\MEM[4][4] ), .SE(n185), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][5] ) );
  SDFFRQX2M \MEM_reg[4][4]  ( .D(n122), .SI(\MEM[4][3] ), .SE(n184), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][4] ) );
  SDFFRQX2M \MEM_reg[4][3]  ( .D(n121), .SI(\MEM[4][2] ), .SE(n187), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][3] ) );
  SDFFRQX2M \MEM_reg[4][2]  ( .D(n120), .SI(\MEM[4][1] ), .SE(n186), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][2] ) );
  SDFFRQX2M \MEM_reg[4][1]  ( .D(n119), .SI(\MEM[4][0] ), .SE(n185), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][1] ) );
  SDFFRQX2M \MEM_reg[4][0]  ( .D(n118), .SI(\MEM[3][7] ), .SE(n184), .CK(wclk), 
        .RN(n167), .Q(\MEM[4][0] ) );
  SDFFRQX2M \MEM_reg[0][7]  ( .D(n93), .SI(\MEM[0][6] ), .SE(n187), .CK(wclk), 
        .RN(n169), .Q(\MEM[0][7] ) );
  SDFFRQX2M \MEM_reg[0][6]  ( .D(n92), .SI(\MEM[0][5] ), .SE(n186), .CK(wclk), 
        .RN(n169), .Q(\MEM[0][6] ) );
  SDFFRQX2M \MEM_reg[0][5]  ( .D(n91), .SI(\MEM[0][4] ), .SE(n185), .CK(wclk), 
        .RN(n169), .Q(\MEM[0][5] ) );
  SDFFRQX2M \MEM_reg[0][4]  ( .D(n90), .SI(\MEM[0][3] ), .SE(n184), .CK(wclk), 
        .RN(n169), .Q(\MEM[0][4] ) );
  SDFFRQX2M \MEM_reg[0][3]  ( .D(n89), .SI(\MEM[0][2] ), .SE(n187), .CK(wclk), 
        .RN(n170), .Q(\MEM[0][3] ) );
  SDFFRQX2M \MEM_reg[0][2]  ( .D(n88), .SI(\MEM[0][1] ), .SE(n186), .CK(wclk), 
        .RN(n170), .Q(\MEM[0][2] ) );
  SDFFRQX2M \MEM_reg[0][1]  ( .D(n87), .SI(\MEM[0][0] ), .SE(n185), .CK(wclk), 
        .RN(n170), .Q(\MEM[0][1] ) );
  SDFFRQX2M \MEM_reg[0][0]  ( .D(n86), .SI(test_si), .SE(n184), .CK(wclk), 
        .RN(n170), .Q(\MEM[0][0] ) );
  BUFX2M U66 ( .A(n83), .Y(n160) );
  BUFX2M U67 ( .A(n77), .Y(n162) );
  BUFX2M U68 ( .A(n78), .Y(n161) );
  BUFX2M U69 ( .A(n164), .Y(n169) );
  BUFX2M U70 ( .A(n164), .Y(n168) );
  BUFX2M U71 ( .A(n163), .Y(n167) );
  BUFX2M U72 ( .A(n163), .Y(n166) );
  BUFX2M U73 ( .A(n163), .Y(n165) );
  BUFX2M U74 ( .A(n164), .Y(n170) );
  BUFX2M U75 ( .A(wrst_n), .Y(n164) );
  BUFX2M U76 ( .A(wrst_n), .Y(n163) );
  NAND3X2M U77 ( .A(n179), .B(n180), .C(n82), .Y(n81) );
  NAND3X2M U78 ( .A(n179), .B(n180), .C(n76), .Y(n75) );
  NOR2BX2M U79 ( .AN(winc), .B(wfull), .Y(n80) );
  NAND3X2M U80 ( .A(waddr[0]), .B(n76), .C(waddr[1]), .Y(n79) );
  NOR2BX2M U81 ( .AN(n80), .B(waddr[2]), .Y(n76) );
  OAI2BB2X1M U82 ( .B0(n75), .B1(n178), .A0N(\MEM[0][0] ), .A1N(n75), .Y(n86)
         );
  OAI2BB2X1M U83 ( .B0(n75), .B1(n177), .A0N(\MEM[0][1] ), .A1N(n75), .Y(n87)
         );
  OAI2BB2X1M U84 ( .B0(n75), .B1(n176), .A0N(\MEM[0][2] ), .A1N(n75), .Y(n88)
         );
  OAI2BB2X1M U85 ( .B0(n75), .B1(n175), .A0N(\MEM[0][3] ), .A1N(n75), .Y(n89)
         );
  OAI2BB2X1M U86 ( .B0(n75), .B1(n174), .A0N(\MEM[0][4] ), .A1N(n75), .Y(n90)
         );
  OAI2BB2X1M U87 ( .B0(n75), .B1(n173), .A0N(\MEM[0][5] ), .A1N(n75), .Y(n91)
         );
  OAI2BB2X1M U88 ( .B0(n75), .B1(n172), .A0N(\MEM[0][6] ), .A1N(n75), .Y(n92)
         );
  OAI2BB2X1M U89 ( .B0(n75), .B1(n171), .A0N(\MEM[0][7] ), .A1N(n75), .Y(n93)
         );
  OAI2BB2X1M U90 ( .B0(n178), .B1(n79), .A0N(\MEM[3][0] ), .A1N(n79), .Y(n110)
         );
  OAI2BB2X1M U91 ( .B0(n177), .B1(n79), .A0N(\MEM[3][1] ), .A1N(n79), .Y(n111)
         );
  OAI2BB2X1M U92 ( .B0(n176), .B1(n79), .A0N(\MEM[3][2] ), .A1N(n79), .Y(n112)
         );
  OAI2BB2X1M U93 ( .B0(n175), .B1(n79), .A0N(\MEM[3][3] ), .A1N(n79), .Y(n113)
         );
  OAI2BB2X1M U94 ( .B0(n174), .B1(n79), .A0N(\MEM[3][4] ), .A1N(n79), .Y(n114)
         );
  OAI2BB2X1M U95 ( .B0(n173), .B1(n79), .A0N(\MEM[3][5] ), .A1N(n79), .Y(n115)
         );
  OAI2BB2X1M U96 ( .B0(n172), .B1(n79), .A0N(\MEM[3][6] ), .A1N(n79), .Y(n116)
         );
  OAI2BB2X1M U97 ( .B0(n171), .B1(n79), .A0N(\MEM[3][7] ), .A1N(n79), .Y(n117)
         );
  OAI2BB2X1M U98 ( .B0(n178), .B1(n81), .A0N(\MEM[4][0] ), .A1N(n81), .Y(n118)
         );
  OAI2BB2X1M U99 ( .B0(n177), .B1(n81), .A0N(\MEM[4][1] ), .A1N(n81), .Y(n119)
         );
  OAI2BB2X1M U100 ( .B0(n176), .B1(n81), .A0N(\MEM[4][2] ), .A1N(n81), .Y(n120) );
  OAI2BB2X1M U101 ( .B0(n175), .B1(n81), .A0N(\MEM[4][3] ), .A1N(n81), .Y(n121) );
  OAI2BB2X1M U102 ( .B0(n174), .B1(n81), .A0N(\MEM[4][4] ), .A1N(n81), .Y(n122) );
  OAI2BB2X1M U103 ( .B0(n173), .B1(n81), .A0N(\MEM[4][5] ), .A1N(n81), .Y(n123) );
  OAI2BB2X1M U104 ( .B0(n172), .B1(n81), .A0N(\MEM[4][6] ), .A1N(n81), .Y(n124) );
  OAI2BB2X1M U105 ( .B0(n171), .B1(n81), .A0N(\MEM[4][7] ), .A1N(n81), .Y(n125) );
  INVX2M U106 ( .A(wdata[0]), .Y(n178) );
  INVX2M U107 ( .A(wdata[1]), .Y(n177) );
  INVX2M U108 ( .A(wdata[2]), .Y(n176) );
  INVX2M U109 ( .A(wdata[3]), .Y(n175) );
  INVX2M U110 ( .A(wdata[4]), .Y(n174) );
  INVX2M U111 ( .A(wdata[5]), .Y(n173) );
  INVX2M U112 ( .A(wdata[6]), .Y(n172) );
  INVX2M U113 ( .A(wdata[7]), .Y(n171) );
  BUFX2M U114 ( .A(n84), .Y(n159) );
  NAND3X2M U115 ( .A(waddr[1]), .B(n179), .C(n82), .Y(n84) );
  BUFX2M U116 ( .A(n85), .Y(n158) );
  NAND3X2M U117 ( .A(waddr[1]), .B(waddr[0]), .C(n82), .Y(n85) );
  OAI2BB2X1M U118 ( .B0(n178), .B1(n162), .A0N(\MEM[1][0] ), .A1N(n162), .Y(
        n94) );
  OAI2BB2X1M U119 ( .B0(n177), .B1(n162), .A0N(\MEM[1][1] ), .A1N(n162), .Y(
        n95) );
  OAI2BB2X1M U120 ( .B0(n176), .B1(n162), .A0N(\MEM[1][2] ), .A1N(n162), .Y(
        n96) );
  OAI2BB2X1M U121 ( .B0(n175), .B1(n162), .A0N(\MEM[1][3] ), .A1N(n162), .Y(
        n97) );
  OAI2BB2X1M U122 ( .B0(n174), .B1(n162), .A0N(\MEM[1][4] ), .A1N(n162), .Y(
        n98) );
  OAI2BB2X1M U123 ( .B0(n173), .B1(n162), .A0N(\MEM[1][5] ), .A1N(n162), .Y(
        n99) );
  OAI2BB2X1M U124 ( .B0(n172), .B1(n162), .A0N(\MEM[1][6] ), .A1N(n162), .Y(
        n100) );
  OAI2BB2X1M U125 ( .B0(n171), .B1(n162), .A0N(\MEM[1][7] ), .A1N(n162), .Y(
        n101) );
  OAI2BB2X1M U126 ( .B0(n178), .B1(n161), .A0N(\MEM[2][0] ), .A1N(n161), .Y(
        n102) );
  OAI2BB2X1M U127 ( .B0(n177), .B1(n161), .A0N(\MEM[2][1] ), .A1N(n161), .Y(
        n103) );
  OAI2BB2X1M U128 ( .B0(n176), .B1(n161), .A0N(\MEM[2][2] ), .A1N(n161), .Y(
        n104) );
  OAI2BB2X1M U129 ( .B0(n175), .B1(n161), .A0N(\MEM[2][3] ), .A1N(n161), .Y(
        n105) );
  OAI2BB2X1M U130 ( .B0(n174), .B1(n161), .A0N(\MEM[2][4] ), .A1N(n161), .Y(
        n106) );
  OAI2BB2X1M U131 ( .B0(n173), .B1(n161), .A0N(\MEM[2][5] ), .A1N(n161), .Y(
        n107) );
  OAI2BB2X1M U132 ( .B0(n172), .B1(n161), .A0N(\MEM[2][6] ), .A1N(n161), .Y(
        n108) );
  OAI2BB2X1M U133 ( .B0(n171), .B1(n161), .A0N(\MEM[2][7] ), .A1N(n161), .Y(
        n109) );
  OAI2BB2X1M U134 ( .B0(n178), .B1(n160), .A0N(\MEM[5][0] ), .A1N(n160), .Y(
        n126) );
  OAI2BB2X1M U135 ( .B0(n177), .B1(n160), .A0N(\MEM[5][1] ), .A1N(n160), .Y(
        n127) );
  OAI2BB2X1M U136 ( .B0(n176), .B1(n160), .A0N(\MEM[5][2] ), .A1N(n160), .Y(
        n128) );
  OAI2BB2X1M U137 ( .B0(n175), .B1(n160), .A0N(\MEM[5][3] ), .A1N(n160), .Y(
        n129) );
  OAI2BB2X1M U138 ( .B0(n174), .B1(n160), .A0N(\MEM[5][4] ), .A1N(n160), .Y(
        n130) );
  OAI2BB2X1M U139 ( .B0(n173), .B1(n160), .A0N(\MEM[5][5] ), .A1N(n160), .Y(
        n131) );
  OAI2BB2X1M U140 ( .B0(n172), .B1(n160), .A0N(\MEM[5][6] ), .A1N(n160), .Y(
        n132) );
  OAI2BB2X1M U141 ( .B0(n171), .B1(n160), .A0N(\MEM[5][7] ), .A1N(n160), .Y(
        n133) );
  OAI2BB2X1M U142 ( .B0(n178), .B1(n159), .A0N(\MEM[6][0] ), .A1N(n159), .Y(
        n134) );
  OAI2BB2X1M U143 ( .B0(n177), .B1(n159), .A0N(\MEM[6][1] ), .A1N(n159), .Y(
        n135) );
  OAI2BB2X1M U144 ( .B0(n176), .B1(n159), .A0N(\MEM[6][2] ), .A1N(n159), .Y(
        n136) );
  OAI2BB2X1M U145 ( .B0(n175), .B1(n159), .A0N(\MEM[6][3] ), .A1N(n159), .Y(
        n137) );
  OAI2BB2X1M U146 ( .B0(n174), .B1(n159), .A0N(\MEM[6][4] ), .A1N(n159), .Y(
        n138) );
  OAI2BB2X1M U147 ( .B0(n173), .B1(n159), .A0N(\MEM[6][5] ), .A1N(n159), .Y(
        n139) );
  OAI2BB2X1M U148 ( .B0(n172), .B1(n159), .A0N(\MEM[6][6] ), .A1N(n159), .Y(
        n140) );
  OAI2BB2X1M U149 ( .B0(n171), .B1(n159), .A0N(\MEM[6][7] ), .A1N(n159), .Y(
        n141) );
  OAI2BB2X1M U150 ( .B0(n178), .B1(n158), .A0N(\MEM[7][0] ), .A1N(n158), .Y(
        n142) );
  OAI2BB2X1M U151 ( .B0(n177), .B1(n158), .A0N(\MEM[7][1] ), .A1N(n158), .Y(
        n143) );
  OAI2BB2X1M U152 ( .B0(n176), .B1(n158), .A0N(\MEM[7][2] ), .A1N(n158), .Y(
        n144) );
  OAI2BB2X1M U153 ( .B0(n175), .B1(n158), .A0N(\MEM[7][3] ), .A1N(n158), .Y(
        n145) );
  OAI2BB2X1M U154 ( .B0(n174), .B1(n158), .A0N(\MEM[7][4] ), .A1N(n158), .Y(
        n146) );
  OAI2BB2X1M U155 ( .B0(n173), .B1(n158), .A0N(\MEM[7][5] ), .A1N(n158), .Y(
        n147) );
  OAI2BB2X1M U156 ( .B0(n172), .B1(n158), .A0N(\MEM[7][6] ), .A1N(n158), .Y(
        n148) );
  OAI2BB2X1M U157 ( .B0(n171), .B1(n158), .A0N(\MEM[7][7] ), .A1N(n158), .Y(
        n149) );
  NAND3X2M U158 ( .A(waddr[0]), .B(n180), .C(n82), .Y(n83) );
  AND2X2M U159 ( .A(waddr[2]), .B(n80), .Y(n82) );
  NAND3X2M U160 ( .A(n76), .B(n179), .C(waddr[1]), .Y(n78) );
  NAND3X2M U161 ( .A(n76), .B(n180), .C(waddr[0]), .Y(n77) );
  INVX2M U162 ( .A(waddr[1]), .Y(n180) );
  INVX2M U163 ( .A(waddr[0]), .Y(n179) );
  MX2X2M U164 ( .A(n153), .B(n152), .S0(N11), .Y(rdata[6]) );
  MX4X1M U165 ( .A(\MEM[0][6] ), .B(\MEM[1][6] ), .C(\MEM[2][6] ), .D(
        \MEM[3][6] ), .S0(n157), .S1(N10), .Y(n153) );
  MX4X1M U166 ( .A(\MEM[4][6] ), .B(\MEM[5][6] ), .C(\MEM[6][6] ), .D(
        \MEM[7][6] ), .S0(n156), .S1(N10), .Y(n152) );
  MX2X2M U167 ( .A(n155), .B(n154), .S0(N11), .Y(rdata[7]) );
  MX4X1M U168 ( .A(\MEM[0][7] ), .B(\MEM[1][7] ), .C(\MEM[2][7] ), .D(
        \MEM[3][7] ), .S0(n157), .S1(N10), .Y(n155) );
  MX4X1M U169 ( .A(\MEM[4][7] ), .B(\MEM[5][7] ), .C(\MEM[6][7] ), .D(
        \MEM[7][7] ), .S0(n156), .S1(N10), .Y(n154) );
  MX2X2M U170 ( .A(n72), .B(n71), .S0(N11), .Y(rdata[3]) );
  MX4X1M U171 ( .A(\MEM[0][3] ), .B(\MEM[1][3] ), .C(\MEM[2][3] ), .D(
        \MEM[3][3] ), .S0(n157), .S1(N10), .Y(n72) );
  MX4X1M U172 ( .A(\MEM[4][3] ), .B(\MEM[5][3] ), .C(\MEM[6][3] ), .D(
        \MEM[7][3] ), .S0(n156), .S1(N10), .Y(n71) );
  MX2X2M U173 ( .A(n74), .B(n73), .S0(N11), .Y(rdata[4]) );
  MX4X1M U174 ( .A(\MEM[0][4] ), .B(\MEM[1][4] ), .C(\MEM[2][4] ), .D(
        \MEM[3][4] ), .S0(n157), .S1(N10), .Y(n74) );
  MX4X1M U175 ( .A(\MEM[4][4] ), .B(\MEM[5][4] ), .C(\MEM[6][4] ), .D(
        \MEM[7][4] ), .S0(n156), .S1(N10), .Y(n73) );
  MX2X2M U176 ( .A(n66), .B(n65), .S0(N11), .Y(rdata[0]) );
  MX4X1M U177 ( .A(\MEM[0][0] ), .B(\MEM[1][0] ), .C(\MEM[2][0] ), .D(
        \MEM[3][0] ), .S0(n157), .S1(N10), .Y(n66) );
  MX4X1M U178 ( .A(\MEM[4][0] ), .B(\MEM[5][0] ), .C(\MEM[6][0] ), .D(
        \MEM[7][0] ), .S0(n156), .S1(N10), .Y(n65) );
  MX2X2M U179 ( .A(n151), .B(n150), .S0(N11), .Y(rdata[5]) );
  MX4X1M U180 ( .A(\MEM[0][5] ), .B(\MEM[1][5] ), .C(\MEM[2][5] ), .D(
        \MEM[3][5] ), .S0(n157), .S1(N10), .Y(n151) );
  MX4X1M U181 ( .A(\MEM[4][5] ), .B(\MEM[5][5] ), .C(\MEM[6][5] ), .D(
        \MEM[7][5] ), .S0(n156), .S1(N10), .Y(n150) );
  MX2X2M U182 ( .A(n68), .B(n67), .S0(N11), .Y(rdata[1]) );
  MX4X1M U183 ( .A(\MEM[0][1] ), .B(\MEM[1][1] ), .C(\MEM[2][1] ), .D(
        \MEM[3][1] ), .S0(n157), .S1(N10), .Y(n68) );
  MX4X1M U184 ( .A(\MEM[4][1] ), .B(\MEM[5][1] ), .C(\MEM[6][1] ), .D(
        \MEM[7][1] ), .S0(n156), .S1(N10), .Y(n67) );
  MX2X2M U185 ( .A(n70), .B(n69), .S0(N11), .Y(rdata[2]) );
  MX4X1M U186 ( .A(\MEM[0][2] ), .B(\MEM[1][2] ), .C(\MEM[2][2] ), .D(
        \MEM[3][2] ), .S0(n157), .S1(N10), .Y(n70) );
  MX4X1M U187 ( .A(\MEM[4][2] ), .B(\MEM[5][2] ), .C(\MEM[6][2] ), .D(
        \MEM[7][2] ), .S0(n156), .S1(N10), .Y(n69) );
  BUFX2M U188 ( .A(N9), .Y(n156) );
  BUFX2M U189 ( .A(N9), .Y(n157) );
  INVXLM U190 ( .A(test_se), .Y(n183) );
  INVXLM U191 ( .A(n183), .Y(n184) );
  INVXLM U192 ( .A(n183), .Y(n185) );
  INVXLM U193 ( .A(n183), .Y(n186) );
  INVXLM U194 ( .A(n183), .Y(n187) );
endmodule


module r_empty_P_SIZE4_test_1 ( rinc, rclk, rrst_n, rq2_wptr, rempty, raddr, 
        g_rptr, test_si, test_se );
  input [3:0] rq2_wptr;
  output [2:0] raddr;
  output [3:0] g_rptr;
  input rinc, rclk, rrst_n, test_si, test_se;
  output rempty;
  wire   \bn_rptr[3] , n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n1, n2, n11, n12;

  SDFFRQX2M \g_rptr_reg[0]  ( .D(n41), .SI(n12), .SE(test_se), .CK(rclk), .RN(
        rrst_n), .Q(g_rptr[0]) );
  SDFFRQX2M \g_rptr_reg[3]  ( .D(n34), .SI(g_rptr[2]), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(g_rptr[3]) );
  SDFFRQX2M \g_rptr_reg[2]  ( .D(n35), .SI(g_rptr[1]), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(g_rptr[2]) );
  SDFFRQX2M \g_rptr_reg[1]  ( .D(n36), .SI(g_rptr[0]), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(g_rptr[1]) );
  SDFFRQX2M \bn_rptr_reg[3]  ( .D(n37), .SI(n11), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(\bn_rptr[3] ) );
  SDFFRQX2M \bn_rptr_reg[0]  ( .D(n40), .SI(test_si), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(raddr[0]) );
  SDFFRQX2M \bn_rptr_reg[2]  ( .D(n38), .SI(n2), .SE(test_se), .CK(rclk), .RN(
        rrst_n), .Q(raddr[2]) );
  SDFFRQX2M \bn_rptr_reg[1]  ( .D(n39), .SI(raddr[0]), .SE(test_se), .CK(rclk), 
        .RN(rrst_n), .Q(raddr[1]) );
  NOR3BX2M U11 ( .AN(n18), .B(n2), .C(n17), .Y(n16) );
  OAI2BB2X1M U12 ( .B0(n2), .B1(n19), .A0N(n12), .A1N(n24), .Y(n21) );
  XNOR2X2M U13 ( .A(n2), .B(n27), .Y(n39) );
  INVX2M U14 ( .A(n15), .Y(rempty) );
  XNOR2X2M U15 ( .A(g_rptr[2]), .B(rq2_wptr[2]), .Y(n32) );
  OAI211X2M U16 ( .A0(raddr[0]), .A1(n12), .B0(n22), .C0(n19), .Y(n17) );
  XNOR2X2M U17 ( .A(raddr[2]), .B(n26), .Y(n38) );
  NOR2BX2M U18 ( .AN(raddr[0]), .B(n28), .Y(n27) );
  XNOR2X2M U19 ( .A(raddr[0]), .B(n28), .Y(n40) );
  NAND4X2M U20 ( .A(n29), .B(n30), .C(n31), .D(n32), .Y(n15) );
  XNOR2X2M U21 ( .A(g_rptr[1]), .B(rq2_wptr[1]), .Y(n29) );
  XNOR2X2M U22 ( .A(g_rptr[0]), .B(rq2_wptr[0]), .Y(n30) );
  XNOR2X2M U23 ( .A(g_rptr[3]), .B(rq2_wptr[3]), .Y(n31) );
  OAI211X2M U24 ( .A0(n1), .A1(n12), .B0(n25), .C0(n19), .Y(n37) );
  NAND3X2M U25 ( .A(raddr[2]), .B(n12), .C(n1), .Y(n25) );
  INVX2M U26 ( .A(n26), .Y(n1) );
  OAI211X2M U27 ( .A0(n11), .A1(n18), .B0(n19), .C0(n20), .Y(n35) );
  AOI21X2M U28 ( .A0(n16), .A1(g_rptr[2]), .B0(n21), .Y(n20) );
  OAI211X2M U29 ( .A0(raddr[2]), .A1(n18), .B0(n22), .C0(n23), .Y(n36) );
  AOI21X2M U30 ( .A0(n16), .A1(g_rptr[1]), .B0(n21), .Y(n23) );
  NOR2X2M U31 ( .A(n11), .B(raddr[1]), .Y(n24) );
  NAND2X2M U32 ( .A(raddr[1]), .B(n12), .Y(n18) );
  NAND2X2M U33 ( .A(n27), .B(raddr[1]), .Y(n26) );
  NAND2X2M U34 ( .A(\bn_rptr[3] ), .B(n11), .Y(n19) );
  INVX2M U35 ( .A(raddr[1]), .Y(n2) );
  INVX2M U36 ( .A(raddr[2]), .Y(n11) );
  INVX2M U37 ( .A(\bn_rptr[3] ), .Y(n12) );
  NAND2X2M U38 ( .A(rinc), .B(n15), .Y(n28) );
  NAND2X2M U39 ( .A(n24), .B(\bn_rptr[3] ), .Y(n22) );
  OAI2BB1X2M U40 ( .A0N(g_rptr[0]), .A1N(n16), .B0(n33), .Y(n41) );
  XNOR2X2M U41 ( .A(raddr[0]), .B(raddr[1]), .Y(n33) );
  AO21XLM U42 ( .A0(g_rptr[3]), .A1(n16), .B0(n17), .Y(n34) );
endmodule


module w_full_POI_SIZE4_test_1 ( winc, wclk, wrst_n, wq2_rptr, wfull, waddr, 
        g_wptr, test_si, test_se );
  input [3:0] wq2_rptr;
  output [2:0] waddr;
  output [3:0] g_wptr;
  input winc, wclk, wrst_n, test_si, test_se;
  output wfull;
  wire   \bn_wptr[3] , n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n1, n2, n11, n12, n13, n14, n15;

  SDFFRQX2M \g_wptr_reg[3]  ( .D(n39), .SI(g_wptr[2]), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(g_wptr[3]) );
  SDFFRQX2M \g_wptr_reg[0]  ( .D(n1), .SI(n15), .SE(test_se), .CK(wclk), .RN(
        wrst_n), .Q(g_wptr[0]) );
  SDFFRQX2M \g_wptr_reg[1]  ( .D(n12), .SI(g_wptr[0]), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(g_wptr[1]) );
  SDFFRQX2M \g_wptr_reg[2]  ( .D(n40), .SI(g_wptr[1]), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(g_wptr[2]) );
  SDFFRQX2M \bn_wptr_reg[3]  ( .D(n41), .SI(waddr[2]), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(\bn_wptr[3] ) );
  SDFFRQX2M \bn_wptr_reg[2]  ( .D(n42), .SI(n13), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(waddr[2]) );
  SDFFRQX2M \bn_wptr_reg[0]  ( .D(n44), .SI(test_si), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(waddr[0]) );
  SDFFRQX2M \bn_wptr_reg[1]  ( .D(n43), .SI(n11), .SE(test_se), .CK(wclk), 
        .RN(wrst_n), .Q(waddr[1]) );
  OAI2B11X2M U11 ( .A1N(n38), .A0(n15), .B0(n27), .C0(n22), .Y(n20) );
  NOR3X2M U12 ( .A(n13), .B(n24), .C(n20), .Y(n19) );
  XNOR2X2M U13 ( .A(n13), .B(n31), .Y(n43) );
  NAND2X2M U14 ( .A(winc), .B(n18), .Y(n32) );
  INVX2M U15 ( .A(n18), .Y(wfull) );
  NAND2X2M U16 ( .A(n28), .B(n15), .Y(n21) );
  XNOR2X2M U17 ( .A(g_wptr[3]), .B(n15), .Y(n35) );
  NOR2X2M U18 ( .A(n14), .B(waddr[1]), .Y(n28) );
  XNOR2X2M U19 ( .A(waddr[0]), .B(n32), .Y(n44) );
  XNOR2X2M U20 ( .A(waddr[2]), .B(n30), .Y(n42) );
  INVX2M U21 ( .A(waddr[1]), .Y(n13) );
  NOR2X2M U22 ( .A(n32), .B(n11), .Y(n31) );
  INVX2M U23 ( .A(waddr[0]), .Y(n11) );
  NAND4X2M U24 ( .A(n33), .B(n34), .C(n35), .D(n36), .Y(n18) );
  XNOR2X2M U25 ( .A(n14), .B(g_wptr[2]), .Y(n36) );
  XNOR2X2M U26 ( .A(g_wptr[0]), .B(waddr[0]), .Y(n33) );
  XNOR2X2M U27 ( .A(g_wptr[1]), .B(waddr[1]), .Y(n34) );
  OAI211X2M U28 ( .A0(n2), .A1(n15), .B0(n29), .C0(n22), .Y(n41) );
  NAND3X2M U29 ( .A(waddr[2]), .B(n15), .C(n2), .Y(n29) );
  INVX2M U30 ( .A(n30), .Y(n2) );
  NAND2X2M U31 ( .A(n31), .B(waddr[1]), .Y(n30) );
  INVX2M U32 ( .A(\bn_wptr[3] ), .Y(n15) );
  NOR2X2M U33 ( .A(n13), .B(waddr[0]), .Y(n38) );
  INVX2M U34 ( .A(waddr[2]), .Y(n14) );
  NAND2X2M U35 ( .A(n28), .B(\bn_wptr[3] ), .Y(n27) );
  INVX2M U36 ( .A(n37), .Y(n1) );
  AOI221XLM U37 ( .A0(n13), .A1(waddr[0]), .B0(g_wptr[0]), .B1(n19), .C0(n38), 
        .Y(n37) );
  INVX2M U38 ( .A(n25), .Y(n12) );
  AOI221XLM U39 ( .A0(n14), .A1(n24), .B0(g_wptr[1]), .B1(n19), .C0(n26), .Y(
        n25) );
  OAI211X2M U40 ( .A0(n22), .A1(n13), .B0(n21), .C0(n27), .Y(n26) );
  NAND3X2M U41 ( .A(n21), .B(n22), .C(n23), .Y(n40) );
  AOI22X1M U42 ( .A0(n24), .A1(waddr[2]), .B0(n19), .B1(g_wptr[2]), .Y(n23) );
  AO21XLM U43 ( .A0(g_wptr[3]), .A1(n19), .B0(n20), .Y(n39) );
  NOR2X2M U44 ( .A(n13), .B(\bn_wptr[3] ), .Y(n24) );
  NAND2X2M U45 ( .A(\bn_wptr[3] ), .B(n14), .Y(n22) );
endmodule


module Asynch_FIFO_test_1 ( winc, wclk, wrst_n, rinc, rclk, rrst_n, wdata, 
        rdata, wfull, rempty, test_si2, test_si1, test_so2, test_so1, test_se
 );
  input [7:0] wdata;
  output [7:0] rdata;
  input winc, wclk, wrst_n, rinc, rclk, rrst_n, test_si2, test_si1, test_se;
  output wfull, rempty, test_so2, test_so1;
  wire   n1, n2, n3;
  wire   [3:0] g_rptr;
  wire   [3:0] wq2_rptr;
  wire   [3:0] g_wptr;
  wire   [3:0] rq2_wptr;
  wire   [2:0] waddr;
  wire   [2:0] raddr;
  assign test_so1 = wq2_rptr[3];
  assign test_so2 = g_wptr[3];

  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(wrst_n), .Y(n2) );
  BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_test_0 u_r2w_sync ( .CLK(wclk), .RST(n1), 
        .ASYNC(g_rptr), .SYNC(wq2_rptr), .test_se(test_se) );
  BIT_SYNC_NUM_STAGES2_BUS_WIDTH4_test_1 u_w2r_sync ( .CLK(rclk), .RST(rrst_n), 
        .ASYNC(g_wptr), .SYNC(rq2_wptr), .test_si(test_si2), .test_se(test_se)
         );
  FIFO_mem_Data_Width8_DEPTH8_POI_SIZE4_test_1 fifomem ( .wclk(wclk), .wrst_n(
        n1), .winc(winc), .wfull(wfull), .wdata(wdata), .waddr(waddr), .raddr(
        raddr), .rdata(rdata), .test_si(test_si1), .test_so(n3), .test_se(
        test_se) );
  r_empty_P_SIZE4_test_1 rptr_empty ( .rinc(rinc), .rclk(rclk), .rrst_n(rrst_n), .rq2_wptr(rq2_wptr), .rempty(rempty), .raddr(raddr), .g_rptr(g_rptr), 
        .test_si(n3), .test_se(test_se) );
  w_full_POI_SIZE4_test_1 wptr_full ( .winc(winc), .wclk(wclk), .wrst_n(n1), 
        .wq2_rptr(wq2_rptr), .wfull(wfull), .waddr(waddr), .g_wptr(g_wptr), 
        .test_si(rq2_wptr[3]), .test_se(test_se) );
endmodule


module SYS_CTRL_test_1 ( RX_P_DATA, RX_D_VLD, FIFO_FULL, ALU_OUT, OUT_Valid, 
        Rd_D_Vld, Rd_D, CLK, RST, WR_DATA, WR_INC, ALU_EN, ALU_FUN, Wr_D, Addr, 
        RdEn, CLK_EN, CLK_DIV_EN, WrEn, test_si, test_so, test_se );
  input [7:0] RX_P_DATA;
  input [15:0] ALU_OUT;
  input [7:0] Rd_D;
  output [7:0] WR_DATA;
  output [3:0] ALU_FUN;
  output [7:0] Wr_D;
  output [3:0] Addr;
  input RX_D_VLD, FIFO_FULL, OUT_Valid, Rd_D_Vld, CLK, RST, test_si, test_se;
  output WR_INC, ALU_EN, RdEn, CLK_EN, CLK_DIV_EN, WrEn, test_so;
  wire   n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n64,
         n65, n66;
  wire   [3:0] current_state;
  wire   [3:0] next_state;
  assign test_so = n16;

  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(current_state[0]) );
  SDFFRQX2M \current_state_reg[3]  ( .D(next_state[3]), .SI(n18), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[3]) );
  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(n11), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(current_state[1]) );
  NOR2X2M U11 ( .A(n40), .B(n64), .Y(Addr[1]) );
  NOR2X2M U12 ( .A(n22), .B(n12), .Y(ALU_FUN[2]) );
  INVX2M U13 ( .A(ALU_EN), .Y(n12) );
  NAND2X2M U14 ( .A(n51), .B(n39), .Y(WrEn) );
  NOR2X2M U15 ( .A(n66), .B(n42), .Y(ALU_EN) );
  OA21X2M U16 ( .A0(n24), .A1(n66), .B0(n27), .Y(n51) );
  NOR2X2M U17 ( .A(n21), .B(n12), .Y(ALU_FUN[3]) );
  NOR2X2M U18 ( .A(n65), .B(n12), .Y(ALU_FUN[0]) );
  NOR2X2M U19 ( .A(n65), .B(n40), .Y(Addr[0]) );
  NOR2X2M U20 ( .A(n64), .B(n12), .Y(ALU_FUN[1]) );
  NOR2BX2M U21 ( .AN(n33), .B(n30), .Y(n24) );
  NOR2X2M U22 ( .A(n22), .B(n40), .Y(Addr[2]) );
  NOR2X2M U23 ( .A(n51), .B(n19), .Y(Wr_D[5]) );
  NOR2X2M U24 ( .A(n51), .B(n64), .Y(Wr_D[1]) );
  NOR2X2M U25 ( .A(n51), .B(n22), .Y(Wr_D[2]) );
  NOR2X2M U26 ( .A(n51), .B(n21), .Y(Wr_D[3]) );
  NOR2X2M U27 ( .A(n51), .B(n20), .Y(Wr_D[4]) );
  NOR2X2M U28 ( .A(n51), .B(n65), .Y(Wr_D[0]) );
  NAND2X2M U29 ( .A(n32), .B(n16), .Y(n39) );
  INVX2M U30 ( .A(n54), .Y(n9) );
  NOR2X2M U31 ( .A(n21), .B(n40), .Y(Addr[3]) );
  NAND2X2M U32 ( .A(n49), .B(n52), .Y(n27) );
  INVX2M U33 ( .A(n40), .Y(RdEn) );
  INVX2M U34 ( .A(n55), .Y(n15) );
  INVX2M U35 ( .A(n35), .Y(n14) );
  INVX2M U36 ( .A(n31), .Y(n10) );
  NOR2X2M U37 ( .A(n17), .B(current_state[3]), .Y(n52) );
  NAND3X2M U38 ( .A(current_state[0]), .B(n52), .C(current_state[2]), .Y(n42)
         );
  INVX2M U39 ( .A(current_state[1]), .Y(n17) );
  NOR3BX2M U40 ( .AN(n52), .B(current_state[0]), .C(n18), .Y(n30) );
  NOR3X2M U41 ( .A(current_state[1]), .B(current_state[3]), .C(n18), .Y(n53)
         );
  NAND3X2M U42 ( .A(n52), .B(n18), .C(current_state[0]), .Y(n40) );
  NAND2X2M U43 ( .A(n53), .B(current_state[0]), .Y(n33) );
  INVX2M U44 ( .A(RX_P_DATA[0]), .Y(n65) );
  INVX2M U45 ( .A(RX_P_DATA[1]), .Y(n64) );
  INVX2M U46 ( .A(RX_P_DATA[2]), .Y(n22) );
  INVX2M U47 ( .A(current_state[2]), .Y(n18) );
  INVX2M U48 ( .A(RX_D_VLD), .Y(n66) );
  INVX2M U49 ( .A(RX_P_DATA[3]), .Y(n21) );
  OAI2B11X2M U50 ( .A1N(OUT_Valid), .A0(n31), .B0(n54), .C0(n55), .Y(WR_INC)
         );
  NOR3X2M U51 ( .A(current_state[1]), .B(current_state[2]), .C(n11), .Y(n32)
         );
  OAI211X2M U52 ( .A0(RX_D_VLD), .A1(n40), .B0(n41), .C0(n23), .Y(n34) );
  NAND3X2M U53 ( .A(RX_P_DATA[4]), .B(RX_P_DATA[0]), .C(n46), .Y(n41) );
  NOR2X2M U54 ( .A(current_state[2]), .B(current_state[0]), .Y(n49) );
  NAND4BX1M U55 ( .AN(FIFO_FULL), .B(n11), .C(Rd_D_Vld), .D(n53), .Y(n54) );
  NOR2BX2M U56 ( .AN(RX_P_DATA[6]), .B(n51), .Y(Wr_D[6]) );
  NOR2BX2M U57 ( .AN(RX_P_DATA[7]), .B(n51), .Y(Wr_D[7]) );
  OAI211X2M U58 ( .A0(RX_D_VLD), .A1(n27), .B0(n13), .C0(n28), .Y(
        next_state[1]) );
  AOI211X2M U59 ( .A0(RX_D_VLD), .A1(n29), .B0(n10), .C0(n30), .Y(n28) );
  INVX2M U60 ( .A(n34), .Y(n13) );
  NAND2BX2M U61 ( .AN(n32), .B(n33), .Y(n29) );
  NAND4X2M U62 ( .A(OUT_Valid), .B(n49), .C(current_state[1]), .D(
        current_state[3]), .Y(n55) );
  AND4X2M U63 ( .A(RX_P_DATA[3]), .B(n49), .C(RX_P_DATA[7]), .D(n50), .Y(n45)
         );
  NOR3X2M U64 ( .A(n66), .B(current_state[3]), .C(current_state[1]), .Y(n50)
         );
  AOI22X1M U65 ( .A0(Rd_D[0]), .A1(n9), .B0(ALU_OUT[8]), .B1(n15), .Y(n63) );
  NAND2X2M U66 ( .A(n32), .B(current_state[3]), .Y(n31) );
  OAI2BB1X2M U67 ( .A0N(ALU_OUT[1]), .A1N(n14), .B0(n62), .Y(WR_DATA[1]) );
  AOI22X1M U68 ( .A0(Rd_D[1]), .A1(n9), .B0(ALU_OUT[9]), .B1(n15), .Y(n62) );
  OAI2BB1X2M U69 ( .A0N(ALU_OUT[2]), .A1N(n14), .B0(n61), .Y(WR_DATA[2]) );
  AOI22X1M U70 ( .A0(Rd_D[2]), .A1(n9), .B0(ALU_OUT[10]), .B1(n15), .Y(n61) );
  OAI2BB1X2M U71 ( .A0N(ALU_OUT[3]), .A1N(n14), .B0(n60), .Y(WR_DATA[3]) );
  AOI22X1M U72 ( .A0(Rd_D[3]), .A1(n9), .B0(ALU_OUT[11]), .B1(n15), .Y(n60) );
  OAI2BB1X2M U73 ( .A0N(ALU_OUT[4]), .A1N(n14), .B0(n59), .Y(WR_DATA[4]) );
  AOI22X1M U74 ( .A0(Rd_D[4]), .A1(n9), .B0(ALU_OUT[12]), .B1(n15), .Y(n59) );
  OAI2BB1X2M U75 ( .A0N(ALU_OUT[5]), .A1N(n14), .B0(n58), .Y(WR_DATA[5]) );
  AOI22X1M U76 ( .A0(Rd_D[5]), .A1(n9), .B0(ALU_OUT[13]), .B1(n15), .Y(n58) );
  OAI2BB1X2M U77 ( .A0N(ALU_OUT[6]), .A1N(n14), .B0(n57), .Y(WR_DATA[6]) );
  AOI22X1M U78 ( .A0(Rd_D[6]), .A1(n9), .B0(ALU_OUT[14]), .B1(n15), .Y(n57) );
  OAI2BB1X2M U79 ( .A0N(ALU_OUT[7]), .A1N(n14), .B0(n56), .Y(WR_DATA[7]) );
  AOI22X1M U80 ( .A0(Rd_D[7]), .A1(n9), .B0(ALU_OUT[15]), .B1(n15), .Y(n56) );
  AND4X2M U81 ( .A(RX_P_DATA[5]), .B(RX_P_DATA[1]), .C(n47), .D(n45), .Y(n46)
         );
  NOR2X2M U82 ( .A(RX_P_DATA[6]), .B(RX_P_DATA[2]), .Y(n47) );
  OA22X2M U83 ( .A0(RX_D_VLD), .A1(n42), .B0(n43), .B1(n44), .Y(n23) );
  NAND3X2M U84 ( .A(RX_P_DATA[0]), .B(RX_P_DATA[6]), .C(RX_P_DATA[4]), .Y(n44)
         );
  NAND4X2M U85 ( .A(RX_P_DATA[2]), .B(n45), .C(n64), .D(n19), .Y(n43) );
  NAND4X2M U86 ( .A(n35), .B(n26), .C(n36), .D(n37), .Y(next_state[0]) );
  NAND3X2M U87 ( .A(n65), .B(n20), .C(n46), .Y(n36) );
  AOI211X2M U88 ( .A0(n30), .A1(RX_D_VLD), .B0(n34), .C0(n38), .Y(n37) );
  AOI21X2M U89 ( .A0(n33), .A1(n39), .B0(RX_D_VLD), .Y(n38) );
  INVX2M U90 ( .A(current_state[3]), .Y(n16) );
  INVX2M U91 ( .A(current_state[0]), .Y(n11) );
  OAI31X1M U92 ( .A0(n16), .A1(current_state[2]), .A2(current_state[1]), .B0(
        n12), .Y(next_state[3]) );
  NAND4X2M U93 ( .A(OUT_Valid), .B(n49), .C(current_state[3]), .D(n17), .Y(n35) );
  NAND4X2M U94 ( .A(RX_P_DATA[2]), .B(n45), .C(RX_P_DATA[6]), .D(n48), .Y(n26)
         );
  NOR4X1M U95 ( .A(RX_P_DATA[5]), .B(RX_P_DATA[4]), .C(RX_P_DATA[1]), .D(
        RX_P_DATA[0]), .Y(n48) );
  INVX2M U96 ( .A(RX_P_DATA[4]), .Y(n20) );
  INVX2M U97 ( .A(RX_P_DATA[5]), .Y(n19) );
  NAND3X2M U98 ( .A(n23), .B(n24), .C(n25), .Y(next_state[2]) );
  AOI21BX2M U99 ( .A0(RdEn), .A1(RX_D_VLD), .B0N(n26), .Y(n25) );
  OAI2BB1X2M U100 ( .A0N(ALU_OUT[0]), .A1N(n14), .B0(n63), .Y(WR_DATA[0]) );
  INVX2M U3 ( .A(1'b0), .Y(CLK_DIV_EN) );
  INVX2M U5 ( .A(1'b1), .Y(CLK_EN) );
endmodule


module Pulse_Gen_test_1 ( CLK, RST, en_sig, Pulse_en, test_si, test_so, 
        test_se );
  input CLK, RST, en_sig, test_si, test_se;
  output Pulse_en, test_so;
  wire   sync_flop, meta_flop;
  assign test_so = sync_flop;

  SDFFRQX2M meta_flop_reg ( .D(en_sig), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(meta_flop) );
  SDFFRQX1M sync_flop_reg ( .D(meta_flop), .SI(meta_flop), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(sync_flop) );
  NOR2BX2M U6 ( .AN(meta_flop), .B(sync_flop), .Y(Pulse_en) );
endmodule


module SYSTEM ( REF_CLK, RST, UART_CLK, UART_RX_IN, scan_clk, scan_reset, 
        test_mode, SE, SI, SO, UART_TX_OUT );
  input [3:0] SI;
  output [3:0] SO;
  input REF_CLK, RST, UART_CLK, UART_RX_IN, scan_clk, scan_reset, test_mode,
         SE;
  output UART_TX_OUT;
  wire   REF_CLK_M, UART_CLK_M, RST_M, SYNC_REF_RST, SYNC_REF_RST_M,
         SYNC_UART_RST, SYNC_UART_RST_M, UART_RX_Vld_OUT, UART_RX_Vld_SYNC,
         UART_TX_CLK, UART_TX_CLK_M, UART_RX_CLK, UART_RX_CLK_M, _1_net_,
         ALU_CLK, RF_WrEn, RF_RdEn, RF_RdData_VLD, ALU_EN, ALU_OUT_VLD,
         UART_TX_Busy, F_EMPTY, WR_INC, RD_INC, FIFO_FULL, n1, n2, n3, n4, n5,
         n6, n9, n10, n11, n15, n16, n17, n20, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32;
  wire   [7:0] UART_RX_OUT;
  wire   [7:0] UART_RX_SYNC;
  wire   [7:0] DIV_RATIO;
  wire   [3:0] Addr;
  wire   [7:0] Wr_D;
  wire   [7:0] RF_RdData;
  wire   [7:0] Op_A;
  wire   [7:0] Op_B;
  wire   [7:0] UART_Config;
  wire   [3:0] ALU_FUN;
  wire   [15:0] ALU_OUT;
  wire   [7:0] RD_DATA;
  wire   [7:0] WR_DATA;
  assign SO[2] = DIV_RATIO[2];
  assign _1_net_ = test_mode;

  INVX2M U5 ( .A(F_EMPTY), .Y(n1) );
  BUFX2M U6 ( .A(_1_net_), .Y(n2) );
  INVX4M U7 ( .A(n6), .Y(n5) );
  INVX2M U8 ( .A(SYNC_REF_RST_M), .Y(n6) );
  INVX4M U9 ( .A(n4), .Y(n3) );
  INVX2M U10 ( .A(SYNC_UART_RST_M), .Y(n4) );
  INVXLM U12 ( .A(n26), .Y(n22) );
  DLY1X1M U13 ( .A(n30), .Y(n23) );
  INVXLM U14 ( .A(n32), .Y(n24) );
  INVXLM U15 ( .A(n24), .Y(n25) );
  INVXLM U16 ( .A(SE), .Y(n26) );
  INVXLM U17 ( .A(n26), .Y(n27) );
  INVXLM U18 ( .A(n22), .Y(n28) );
  INVXLM U19 ( .A(n28), .Y(n29) );
  INVXLM U20 ( .A(n28), .Y(n30) );
  INVXLM U21 ( .A(n28), .Y(n31) );
  INVXLM U22 ( .A(n28), .Y(n32) );
  mux2X1_1 U_reference_clock_multiplexer ( .IN_0(REF_CLK), .IN_1(scan_clk), 
        .SEL(n2), .OUT(REF_CLK_M) );
  mux2X1_4 U_UART_clock_multiplexer ( .IN_0(UART_CLK), .IN_1(scan_clk), .SEL(
        n2), .OUT(UART_CLK_M) );
  mux2X1_0 U_reset_multiplexer ( .IN_0(RST), .IN_1(scan_reset), .SEL(n2), 
        .OUT(RST_M) );
  RST_SYNC_test_0 RST_SYNC_1 ( .RST(RST_M), .CLK(REF_CLK_M), .SYNC_RST(
        SYNC_REF_RST), .test_si(n16), .test_se(n30) );
  mux2X1_6 U_reference_reset_multiplexer ( .IN_0(SYNC_REF_RST), .IN_1(
        scan_reset), .SEL(n2), .OUT(SYNC_REF_RST_M) );
  RST_SYNC_test_1 RST_SYNC_2 ( .RST(RST_M), .CLK(UART_CLK_M), .SYNC_RST(
        SYNC_UART_RST), .test_si(SYNC_REF_RST), .test_se(n31) );
  mux2X1_5 U_UART_reset_multiplexer ( .IN_0(SYNC_UART_RST), .IN_1(scan_reset), 
        .SEL(n2), .OUT(SYNC_UART_RST_M) );
  DATA_SYNC_test_1 U0_ref_sync ( .CLK(REF_CLK_M), .RST(n5), .unsync_bus(
        UART_RX_OUT), .bus_enable(UART_RX_Vld_OUT), .sync_bus(UART_RX_SYNC), 
        .enable_pulse_d(UART_RX_Vld_SYNC), .test_si(n10), .test_so(n9), 
        .test_se(n29) );
  ClkDiv_test_0 U0_ClkDiv ( .i_ref_clk(UART_CLK_M), .i_rst(n3), .i_clk_en(1'b1), .i_div_ratio(DIV_RATIO), .o_div_clk(UART_TX_CLK), .test_si(ALU_OUT_VLD), 
        .test_so(n15), .test_se(n32) );
  mux2X1_3 U_TX_CLK_multiplexer ( .IN_0(UART_TX_CLK), .IN_1(scan_clk), .SEL(n2), .OUT(UART_TX_CLK_M) );
  ClkDiv_test_1 U1_ClkDiv ( .i_ref_clk(UART_CLK_M), .i_rst(n3), .i_clk_en(1'b1), .i_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0}), .o_div_clk(
        UART_RX_CLK), .test_si(n9), .test_so(SO[0]), .test_se(n27) );
  mux2X1_2 U_RX_CLK_multiplexer ( .IN_0(UART_RX_CLK), .IN_1(scan_clk), .SEL(n2), .OUT(UART_RX_CLK_M) );
  CLK_GATE U0_CLK_GATE ( .CLK_EN(n2), .CLK(REF_CLK_M), .GATED_CLK(ALU_CLK) );
  REG_FILE_test_1 U0_RegFile ( .WrData(Wr_D), .Address(Addr), .WrEn(RF_WrEn), 
        .RdEn(RF_RdEn), .CLK(REF_CLK_M), .RST(n5), .RdData(RF_RdData), 
        .RdData_VLD(RF_RdData_VLD), .REG0(Op_A), .REG1(Op_B), .REG2(
        UART_Config), .REG3(DIV_RATIO), .test_si3(SI[0]), .test_si2(SI[1]), 
        .test_si1(n15), .test_so2(n11), .test_so1(SO[1]), .test_se(SE) );
  ALU_test_1 U0_ALU ( .A(Op_A), .B(Op_B), .ALU_FUN(ALU_FUN), .EN(ALU_EN), 
        .CLK(ALU_CLK), .RST(n5), .ALU_OUT(ALU_OUT), .OUT_VALID(ALU_OUT_VLD), 
        .test_si(SYNC_UART_RST), .test_se(n25) );
  UART_test_1 U0_UART ( .RST(n3), .TX_CLK(UART_TX_CLK_M), .RX_CLK(
        UART_RX_CLK_M), .RX_IN_S(UART_RX_IN), .RX_OUT_P(UART_RX_OUT), 
        .RX_OUT_V(UART_RX_Vld_OUT), .TX_IN_P(RD_DATA), .TX_IN_V(n1), 
        .TX_OUT_S(UART_TX_OUT), .TX_OUT_V(UART_TX_Busy), .Prescale(
        UART_Config[7:2]), .parity_enable(UART_Config[0]), .parity_type(
        UART_Config[1]), .test_si(n11), .test_so(n10), .test_se(n23) );
  Asynch_FIFO_test_1 F1_fifo ( .winc(WR_INC), .wclk(REF_CLK_M), .wrst_n(n5), 
        .rinc(RD_INC), .rclk(UART_TX_CLK_M), .rrst_n(n3), .wdata(WR_DATA), 
        .rdata(RD_DATA), .wfull(FIFO_FULL), .rempty(F_EMPTY), .test_si2(SI[2]), 
        .test_si1(n20), .test_so2(n17), .test_so1(SO[3]), .test_se(SE) );
  SYS_CTRL_test_1 C0_CTRL ( .RX_P_DATA(UART_RX_SYNC), .RX_D_VLD(
        UART_RX_Vld_SYNC), .FIFO_FULL(FIFO_FULL), .ALU_OUT(ALU_OUT), 
        .OUT_Valid(ALU_OUT_VLD), .Rd_D_Vld(RF_RdData_VLD), .Rd_D(RF_RdData), 
        .CLK(REF_CLK_M), .RST(n5), .WR_DATA(WR_DATA), .WR_INC(WR_INC), 
        .ALU_EN(ALU_EN), .ALU_FUN(ALU_FUN), .Wr_D(Wr_D), .Addr(Addr), .RdEn(
        RF_RdEn), .WrEn(RF_WrEn), .test_si(SI[3]), .test_so(n20), .test_se(n27) );
  Pulse_Gen_test_1 PUL_GEN_1 ( .CLK(UART_TX_CLK_M), .RST(n3), .en_sig(
        UART_TX_Busy), .Pulse_en(RD_INC), .test_si(n17), .test_so(n16), 
        .test_se(n27) );
endmodule

