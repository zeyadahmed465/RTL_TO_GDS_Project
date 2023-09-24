
module SYSTEM #( parameter DATA_WIDTH = 8 , Addr_SIZE = 4 , NUM_OF_CHAINS = 4)

(
    input   wire                          REF_CLK 		 ,
    input   wire                          RST		         ,
    input   wire                          UART_CLK		 ,
    input   wire                          UART_RX_IN	         ,
    input scan_clk,
    input scan_reset,
    input test_mode,
    input SE,
    input [NUM_OF_CHAINS-1:0]   SI,
    output [NUM_OF_CHAINS-1:0]  SO,
    output            			  UART_TX_OUT	

);

wire                                 			       SYNC_UART_RST ,
                                      			       SYNC_REF_RST  ;


wire      [DATA_WIDTH-1:0]           			       Op_A  	   ,
                                    			       Op_B 	   ,
				                               UART_Config ,
				                               DIV_RATIO   ;

wire      [DATA_WIDTH-1:0]           			      UART_RX_OUT       ;
wire         			               	              UART_RX_Vld_OUT	;
wire      [DATA_WIDTH-1:0]	        		      UART_RX_SYNC	;
wire                                 			      UART_RX_Vld_SYNC	;

wire                                   			       CLKDIV_EN       	     ;
wire				                               UART_TX_CLK	     ;
wire				                               UART_RX_CLK	     ;

//fifo

wire      [DATA_WIDTH-1:0]	            		       RD_DATA		    ;
wire				                               UART_TX_Busy	    ;

// RF=>ctrl
wire        [DATA_WIDTH-1:0]             		      Wr_D             ;
wire 	    [Addr_SIZE-1 :0]	     		              Addr             ;
wire                            		              RF_WrEn	       ;
wire                               		              RF_RdEn          ;
wire 	    [DATA_WIDTH-1:0]	    		              RF_RdData        ;
wire                                			      RF_RdData_VLD;	

// ALU =>SyS
wire                          			               CLKG_EN       ;
wire                                  			       ALU_CLK 	     ;
wire				                               ALU_EN	     ;
wire	     [3:0]			                       ALU_FUN	     ;
wire	     [DATA_WIDTH*2-1:0]	          		       ALU_OUT	     ;
wire				                               ALU_OUT_VLD  ;

//
wire                                  			      WR_INC    ;
wire      [DATA_WIDTH-1:0]	      			      WR_DATA   ;
wire                                  			      FIFO_FULL ; 
wire 				                              F_EMPTY	;
wire                                  			      RD_INC    ;

wire 							      REF_CLK_M       ;
wire							      UART_CLK_M      ;
wire							      RST_M	      ; 
wire							      SYNC_REF_RST_M  ;							    
wire							      SYNC_UART_RST_M ;	
wire							      ALU_CLK_M	      ;	
wire							      UART_TX_CLK_M   ;	
wire							      UART_RX_CLK_M   ;


    
mux2X1 U_reference_clock_multiplexer (
        .IN_0(REF_CLK),
        .IN_1(scan_clk),
        .SEL(test_mode),
        .OUT(REF_CLK_M)
    );

mux2X1 U_UART_clock_multiplexer (
        .IN_0(UART_CLK),
        .IN_1(scan_clk),
        .SEL(test_mode),
        .OUT(UART_CLK_M)
    );

mux2X1 U_reset_multiplexer (
        .IN_0(RST),
        .IN_1(scan_reset),
        .SEL(test_mode),
        .OUT(RST_M)
    );







//////////////////// Reset synchronizers ////////////////


RST_SYNC RST_SYNC_1 (
.RST(RST_M),
.CLK(REF_CLK_M),
.SYNC_RST(SYNC_REF_RST)
);


mux2X1 U_reference_reset_multiplexer (
        .IN_0(SYNC_REF_RST),
        .IN_1(scan_reset),
        .SEL(test_mode),
        .OUT(SYNC_REF_RST_M)
    );


RST_SYNC RST_SYNC_2 (
.RST(RST_M),
.CLK(UART_CLK_M),
.SYNC_RST(SYNC_UART_RST)
);

mux2X1 U_UART_reset_multiplexer (
        .IN_0(SYNC_UART_RST),
        .IN_1(scan_reset),
        .SEL(test_mode),
        .OUT(SYNC_UART_RST_M)
    );

////////////////////// Data Synchronizer ////////////////

DATA_SYNC U0_ref_sync (
.CLK(REF_CLK_M),
.RST(SYNC_REF_RST_M),
.unsync_bus(UART_RX_OUT),
.bus_enable(UART_RX_Vld_OUT),
.sync_bus(UART_RX_SYNC),
.enable_pulse_d(UART_RX_Vld_SYNC)
);


//////////////////////// Clock Divider /////////////////


