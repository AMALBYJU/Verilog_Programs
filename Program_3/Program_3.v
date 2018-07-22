//Verilog code for half adder
module half_adder(input a,input b,output reg sum,output reg carry);

 always @ *
  begin 
   sum <= (a & ~b)|(~a & b);  
   carry <= (a & b);
  end

endmodule

`timescale 1ns / 1ps
module stimulus;

 reg a,b;
 wire sum,carry;

 half_adder uut(a,b,sum,carry);

 initial begin
  $dumpfile("p3.vcd");
  $dumpvars(0,stimulus);
  $display("A     B     SUM    CARRY\n");
 
  #0 a = 0;b = 0;
  #10 a = 0;b = 1;
  #10 a = 1;b = 0;
  #10 a = 1;b = 1;
  #10;

 end

 initial begin

   $monitor("%d     %d      %d       %d\n",a,b,sum,carry);

 end

endmodule

  
    
