/*
A hello world message is printed out by a module periodically. The module prints the current timestamp (in clock cycles). Module terminates after 100 clock cycles.
Name: Amal Byju
Roll Number: 16CO205
Date: 01/08/2017
*/
`timescale 1ns / 1ps
module hello_world;

 reg clock;
 integer i;  

 initial begin
 
  $dumpfile("p1.vcd");
  $dumpvars(0,hello_world);
  
  #0 clock = 0;i = 0;
   
  repeat(100)
   begin
    #10 clock = ~clock; 
    #10 clock = ~clock;i = i+1;
    $display("Hello World   Current Timestamp: %d\n",i);
   end
 end
endmodule 