ClkDiv U0_ClkDiv (
.i_ref_clk(UART_CLK_M),             
.i_rst(SYNC_UART_RST_M),                 
.i_clk_en(CLKDIV_EN),               
.i_div_ratio(DIV_RATIO),           
.o_div_clk(UART_TX_CLK)               
);

mux2X1 U_TX_CLK_multiplexer (
        .IN_0(UART_TX_CLK),
        .IN_1(scan_clk),
        .SEL(test_mode),
        .OUT(UART_TX_CLK_M)
    );

ClkDiv U1_ClkDiv (
.i_ref_clk(UART_CLK_M)	,  //32*tx_clk           
.i_rst(SYNC_UART_RST_M) ,                 
.i_clk_en(CLKDIV_EN)	,               
.i_div_ratio(8'b00000100),           
.o_div_clk(UART_RX_CLK)      
);


mux2X1 U_RX_CLK_multiplexer (
        .IN_0(UART_RX_CLK),
        .IN_1(scan_clk),
        .SEL(test_mode),
        .OUT(UART_RX_CLK_M)
    );

///////////////////////// Clock Gating ///////////////////////


CLK_GATE U0_CLK_GATE (
.CLK_EN(CLKG_EN||test_mode),
.CLK(REF_CLK_M),
.GATED_CLK(ALU_CLK)
);


/////////////////////// Register File ////////////////////////


REG_FILE U0_RegFile (
.CLK(REF_CLK_M),
.RST(SYNC_REF_RST_M),
.WrEn(RF_WrEn),
.RdEn(RF_RdEn),
.Address(Addr),
.WrData(Wr_D),
.RdData(RF_RdData),
.RdData_VLD(RF_RdData_VLD),
.REG0(Op_A),
.REG1(Op_B),
.REG2(UART_Config),
.REG3(DIV_RATIO)
);

//////////////////////////// ALU /////////////////////////////
 
ALU U0_ALU (
.CLK(ALU_CLK),
.RST(SYNC_REF_RST_M),  
.A(Op_A), 
.B(Op_B),
.EN(ALU_EN),
.ALU_FUN(ALU_FUN),
.ALU_OUT(ALU_OUT),
.OUT_VALID(ALU_OUT_VLD)
);


/////////////////////////// UART ///////////////////////

UART  U0_UART (
.RST(SYNC_UART_RST_M),
.TX_CLK(UART_TX_CLK_M),
.RX_CLK(UART_RX_CLK_M),
.parity_enable(UART_Config[0]),
.parity_type(UART_Config[1]),
.Prescale(UART_Config[7:2]),
.RX_IN_S(UART_RX_IN),
.RX_OUT_P(UART_RX_OUT),                      
.RX_OUT_V(UART_RX_Vld_OUT),                      
.TX_IN_P(RD_DATA), 
.TX_IN_V(~F_EMPTY), 
.TX_OUT_S(UART_TX_OUT),
.TX_OUT_V(UART_TX_Busy)                 
);

//////////////////////////// FIFO /////////////////////////////


Asynch_FIFO F1_fifo (.winc(WR_INC),
	      .wclk(REF_CLK_M),
	      .wrst_n(SYNC_REF_RST_M),
	      .rclk(UART_TX_CLK_M),
	      .rrst_n(SYNC_UART_RST_M),
	      .rinc(RD_INC),
	      .wdata(WR_DATA),
	      .rdata(RD_DATA),
	      .wfull(FIFO_FULL),
	      .rempty(F_EMPTY)
	     );

//////////////////////////// SYS_CTRL /////////////////////////////
SYS_CTRL  C0_CTRL (.RX_P_DATA(UART_RX_SYNC),
		   .RX_D_VLD(UART_RX_Vld_SYNC),
		   .FIFO_FULL(FIFO_FULL),
		   .ALU_OUT(ALU_OUT), 
		   .OUT_Valid(ALU_OUT_VLD),
		   .Rd_D_Vld(RF_RdData_VLD),
		   .Rd_D(RF_RdData),
		   .CLK(REF_CLK_M),
		   .RST(SYNC_REF_RST_M),
		   .WR_DATA(WR_DATA),
		   .WR_INC(WR_INC),
		   .ALU_EN(ALU_EN),
		   .ALU_FUN(ALU_FUN),
		   .Wr_D(Wr_D),
		   .Addr(Addr),
		   .RdEn(RF_RdEn),
		   .WrEn(RF_WrEn),
		   .CLK_EN(CLKG_EN),
		   .CLK_DIV_EN(CLKDIV_EN)
		  );



Pulse_Gen PUL_GEN_1 (.CLK(UART_TX_CLK_M),
		     .RST(SYNC_UART_RST_M),
		     .en_sig(UART_TX_Busy),
		     .Pulse_en(RD_INC)
		    );

endmodule

