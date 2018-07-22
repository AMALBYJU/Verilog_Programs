// Verilog code that represents the communication between machine 1 and machine 2

/*string5 and string6 in gtkwave show no change as these are not the outputs of stimulus module but are rather the wires used to interconnect machine1 and machine2*/ 
`timescale 1ns / 1ps
module machine1(input string,output reg string2,input clock);

always @ *
 begin
 if(string)
  $display("Message received at Machine A from B = %d  timestamp = %d",string,$time);

 string2 <= 0;
 end
 always @(posedge clock)
  string2 <= 1;

 

endmodule

module machine2(input string,output reg string2,input clock);

always @ *
 begin
 if(string)
  $display("Message received at Machine B from A = %d  timestamp = %d",string,$time);
 
 string2 <= 0;
 end
 always @(posedge clock)
  string2 <= 1;

  

endmodule

module stimulus;

 wire string5;
 wire string6;
 reg clock;

 machine1 A(string5,string6,clock);
 machine2 B(string6,string5,clock);

 initial begin
 
  $dumpfile("p6_part1.vcd");
  $dumpvars(0,stimulus);
 $display("\nMessage printed by the receiving machine\n");
 
 #0 clock = 0;
 #10 clock = 1;
 #10 clock = 0;
 #10 clock = 1;
 #10 clock = 0; 
 #10 clock = 1;
 #10 clock = 0;
 #10 clock = 1;
 #10 clock = 0;

 end
 
 endmodule
 

  
