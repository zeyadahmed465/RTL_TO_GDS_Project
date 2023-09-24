module SYS_CTRL #(parameter WIDTH = 8 , Addr_SIZE = 4) 
(
input  wire    [WIDTH-1:0]     RX_P_DATA     	     , 
input  wire 		       RX_D_VLD  	     ,		
input  wire 		       FIFO_FULL 	     ,
input  wire    [WIDTH*2-1:0]   ALU_OUT   	     ,
input  wire     	       OUT_Valid   	     ,
input  wire 		       Rd_D_Vld	     	     ,
input  wire    [WIDTH-1:0]     Rd_D            	     ,     
input  wire 		       CLK	     	     ,
input  wire 		       RST	     	     ,
output reg    [WIDTH-1:0]     WR_DATA	   	     , 
output reg		       WR_INC                ,
output reg                    ALU_EN		     ,
output reg    [3:0] 	       ALU_FUN		     ,
output reg    [WIDTH-1:0]     Wr_D		     ,
output reg    [Addr_SIZE-1:0] Addr		     ,
output reg    		       RdEn                  ,
output reg    		       CLK_EN                , //CLK_GATE_ENABLE
output reg    		       CLK_DIV_EN            , //CLK_GATE_ENABLE
output reg                    WrEn		     

);

// Values of Commands 

localparam [WIDTH - 1:0]      RF_Wr_CMD          = 'hAA ;
localparam [WIDTH - 1:0]      RF_Rd_CMD          = 'hBB ;
localparam [WIDTH - 1:0]      ALU_OPER_W_OP_CMD  = 'hCC ;
localparam [WIDTH - 1:0]      ALU_OPER_W_NOP_CMD = 'hDD ;

// STATES Gray encoding

localparam  [3:0]       IDLE              		= 4'b0000  ;
localparam  [3:0]       wait_Write_Addr   		= 4'b0001  ;
localparam  [3:0]       wait_Write_Data   		= 4'b0010  ;
localparam  [3:0]       wait_Read_Addr    		= 4'b0011  ;
localparam  [3:0]       wait_Rd_D_Vld    		= 4'b0100  ;
localparam  [3:0]       wait_Operand_A   		= 4'b0101  ;
localparam  [3:0]       wait_Operand_B   		= 4'b0110  ;
localparam  [3:0]       wait_ALU_FUN   	      	        = 4'b0111  ;
localparam  [3:0]       wait_ALU_Vld     	        = 4'b1000  ;
localparam  [3:0]       transmit_ALU_OUT_lower          = 4'b1001  ;
localparam  [3:0]       transmit_ALU_OUT_upper          = 4'b1010  ;

reg         [3:0]      current_state , next_state ;
                  
 
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
	IDLE : begin
	         if(RX_D_VLD)
		    begin
		     case(RX_P_DATA)
			 RF_Wr_CMD: begin
                            next_state = wait_Write_Addr;
                        end

                         RF_Rd_CMD: begin
                            next_state = wait_Read_Addr;
                        end

                         ALU_OPER_W_OP_CMD: begin
                            next_state = wait_Operand_A;
                        end

                         ALU_OPER_W_NOP_CMD: begin
                            next_state = wait_ALU_FUN;
                        end

                        default: begin
                            next_state = IDLE;
                        end
                    endcase
                end
       
                else begin
                    	next_state = IDLE;
                     end
            end   

        wait_Write_Addr : begin
			   if(RX_D_VLD)
                             begin
			        next_state = wait_Write_Data   ;
			     end
			   else
			     begin
				next_state = wait_Write_Addr ;
			     end
			  end

	wait_Write_Data : begin
			    if(RX_D_VLD)
                              begin
                                next_state = IDLE ;
			      end
                            else 
			      begin
				next_state = wait_Write_Data ;
			       end
			  end

       wait_Read_Addr  : begin
			   if(RX_D_VLD)
                             begin
			        next_state = wait_Rd_D_Vld ;
			     end
                           else 
		              begin
				next_state = wait_Read_Addr ;
			      end
			 end

       wait_Rd_D_Vld : begin
			     next_state = IDLE 	;
			end


       wait_Operand_A  : begin
			   if(RX_D_VLD)
                             begin
			        next_state = wait_Operand_B ;
			     end
                           else 
		              begin
				next_state = wait_Operand_A ;
			      end
			 end

       wait_Operand_B  : begin
			   if(RX_D_VLD)
                             begin
			        next_state = wait_ALU_FUN ;
			     end
                           else 
		              begin
				next_state = wait_Operand_B ;
			      end
			 end


       wait_ALU_FUN  : begin
			   if(RX_D_VLD)
                             begin
			        next_state = wait_ALU_Vld ;
			     end
                           else 
		              begin
				next_state = wait_ALU_FUN ;
			      end
			 end  
	

	
      wait_ALU_Vld : begin
	              if(OUT_Valid)
  			begin
			  next_state =  transmit_ALU_OUT_lower ;
	                end 
		      else 
			   next_state = wait_ALU_Vld;
                  end
      transmit_ALU_OUT_lower : begin
			 	      next_state = transmit_ALU_OUT_upper ;
				 end  
      transmit_ALU_OUT_upper : begin
                                   next_state = IDLE;
				end 
   default :begin
		next_state = IDLE;
	    end

  endcase
