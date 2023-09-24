

/////////////////////////////////////////////////////////////
//////////////////// data synchronizer //////////////////////
/////////////////////////////////////////////////////////////

module DATA_SYNC # ( 
     parameter NUM_STAGES = 2 ,
	 parameter BUS_WIDTH = 8 
)(
input    wire                      CLK,
input    wire                      RST,
input    wire     [BUS_WIDTH-1:0]  unsync_bus,
input    wire                      bus_enable,
output   reg      [BUS_WIDTH-1:0]  sync_bus,
output   reg                       enable_pulse_d
);



//internal connections
reg   [NUM_STAGES-1:0]    sync_reg;
reg                       enable_flop ;
					 
wire                      enable_pulse ;

wire  [BUS_WIDTH-1:0]     sync_bus_c ;
					 
//----------------- Multi flop synchronizer --------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    sync_reg <= 'b0 ;
   end
  else
   begin
    sync_reg <= {sync_reg[NUM_STAGES-2:0],bus_enable};
   end  
 end
 

//----------------- pulse generator --------------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    enable_flop <= 1'b0 ;	
   end
  else
   begin
    enable_flop <= sync_reg[NUM_STAGES-1] ;
   end  
 end

 
assign enable_pulse = sync_reg[NUM_STAGES-1] && !enable_flop ;


//----------------- multiplexing --------------------

assign sync_bus_c =  enable_pulse ? unsync_bus : sync_bus ;  


//----------- destination domain flop ---------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    sync_bus <= 'b0 ;	
   end
  else
   begin
    sync_bus <= sync_bus_c ;
   end  
 end
 
//--------------- delay generated pulse ------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    enable_pulse_d <= 1'b0 ;	
   end
  else
   begin
    enable_pulse_d <= enable_pulse ;
   end  
 end
 

endmodule