// Verilog code for full adder
module full_adder(input a,input b,input cin,output sum,output cout);

 wire p,q,r;
   xor(sum,a,b,cin);
   xor(p,a,b);
   and(q,a,b);
   and(r,p,cin);
   or(cout,q,r);


endmodule

`timescale 1ns / 1ps
module stimulus;

 reg a,b,cin;
 wire sum,cout;

 full_adder uut(a,b,cin,sum,cout);

 initial begin
  $dumpfile("p4.vcd");
  $dumpvars(0,stimulus);
  $display("A     B   CARRY IN   SUM   CARRY OUT\n");
 
  #0 a = 0;b = 0;cin = 0;
  #10 a = 0;b = 0;cin = 1;
  #10 a = 0;b = 1;cin = 0;
  #10 a = 0;b = 1;cin = 1;
  #10 a = 1;b = 0;cin = 0;
  #10 a = 1;b = 0;cin = 1;
  #10 a = 1;b = 1;cin = 0;
  #10 a = 1;b = 1;cin = 1;
  #10;

 end

 initial begin

   $monitor("%d     %d      %d       %d     %d\n",a,b,cin,sum,cout);

 end

endmodule
