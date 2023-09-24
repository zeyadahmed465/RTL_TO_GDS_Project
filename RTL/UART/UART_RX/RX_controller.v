module RX_controller (
  input   wire       RX_IN       ,  
  input   wire       PAR_EN      ,
  input   wire [2:0] edge_cnt    ,
  input   wire [3:0] bit_cnt     ,
  input   wire       stp_err     ,
  input   wire       strt_glitch ,
  input   wire       par_err     ,
  input   wire       CLK         ,
  input   wire       RST         ,
  output  reg        par_chk_en  ,
  output  reg        strt_chk_en ,
  output  reg        stp_chk_en  ,
  output  reg        deser_en    ,
  output  reg        samp_en     ,
  output  reg        cnt_en      ,
  output  reg        data_valid  
  );
  
//states
parameter           IDLE       = 3'b000  ,
                    START      = 3'b001  ,                    
                    DATA       = 3'b010  ,
                    PARITY     = 3'b011  ,
                    STOP       = 3'b100  ,
                    Valid      = 3'b101  ;
                
reg      [2:0]      current_state ,
                    next_state ;  
always@(posedge CLK or negedge RST)
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
       IDLE    :  begin
                   if(!RX_IN)
                     next_state  = START ;
                   else
                     next_state  = IDLE  ;
                  end
              
       START   :  begin
                   if(!strt_glitch && edge_cnt == 'd7)
                     next_state = DATA   ;
                   else if(strt_glitch)
                     next_state = IDLE  ;
                   else
                     next_state = START ;
                  end
              
                 
       DATA    :  begin
                    if(bit_cnt == 'd8 && edge_cnt == 'd7 && PAR_EN)
                      next_state = PARITY ;
                    else
                      next_state = DATA ;
                  end  
              
       PARITY  :  begin
                   if(edge_cnt == 'd7)
                     if(!par_err)
                       next_state = STOP ;
		     else
                      next_state  = IDLE ;
                   else if(par_err)
                     next_state = IDLE ;
                   else
                     next_state = PARITY ;
                  end    
              
       STOP    :  begin
                   if(edge_cnt == 'd7)
                     if(!stp_err)
                      next_state = Valid ;
		     else
                      next_state  = IDLE ;
                   else
                     next_state  = IDLE ;
                  end   
              
       Valid :  begin  
                   if(RX_IN)
                     next_state = IDLE  ;
                  else
                     next_state = START ;
                  end
                  
       default  : begin
                   next_state = IDLE   ;
                  end
                endcase
end       
always@(*)
 begin
     par_chk_en  = 'b0 ;
     strt_chk_en = 'b0 ;
     stp_chk_en  = 'b0 ;
     deser_en    = 'b0 ;
     samp_en     = 'b0 ;
     data_valid  = 'b0 ;
     cnt_en	 = 'b0 ;
   case (current_state)   
      
   
       IDLE    :  begin
                    par_chk_en  = 'b0 ;
                    strt_chk_en = 'b0 ;
                    stp_chk_en  = 'b0 ;
                    deser_en    = 'b0 ;
                    samp_en     = 'b1 ;
                    data_valid  = 'b0 ;
                  end
              
       START   :  begin
                    cnt_en      = 'b1 ;
                    samp_en     = 'b1 ;
                    strt_chk_en = 'b1 ;
                    deser_en    = 'b0 ;
                    data_valid  = 'b0 ;
                  end
              
                 
       DATA    :  begin
                   cnt_en      = 'b1 ;
                   samp_en     = 'b1 ;
                   deser_en    = 'b1 ;
                   strt_chk_en = 'b0 ;
                  end  
              
       PARITY  :  begin
                    par_chk_en  = 'b1  ;
                    samp_en     = 'b1 ;
                    strt_chk_en = 'b0 ;
                    deser_en    = 'b0  ;
		    data_valid  = 'b0 ;
                  end    
              
       STOP    :  begin
                   stp_chk_en  = 'b1  ; 
                   samp_en     = 'b1 ;
                   deser_en    = 'b0  ; 
                   strt_chk_en = 'b0 ;
	           data_valid  = 'b0 ;
                  end   
              
       Valid   :  begin 
                   stp_chk_en  = 'b0  ; 
                   data_valid  = 'b1 ;
                  end
                  
       default  : begin
   
                    par_chk_en  = 'b0 ;
                    strt_chk_en = 'b0 ;
                    stp_chk_en  = 'b0 ;
                    deser_en    = 'b0 ;
                    samp_en     = 'b0 ;
                    data_valid  = 'b0 ;
                  end
   
   endcase
 end          
endmodule
  
  

