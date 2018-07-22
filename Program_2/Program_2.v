// Verilog code for encoder and decoder - 16 bit input,4 bit output encoder / 4 bit input, 16 bit output decoder
module decoder(input [4:1]x,output reg[15:0]y);
 
always @ *
 case(x)
 
 0:  y = 1;
 1:  y = 2;
 2:  y = 4;
 3:  y = 8;
 4:  y = 16;
 5:  y = 32;
 6:  y = 64;
 7:  y = 128;
 8:  y = 256;
 9:  y = 512;
 10:  y = 1024;
 11:  y = 2048;
 12:  y = 4096;
 13:  y = 8192;
 14:  y = 16384;
 15:  y = 32768;
 
 endcase
endmodule

module encoder(input [15:0]x,output reg[4:1]y);

always @ * 
 case(x)

 1:  y = 0;
 2:  y = 1;
 4:  y = 2;
 8:  y = 3;
 16:  y = 4;
 32:  y = 5;
 64:  y = 6;
 128:  y = 7;
 256:  y = 8;
 512:  y = 9;
 1024:  y = 10;
 2048:  y = 11;
 4096:  y = 12;
 8192:  y = 13;
 16384:  y = 14;
 32768:  y = 15;

 endcase
endmodule

`timescale 1ns / 1ps 
module stimulus;

 reg [4:1]x;
 reg [15:0]y;
 wire [4:1]p;
 wire [15:0]q;

 encoder uut1(y,p);
 decoder uut2(x,q);

 initial begin
 
  $dumpfile("p2.vcd");
  $dumpvars(0,stimulus); 
   $display("    Encoder \n");
   $display("Input                Encoded data\n"); 
      
 
  #0 y = 1;

  repeat(16)
   begin
     #10 $display("%16b     %4b\n",y,p); 
     y = y*2;
   end
  
  $display("\n   Decoder  \n");
  $display("Encoded data          Output\n");
  
  #0 x = 0;


  repeat(16)
   begin 
    #10 $display("%4b      %16b\n",x,q);
    x = x+1;
   end
 end
endmodule
      

 
   
 
 
