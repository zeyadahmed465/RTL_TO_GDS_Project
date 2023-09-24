module mux_4_1 (
input wire A              ,
input wire B              ,
input wire C              ,
input wire D              ,
input wire [1:0] sel      ,
output reg out      
);

always@(*)
 begin
   case(sel) 
        2'b00 : begin                 
	                 out <=  A ;       
	              end
        	2'b01 : begin
	                 out <= B ;      
	               end	
	       2'b10 : begin
	                 out <= C ;       
	               end	
	       2'b11 : begin
	                 out <= D ;      
	               end		
	 endcase   
 end 
endmodule
