// Verilog code for n-bit adder
module full_adder(input a,input b,input cin,output reg sum,output reg cout);

 always @ *
  begin 
   sum <= a^b^cin;
   cout <= (a & b)|(b & cin)|(cin & a);
  end

endmodule


module nbitadder(input [7:0]in1,input [7:0]in2,input [32:1]n,input m,output [7:0]out,output reg overflow);
 
 wire [7:0] cout;
 reg [7:0]in22;
 
 parameter N = 7;
 
 full_adder uut1(in1[0],in2[0],m,out[0],cout[0]);
 
 genvar i;
 generate
  
  for(i = 1;i<=7;i = i+1)
   begin: generate_block
     full_adder uut2(in1[i],in2[i],cout[i-1],out[i],cout[i]);
   end
 endgenerate
 
 always @ * 
  begin
   in22[0] <= in2[0] ^ m;  
   in22[1] <= in2[1] ^ m; 
   in22[2] <= in2[2] ^ m; 
   in22[3] <= in2[3] ^ m; 
   in22[4] <= in2[4] ^ m; 
   in22[5] <= in2[5] ^ m; 
   in22[6] <= in2[6] ^ m; 
   in22[7] <= in2[7] ^ m; 
   if(m == 0)
      overflow <= (in1[n-1] & in2[n-1] & ~out[n-1]) | (~in1[n-1] & ~in2[n-1] & out[n-1]);
   else
      overflow <= (~in1[n-1] & in2[n-1] & out[n-1]) | (in1[n-1] & ~in2[n-1] & ~out[n-1]); 
  end
endmodule

`timescale 1ns / 1ps
module stimulus;


 reg m;
 wire [7:0]out;
 wire overflow;
 reg [7:0]in1;
 reg [7:0]in2;
 integer n;

 nbitadder uut(in1,in2,n,m,out,overflow);

 initial begin
 
  $dumpfile("p5.vcd");
  $dumpvars(0,stimulus);

  $display("\nADDITION\n");
  $display("\nInput 1   Input 2             n  Add/Sub    Output  Overflow\n");
  #0   
     n = 1;
     in1 = 0;
     in2 = 1;
     m = 0;
  #10 $display("%1b  %1b  %d     %d     %1b             %d",in1,in2,n,m,out[0],overflow);    
     
     n = 2;
     in1 = 2;
     in2 = 1;
     m = 0;
   #10 $display("%1b  %1b  %d     %d     %1b            %d",in1,in2,n,m,out[1:0],overflow);
     
     n = 3;
     in1 = 4;
     in2 = 4;
     m = 0;
    #10 $display("%1b  %1b  %d     %d     %1b           %d",in1,in2,n,m,out[2:0],overflow);
     
     n = 4;
     in1 = 1;
     in2 = 7;
     m = 0;
    #10 $display("%1b  %1b  %d     %d     %1b          %d",in1,in2,n,m,out[3:0],overflow);
    
     n = 5;
     in1 = 16;
     in2 = 14;
     m = 0;
  #10 $display("%1b  %1b  %d     %d     %1b         %d",in1,in2,n,m,out[4:0],overflow);
    
     n = 6;
     in1 = 54;
     in2 = 20;
     m = 0;
   #10 $display("%1b  %1b  %d     %d     %1b        %d",in1,in2,n,m,out[5:0],overflow);
    
     n = 7;
     in1 = 45;
     in2 = 45;
     m = 0;
    #10 $display("%1b  %1b  %d     %d     %1b       %d",in1,in2,n,m,out[6:0],overflow);
    
     n = 8;
     in1 = 124;
     in2 = 200;
     m = 0;
    #10 $display("%1b  %1b  %d     %d     %1b      %d",in1,in2,n,m,out[7:0],overflow);
 
    $display("\n\nSUBTRACTION\n");
  $display("\nInput 1   Input 2             n  Add/Sub    Output  Overflow\n");
  #0  
     n = 1;
     in1 = 0;
     in2 = 1;
     m = 1;
  #10 $display("%1b  %1b  %d     %d     %1b             %d",in1,in2,n,m,out[0],overflow);    
    
     n = 2;
     in1 = 2;
     in2 = 1;
     m = 1;
   #10 $display("%1b  %1b  %d     %d     %1b            %d",in1,in2,n,m,out[1:0],overflow);
    
     n = 3;
     in1 = 4;
     in2 = 4;
     m = 1;
    #10 $display("%1b  %1b  %d     %d     %1b           %d",in1,in2,n,m,out[2:0],overflow);
    
     n = 4;
     in1 = 1;
     in2 = 7;
     m = 1;
    #10 $display("%1b  %1b  %d     %d     %1b          %d",in1,in2,n,m,out[3:0],overflow);
    
     n = 5;
     in1 = 16;
     in2 = 14;
     m = 1;
  #10 $display("%1b  %1b  %d     %d     %1b         %d",in1,in2,n,m,out[4:0],overflow);
    
     n = 6;
     in1 = 54;
     in2 = 20;
     m = 1;
   #10 $display("%1b  %1b  %d     %d     %1b        %d",in1,in2,n,m,out[5:0],overflow);
   
     n = 7;
     in1 = 45;
     in2 = 45;
     m = 1;
    #10 $display("%1b  %1b  %d     %d     %1b       %d",in1,in2,n,m,out[6:0],overflow);
   
     n = 8;
     in1 = 124;
     in2 = 200;
     m = 1;
    #10 $display("%1b  %1b  %d     %d     %1b      %d",in1,in2,n,m,out[7:0],overflow);
   
  
 end

endmodule    
   
