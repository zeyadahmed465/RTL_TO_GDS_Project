module FIFO_mem #(parameter Data_Width = 8, DEPTH = 8, POI_SIZE = 4 )
(
input 	wire     	            wclk		 ,
input 	wire 		               wrst_n	,
input 	wire 		               winc	  ,
input 	wire 		               wfull	 ,
input 	wire [Data_Width-1:0] wdata		, 
input 	wire [POI_SIZE-2  :0] waddr	 ,
input 	wire [POI_SIZE-2  :0] raddr	 ,
output  wire [Data_Width-1:0] rdata

);

integer I ; 
  
reg [Data_Width-1:0] MEM [DEPTH-1:0] ; 

always@(posedge wclk or negedge wrst_n)
 begin
  if(!wrst_n)
    begin

      for (I=0 ; I < DEPTH ; I = I +1)
        begin
	 MEM[I] <= {Data_Width{1'b0}} ;
	end
    end
  else if(!wfull && winc)
   begin
     MEM[waddr] <= wdata ;
   end

 end

assign rdata = MEM[raddr] ;

endmodule
