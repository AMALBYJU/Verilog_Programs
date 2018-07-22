// Verilog code for SR flip flop
module sr(input s,input r,output q,output _q);
	assign _q=~(q|s);
	assign q=~(_q|r);
endmodule

module dlatch(input clk,input d,output q,output _q);
	sr s1(d&clk,~d&clk,q,_q);
	
endmodule
	
	
module dflip(input d,input clk,output q,output _q);
	wire temp;
	dlatch d1(~clk,d,temp,);
	dlatch d2(clk,temp,q,_q);
	
	
endmodule

`timescale 1ns/1ps
module stimulus;
	reg d;
	reg clk;
	wire q;
	wire _q;
	dflip uut(d,clk,q,_q);
	initial 
		begin
			$dumpfile("p7.vcd");
			$dumpvars(0,stimulus);
			d=0;
			#8 d=1;
			#12 d=0;
			#14 d=0;
			#10 d=1;
			#40;
		end
	integer i;
	initial
		begin
			clk=0;
			for(i=0;i<8;i=i+1)
				#10 clk=~clk;
		end
	initial
		begin
			#10;
			$monitor("d: %b, q: %b ,clock: %d",d,q,clk);
		end
	
	
	
	
	
		
		
endmodule

			
			
			
			
			
			
			
