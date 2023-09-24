

module Parity_Calc 

(
 input   wire                  CLK,
 input   wire                  RST,
 input   wire                  PAR_EN,
 input   wire                  PAR_TYP,
 input   wire   [7:0]          P_DATA,
 input   wire                  busy,
 input   wire                  Data_Valid,
 output  reg                   par_bit 
);


 

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    par_bit <= 'b0 ;
   end
  else
   begin
    if (PAR_EN && Data_Valid && !busy)
	   begin
	    case(PAR_TYP)
	     1'b0 : begin                 
	             par_bit <= ^P_DATA  ;     // Even Parity
	            end
	     1'b1 : begin
	             par_bit <= ~^P_DATA ;     // Odd Parity
	            end		
	    endcase       	 
	   end
   end
 end 


endmodule
 