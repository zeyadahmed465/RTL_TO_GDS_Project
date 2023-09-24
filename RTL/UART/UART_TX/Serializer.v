module Serializer (
 input wire [7:0] P_DATA       ,
 input wire       Data_Valid   ,
 input wire       busy         ,
 input wire       ser_en       , 
 input wire       CLK          ,
 input wire       RST          ,
 output reg       ser_data     ,
 output wire      ser_done
);

reg [7:0] temp_data ;
reg [3:0] count     ;



always@(posedge CLK or negedge RST)
 begin
   if(!RST)
      begin 
        temp_data <= 8'b0 ;
        ser_data  <= 1'b0 ;
      end
 else if (Data_Valid && !busy) 
        begin    // load in_data into temp_data 
            temp_data <= P_DATA ;
            ser_data  <= 1'b0   ;
        end
 else if(ser_en && !ser_done) // enables the shift register
           begin
            {temp_data,ser_data} <= {1'b0, temp_data} ;
           end
 end
 
 // counter to count the output bits to high ser_done flag after finish   
     always@(posedge CLK or negedge RST)
       begin
          if(!RST)
            count <= 4'b0 ;
          else if (!ser_en)
            count <= 4'b0 ;				
          else if (ser_en && !ser_done)
            count <= count + 4'b1 ;				  
       end
    
 /////////////////////////////
 
assign ser_done = (count == 'b1000) ? 1'b1 : 1'b0 ;
   
   
endmodule