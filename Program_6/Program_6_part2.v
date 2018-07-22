`timescale 1ns / 1ps
module machineA(input [3:0]msg,output reg msg1,input send,input clock);

 always @ *
  begin
   if(msg[3] == 1)
    $display("           Received reply from machine B     %d\n",$time);
   if(msg[2] == 1)
    $display("           Received reply from machine B     %d\n",$time);
   if(msg[1] == 1)
    $display("           Received reply from machine B     %d\n",$time);
   if(msg[0] == 1)
    $display("           Received reply from machine B     %d\n",$time);
   msg1 <= 0;
   
  end
  
  always @(posedge send)
   begin
     msg1 <= 1;
     $display("%d          Sent message to machine B         %d\n",send,$time);
   end

 always @(posedge clock or negedge clock)
 begin
  if(msg1 != 1)
   $display("0                                            %d\n",$time);
   
 end
    
endmodule

module machineB(input msg,output reg [3:0]msg1);

 always @ *
  begin
   if(msg)
    msg1 <= 15;
   else
    msg1 <= 0;
  end

endmodule

`timescale 1ns / 1ps
module stimulus;

reg send;
reg clock;
wire [3:0]msg;
wire msg1;

 machineA uut(msg,msg1,send,clock);
 machineB uut1(msg1,msg);
 
initial begin
 
 $dumpfile("p6_part2.vcd");
  $dumpvars(0,stimulus); 
 $display("Send signal      Output from machine A                Time(in ns)\n");  

 #0 send = 0;
 #10 send = 1;
 #20 send = 1;
 #10 send = 0;
 #10;
 #10 send = 1;
 #10 send = 0;
 
end

initial begin
 clock = 0;
 repeat(7)
  #10 clock = ~clock;
 end

endmodule     

     
