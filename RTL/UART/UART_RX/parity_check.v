module parity_check #(parameter DATA_WIDTH = 8)(
  input   wire                   enable            ,
  input   wire                   sampled_bit       ,
  input   wire                   PAR_TYP           ,
  input   wire [DATA_WIDTH-1 :0] P_DATA            ,
  input   wire                   CLK               ,
  input   wire                   RST               ,
  output  reg                    par_err 
  );
  
 reg par_bit;
  
always@(posedge CLK or negedge RST)
 begin 
   if(!RST)
     begin
      par_err <= 'b0;
     end
   else if(enable)
     begin
      if(sampled_bit == par_bit)
        par_err <= 'b0;
      else
        par_err <= 'b1;
     end
 end
always@(posedge CLK or negedge RST)
 begin 
     if(!RST)
       begin
        par_bit <= 'b0;
       end
       
   else
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
endmodule
  
