module w_full #(parameter POI_SIZE = 4
)
 (
input  wire 			   winc     	,
input  wire 			   wclk     	,
input  wire 	  		   wrst_n   	,
input  wire [POI_SIZE-1:0]	   wq2_rptr 	,
output wire	  		   wfull	,
output wire [POI_SIZE-2:0]         waddr	,
output reg  [POI_SIZE-1:0]         g_wptr	

);

reg [POI_SIZE-1:0] bn_wptr;
always@(posedge wclk or negedge wrst_n)
 begin
   if(!wrst_n)
	begin
	 bn_wptr  <= 'b0 ;
	end
  else if(winc && !wfull )
       bn_wptr <= bn_wptr + 1'b1 ;
 end

assign waddr  = bn_wptr[POI_SIZE-2:0];

always@(posedge wclk or negedge  wrst_n )
 begin
  if(!wrst_n)
   begin
    g_wptr <= 'b0 ;
   end
else 
 begin
   case(bn_wptr)
      4'b0000 : g_wptr <= 4'b0000;
      4'b0001 : g_wptr <= 4'b0001;
      4'b0010 : g_wptr <= 4'b0011;
      4'b0011 : g_wptr <= 4'b0010;
      4'b0100 : g_wptr <= 4'b0110;
      4'b0101 : g_wptr <= 4'b0111;
      4'b0110 : g_wptr <= 4'b0101;
      4'b0111 : g_wptr <= 4'b0100;
      4'b1000 : g_wptr <= 4'b1100;
      4'b1001 : g_wptr <= 4'b1101;
      4'b1010 : g_wptr <= 4'b1111;
      4'b1011 : g_wptr <= 4'b1110;
      4'b1100 : g_wptr <= 4'b1010;
      4'b1101 : g_wptr <= 4'b1011;
      4'b1110 : g_wptr <= 4'b1001;
 endcase
 end
end    

// generation of full flag
assign wfull = (bn_wptr[POI_SIZE-1]!=  g_wptr[POI_SIZE-1] && bn_wptr[POI_SIZE-2]!=  g_wptr[POI_SIZE-2] && bn_wptr[POI_SIZE-3:0]==  g_wptr[POI_SIZE-3:0]) ;



endmodule