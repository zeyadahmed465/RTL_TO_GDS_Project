module data_sampling (
  input  wire          RX_IN            ,
  input  wire  [5:0]   Prescale         ,
  input  wire          enable           ,
  input  wire  [2:0]   edge_count       ,
  input  wire          CLK              ,
  input  wire          RST              ,
  output reg           sampled_bit      
  );

wire [2:0] half_minus_one;
wire [2:0] half_plus_one;
wire [2:0]     half;  
reg [2:0] sample_test;
  
always@(posedge CLK or  negedge RST)
 begin
   if(!RST)
     sample_test <= 'b0 ;
   else if(enable)
        begin
       if(edge_count == half)
         sample_test[0] <= RX_IN ;
       else if(edge_count == half_minus_one)
         sample_test[1] <= RX_IN ;
       else if(edge_count == half_plus_one)
         sample_test[2] <= RX_IN ;
       end
       
   else
     sample_test <= 3'b00;
 end


always@(*)
 begin
   if(sample_test[0] == sample_test[1])
         sampled_bit <= sample_test[0] ;
   else if(sample_test[1] == sample_test[2])
         sampled_bit <= sample_test[1] ;
    
   else begin
         sampled_bit <= 'b0 ;
       end
 end




assign half_minus_one = ((Prescale >> 1) -2) ;
assign half           = ((Prescale >> 1) -1) ;
assign half_plus_one  = (Prescale >> 1) ;
endmodule