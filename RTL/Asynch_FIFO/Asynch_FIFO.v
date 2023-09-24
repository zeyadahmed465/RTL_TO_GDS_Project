// Top level wrapper
//
module Asynch_FIFO
#(
  parameter DSIZE = 8,
  parameter AddrSIZE = 4,
  parameter F_DEPTH = 8                         // fifo depth
)
 
(
  input   winc, wclk, wrst_n,//winc write enable signal
  input   rinc, rclk, rrst_n,//rinc read enable signal
  input   [DSIZE-1:0] wdata,

  output  [DSIZE-1:0] rdata,
  output  	      wfull,
  output  	      rempty
);

  wire [AddrSIZE-2:0] waddr, raddr;
  wire [AddrSIZE-1:0] g_wptr, g_rptr, wq2_rptr, rq2_wptr;

BIT_SYNC #(.NUM_STAGES(2) , .BUS_WIDTH(AddrSIZE)) u_r2w_sync (
.CLK(wclk) ,
.RST(wrst_n) ,
.ASYNC(g_rptr) ,
.SYNC(wq2_rptr)
);

BIT_SYNC #(.NUM_STAGES(2) , .BUS_WIDTH(AddrSIZE)) u_w2r_sync (
.CLK(rclk) ,
.RST(rrst_n) ,
.ASYNC(g_wptr) ,
.SYNC(rq2_wptr)
);

 FIFO_mem #(.DEPTH(F_DEPTH), .Data_Width(DSIZE), .POI_SIZE(AddrSIZE)) fifomem (.wclk(wclk),
				      .wrst_n(wrst_n),
				      .winc(winc),
				      .wfull(wfull),
				      .wdata(wdata),
				      .rdata(rdata),
				      .waddr(waddr),
				      .raddr(raddr)
				      
				      );


  r_empty #(.P_SIZE(AddrSIZE)) rptr_empty 
         (.rinc(rinc),
				  .rclk(rclk),
				  .rrst_n(rrst_n),
				  .rq2_wptr(rq2_wptr),
				  .rempty(rempty),
				  .raddr(raddr),
				  .g_rptr(g_rptr)
				  );

  w_full #(.POI_SIZE(AddrSIZE)) wptr_full  
        (.winc(winc),
				 .wclk(wclk),
				 .wrst_n(wrst_n),
				 .wq2_rptr(wq2_rptr),
				 .wfull(wfull),
				 .waddr(waddr),
		                 .g_wptr(g_wptr)

				   );

endmodule

