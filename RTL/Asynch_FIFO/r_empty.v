module r_empty #(parameter P_SIZE = 4
)
 (
input  wire 	          rinc     	,
input  wire 	          rclk     	,
input  wire 	      	  rrst_n   	,
input  wire [P_SIZE-1:0]  rq2_wptr 	, //synced gray from full block
output wire	     	  rempty        ,
output wire [P_SIZE-2:0]         raddr         ,
output reg  [P_SIZE-1:0]         g_rptr	
);

reg [P_SIZE-1:0] bn_rptr;

always@(posedge rclk or negedge rrst_n)
 begin
  if(!rrst_n)
	 begin
	  bn_rptr   <= 'b0 ;
  	end
  else if(rinc && !rempty)
   begin
     bn_rptr <= bn_rptr + 1'b1 ;
   end
 end

always@(posedge rclk or negedge rrst_n)
begin
if(!rrst_n)
 begin
  g_rptr <= 'b0;
 end
else
 begin
   case(bn_rptr)
      4'b0000 : g_rptr <= 4'b0000;
      4'b0001 : g_rptr <= 4'b0001;
      4'b0010 : g_rptr <= 4'b0011;
      4'b0011 : g_rptr <= 4'b0010;
      4'b0100 : g_rptr <= 4'b0110;
      4'b0101 : g_rptr <= 4'b0111;
      4'b0110 : g_rptr <= 4'b0101;
      4'b0111 : g_rptr <= 4'b0100;
      4'b1000 : g_rptr <= 4'b1100;
      4'b1001 : g_rptr <= 4'b1101;
      4'b1010 : g_rptr <= 4'b1111;
      4'b1011 : g_rptr <= 4'b1110;
      4'b1100 : g_rptr <= 4'b1010;
      4'b1101 : g_rptr <= 4'b1011;
      4'b1110 : g_rptr <= 4'b1001;
  
  endcase
 end    
end
// generation of empty flag
assign rempty = (rq2_wptr == g_rptr) ;
// address for read
assign raddr  = bn_rptr[P_SIZE-2:0];	

endmodule
      