end

//output logic 
always@(*)
 begin 
	ALU_FUN    = 'b0;
        ALU_EN     = 'b0;
        CLK_EN     = 'b0;
        Addr       = 'b0;
        WrEn       = 'b0;
        Wr_D       = 'b0;
        RdEn       = 'b0;
	WR_DATA    = 'b0;
	CLK_DIV_EN = 'b1;
	WR_INC   = 'b0;
   case (current_state)

     IDLE : 
       begin
	ALU_FUN    = 'b0;
        ALU_EN     = 'b0;
        CLK_EN     = 'b0;
        Addr       = 'b0;
        WrEn      = 'b0;
        Wr_D       = 'b0;
        RdEn      = 'b0;
	WR_DATA    = 'b0;
	CLK_DIV_EN = 'b1;
	WR_INC   = 'b0;
       end  

   wait_Write_Addr :
	begin
	 WrEn   = 'b1;
	end

   wait_Write_Data :
	begin
	 WrEn    = 'b1;
	 Wr_D    = RX_P_DATA; 
	end

   wait_Read_Addr  :
        begin
	  RdEn = 'b1;
	  Addr  = RX_P_DATA[3:0] ;
	end

   wait_Rd_D_Vld   :
	begin
         if(Rd_D_Vld && !FIFO_FULL)
             begin
		  WR_DATA = Rd_D ;
		  WR_INC  = 'b1  ;
	     end
        else
             begin
		  WR_DATA = 'b0  ;
		  WR_INC  = 'b0  ;
	     end
       end
   wait_Operand_A   :
	begin
         if(RX_D_VLD)
             begin
	 	WrEn   = 'b1;
		Wr_D    = RX_P_DATA;
	     end
        else
             begin
	 	WrEn   = 'b0;
		Wr_D    = 'b0;
	     end
     end

   wait_Operand_B   :
	begin
         if(RX_D_VLD)
             begin
	 	WrEn   = 'b1;
		Wr_D    = RX_P_DATA;
	     end
        else
             begin
	 	WrEn   = 'b0;
		Wr_D    = 'b0;
	     end
	end

   wait_ALU_FUN   :
	begin
         if(RX_D_VLD)
             begin
	 	ALU_EN   = 'b1;
		ALU_FUN  = RX_P_DATA;
	     end
        else
             begin
	 	ALU_EN   = 'b0;
		ALU_FUN  = 'b0;
	     end
	end      


   wait_ALU_Vld   :
	begin
         if(OUT_Valid)
             begin
		WR_DATA = ALU_OUT[7:0] ;
	     end
        else
             begin
		WR_DATA = 'b0 ;
	     end
	end  

   transmit_ALU_OUT_lower :
	begin
          if(OUT_Valid)
             begin
		WR_INC = 'b1;
	     end
        else
             begin
		WR_INC = 'b0;
	     end
	end  

     transmit_ALU_OUT_upper :
	begin
          if(OUT_Valid)
             begin
		WR_DATA = ALU_OUT[15:8] ;
		WR_INC  = 'b1;
	     end
        else
             begin
		WR_DATA = 'b0;
		WR_INC  = 'b0;
	     end
	end  
  endcase
end  
endmodule

