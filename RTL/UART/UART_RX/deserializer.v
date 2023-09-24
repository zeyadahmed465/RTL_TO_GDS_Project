module deserializer #(parameter DATA_WIDTH = 8) ( 
  input   wire        sampled_bit  ,
  input   wire  [2:0] edge_cnt     ,
  input   wire        enable       ,
  input   wire        CLK          ,
  input   wire         RST          ,
  output  reg  [DATA_WIDTH -1:0] P_DATA
  );
 
  
 reg [2:0] cnt  ;

  
  
always@(posedge CLK or negedge RST)
 begin
   if(!RST)
     begin
        P_DATA <= 'b0 ;
        cnt    <= 'b0 ;
     end
   else if(enable && edge_cnt =='d6)
     begin
         P_DATA[cnt] <= sampled_bit;
         cnt <= cnt + 1    ;
       end
   
     

 end

endmodule