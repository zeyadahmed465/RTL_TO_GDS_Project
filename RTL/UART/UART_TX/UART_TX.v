module UART_TX (
  input wire [7:0] P_DATA     ,
  input wire Data_Valid       ,
  input wire PAR_EN           ,
  input wire PAR_TYP          ,
  input wire CLK              ,
  input wire RST              ,
  output wire TX_OUT          ,
  output wire busy
  );
  
  wire       ser_en   ;
  wire       ser_data ;
  wire [1:0] mux_sel  ;
  wire       par_bit  ;
  wire 	     ser_done  ;
  

  
  tx_controller U1(.Data_Valid(Data_Valid),
                    .PAR_EN(PAR_EN),
                    .ser_done(ser_done),
                    .CLK(CLK),
                    .RST(RST),
                    .ser_en(ser_en),
                    .mux_sel(mux_sel),
                    .busy(busy)
                    );
  
  Parity_Calc P1(.P_DATA(P_DATA),
                 .CLK(CLK),
                 .RST(RST),
                 .Data_Valid(Data_Valid),
                 .PAR_TYP(PAR_TYP),
                 .PAR_EN(PAR_EN)  ,
                 .busy(busy),
                 .par_bit(par_bit)
                 );
                 
   Serializer S1(.P_DATA(P_DATA),
                 .ser_en(ser_en),
                 .busy(busy),
                 .Data_Valid(Data_Valid),
                 .CLK(CLK),
                 .RST(RST),
                 .ser_data(ser_data),
                 .ser_done(ser_done)
                 );            
  
    mux_4_1    M1(.A(1'b0),
                 .B(ser_data),
                 .C(par_bit),
                 .D(1'b1),
                 .sel(mux_sel),
                 .out(TX_OUT)
                 );
endmodule
  


