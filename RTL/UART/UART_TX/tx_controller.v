module tx_controller (
  input wire Data_Valid       ,
  input wire PAR_EN           ,
  input wire ser_done         ,
  input wire CLK              ,
  input wire RST              ,
  output reg ser_en           ,
  output reg [1:0] mux_sel    ,
  output reg busy 
  );

//states
parameter           IDLE   = 3'b000  ,
                    START  = 3'b001  ,                    
                    DATA   = 3'b010  ,
                    PARITY = 3'b011  ,
                    STOP   = 3'b100  ;
                
reg      [2:0]      current_state ,
                    next_state ;
                    
                    
  
//state transition
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    current_state <= IDLE ;
   end
  else
   begin
    current_state <= next_state ;
   end
 end


//next state logic
always@(*)
 begin
   case (current_state)
   IDLE   :  begin
               if(Data_Valid)
                 next_state = START     ;
               else
                 next_state = IDLE      ;
             end 
             
   START  :  begin
                  next_state = DATA     ;
             end 
             
   DATA   : begin
              if(ser_done)
			          begin
			           if(PAR_EN)
			             next_state = PARITY ;
                 else
			             next_state = STOP ;			  
			          end
			       else
			          next_state = DATA ; 	
            end                
            
   PARITY   : begin 
                next_state = STOP ;
              end
              
   STOP     : begin
                   next_state = IDLE  ;
              end    
   default  : begin
                 next_state = IDLE  ;
              end  
   endcase   
 end
 

//output logic 
always@(*)
 begin 
   case (current_state)
   IDLE  : begin 
             mux_sel = 2'b11 ;
             busy    = 1'b0  ; 
             ser_en  = 1'b0  ;
           end 
           
   START : begin
             mux_sel = 2'b00 ;
             busy    = 1'b1  ; 
             ser_en  = 1'b1  ;
           end
          
   DATA  : begin
             mux_sel = 2'b01 ;
             busy    = 1'b1  ;
            if(ser_done)
		        	 ser_en = 1'b0 ;  
		         	else
 			        ser_en = 1'b1 ;   
           end 
    
   PARITY : begin
             mux_sel = 2'b10 ;
             busy    = 1'b1  ;
             ser_en  = 1'b0  ;  
            end      
                        
   STOP   : begin
             mux_sel = 2'b11  ;
             busy    = 1'b1  ;
             ser_en  = 1'b0  ; 
            end
            
   default: begin
            busy = 1'b0 ;
			      ser_en = 1'b0 ;
            mux_sel = 2'b00 ;		
           end
  endcase
end
 
endmodule 