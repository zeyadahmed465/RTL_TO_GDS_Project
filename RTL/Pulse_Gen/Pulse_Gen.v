module Pulse_Gen (
input wire CLK,
input wire RST,
input wire en_sig,
output wire Pulse_en
);
reg meta_flop ;
reg sync_flop ;

always@(posedge CLK or negedge RST)
 begin
   if(!RST)
     begin
	meta_flop <= 'b0 ;
	sync_flop <= 'b0 ;
     end
   else
     begin
       meta_flop <= en_sig   ;
       sync_flop <= meta_flop;
     end
 end

assign Pulse_en = meta_flop && !sync_flop ;

endmodule

