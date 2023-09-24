module UART_RX #(parameter DATA_WIDTH = 8) (
  input  wire                   RX_IN      ,
  input  wire                   PAR_EN     ,
  input  wire    [5:0]          Prescale   ,
  input  wire                   PAR_TYP    ,
  input  wire                   RX_CLK     ,
  input  wire                   RST        ,
  output wire [DATA_WIDTH -1:0] P_DATA     ,
  output wire                   data_Valid
  
  );
  
wire       sampled_bit  ;
wire       cnt_en       ;
wire [3:0] bit_cnt      ;
wire [2:0] edge_cnt     ;
wire       par_chk_en   ;
wire       strt_chk_en  ;
wire       stp_chk_en   ;
wire       deser_en     ;
wire       samp_en      ;

data_sampling   D0(.RX_IN(RX_IN),
                   .Prescale(Prescale),
                   .enable(samp_en),
                   .edge_count(edge_cnt),
                   .CLK(RX_CLK),
                   .RST(RST),
                   .sampled_bit(sampled_bit)
                    );
                    
edge_bit_counter E_B_c (.enable(cnt_en),
                        .CLK(RX_CLK),
                        .RST(RST),
                        .bit_cnt(bit_cnt),
                        .edge_cnt(edge_cnt)
                       );
          
RX_controller    RX0  (.RX_IN(RX_IN),
                       .PAR_EN(PAR_EN),
                       .edge_cnt(edge_cnt),
                       .bit_cnt(bit_cnt),
                       .stp_err(stp_err),
                       .strt_glitch(strt_glitch),
                       .par_err(par_err),
                       .CLK(RX_CLK),
                       .RST(RST),
                       .par_chk_en(par_chk_en),
                       .strt_chk_en(strt_chk_en),
                       .stp_chk_en(stp_chk_en ),
                       .deser_en(deser_en),
                       .samp_en(samp_en),
                       .cnt_en(cnt_en),
                       .data_valid(data_Valid)
                       );

stop_check         STP0(.sampled_bit(sampled_bit),
                        .enable(stp_chk_en),
                        .CLK(RX_CLK),
                        .RST(RST),
                        .stp_err( stp_err)
                        ); 
                      
strt_check         STR0(.enable(strt_chk_en),
                        .sampled_bit(sampled_bit),
                        .CLK(RX_CLK),
                        .RST(RST),
                        .strt_glitch(strt_glitch)
                        );
                      
parity_check       Par0(.enable(par_chk_en),
                        .sampled_bit(sampled_bit),
                        .PAR_TYP(PAR_TYP),
                        .P_DATA(P_DATA), 
                        .CLK(RX_CLK), 
                        .RST(RST),
                        .par_err(par_err)
                        );               
                        
deserializer        DSR0(.sampled_bit(sampled_bit),
                         .edge_cnt(edge_cnt),
                         .enable(deser_en),
                         .CLK(RX_CLK),
                         .RST(RST),
                         .P_DATA(P_DATA)
                         
                        );                                
  
endmodule
