module stop_check #(parameter DATA_WIDTH = 8) (
  input   wire                  sampled_bit  ,
  input   wire                  enable       ,
  input   wire                  CLK          ,
  input   wire                  RST          ,
  output  reg                  stp_err 
  );
  
always@(posedge CLK or negedge RST)
 begin 
   if(!RST)
     begin
       stp_err <= 0;
     end
   else if(enable)
     begin
       if(sampled_bit == 'b1)
         stp_err <= 'b0;
       else
         stp_err <= 'b1;
     end
 end 
  
endmodule 
  
  
