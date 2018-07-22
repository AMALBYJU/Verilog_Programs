// Verilog code to simulate a register
module sr_schematic(input s,input r,output reg q,output reg _q);

initial begin
 q <= 0;
 _q <= 1;

end

always @ *
begin
 q <= _q ~| r;
 _q <= q ~| s;
end

endmodule

module d_latch(input d,input clk,output q,output _q);

 reg r,s;
 sr_schematic inst1(s,r,q,_q);
 
 always @ *
 begin
  r <= clk & ~d;
  s <= clk & d;
 end
 
endmodule

module dflipflop(input d,input clk,output q);
 
 wire tempq,temp_q;

 d_latch inst3(d,clk,tempq,temp_q);
 d_latch inst4(tempq,~clk,q,_q);
 
endmodule
                                                  
module register(input [31:0]in1,output reg[31:0]out1,input clk,input reset,input read,input write);

 reg [31:0]in;
 wire [31:0]out;

  always @ (posedge clk)
   begin 
   if(write == 1)
    begin 
     out1 <= 32'b0;
     in <= in1;
    end
   else if(read == 1)
     out1 <= out;
   end 
  always @(reset == 1) 
  begin
    in <= 0;
  end
 
 genvar i;
 parameter N = 32;      
 generate
  
  for(i = 0;i<N;i = i+1)
    begin: generate_block                                              
     dflipflop dff(in[i],clk,out[i]);
    end
 endgenerate
 
endmodule

`timescale 1ns / 1ps
module stimulus;
 
 reg [31:0]in;
 wire [31:0]out;
 reg clock;
 reg reset;
 reg read;
 reg write;

 register uut(in,out,clock,reset,read,write);

 initial begin
  
  $dumpfile("p8.vcd");
  $dumpvars(0,stimulus);
  $display("Clock   Read  Write  Reset            Register input               Register output\n");
 
 #0 clock = 0;reset = 1;read = 0;write = 1;in = 34000;
 #10 clock = 1;in = 64;reset = 0;write = 0;read = 1;
 #10 clock = 0;in = 20000;write = 1;read = 0;
 #10 clock = 1;read = 1;write = 0;
 #10 clock = 0;in = 3237;
 #10 clock = 1;
 #10 clock = 0;in = 5210;read = 0;write = 1;
 #10 clock = 1;
 #10 clock = 0;
 #10 clock = 1;in = 21393;read = 1;write = 0;
 #10 clock = 0;
 #10 clock = 1;read = 0;write = 1;
 #10 clock = 0;
 #10 clock = 1;read = 1;write = 0;
 

 end

 initial begin
 
  $monitor("%d       %d      %d      %d   %32b     %32b\n",clock,read,write,reset,in,out);
 
 end

endmodule
