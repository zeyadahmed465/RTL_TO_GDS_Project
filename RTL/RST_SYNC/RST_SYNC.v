
/////////////////////////////////////////////////////////////
/////////////////////// Clock Gating ////////////////////////
/////////////////////////////////////////////////////////////

module RST_SYNC # ( 
    parameter NUM_STAGES = 2 
)(	
input    wire     RST,
input    wire     CLK,
output   wire     SYNC_RST
);

//internal connections
		
reg   [NUM_STAGES-1:0]    sync_reg;
		

//double flop synchronizer
always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    sync_reg <= 'b0 ;
   end
  else
   begin
    sync_reg <= {sync_reg[NUM_STAGES-2:0],1'b1} ;
   end  
 end
 
 
assign  SYNC_RST = sync_reg[NUM_STAGES-1] ;



endmodule
