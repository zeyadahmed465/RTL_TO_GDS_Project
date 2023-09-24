module strt_check (
  input  wire enable      ,
  input  wire sampled_bit ,
  input  wire CLK         ,
  input  wire RST         ,
  output reg strt_glitch
  );
  
always@(posedge CLK or negedge RST)
 begin
  if(!RST)
    strt_glitch <= 'b0 ;
  else if(enable)
    begin
      if(sampled_bit == 'b0)
        strt_glitch <= 'b0  ;
      else
        strt_glitch <= 'b1  ;
    end  
 end   
  
  
endmodule