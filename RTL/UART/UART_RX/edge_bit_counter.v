module edge_bit_counter (
  input  wire enable        ,
  input  wire CLK           ,
  input  wire RST           ,
  output reg [3:0] bit_cnt  ,
  output reg [2:0] edge_cnt 
  );
  
wire edge_cnt_max ;
wire bit_cnt_max  ;
always@(posedge CLK or negedge RST)
 begin
  if(!RST)
    begin
      bit_cnt <= 'b0 ;
      edge_cnt <= 'b0 ;
    end
  else if(enable)
   begin
    if(!edge_cnt_max)
      edge_cnt <= edge_cnt + 1 ;
    else if(!bit_cnt_max && edge_cnt_max)
     begin
      bit_cnt  <= bit_cnt + 1  ;
      edge_cnt <= 'b0 ;
     end
    else
      bit_cnt  <= 'b0  ;
   end
   
  
 end  
assign edge_cnt_max = (edge_cnt == 'b111)?1:0  ;
assign bit_cnt_max  = (bit_cnt  == 'b1011)?1:0  ;
 
endmodule
