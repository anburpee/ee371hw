/* Testbench for Homework 3 Problem 3 */
module hw3p3_tb ();
	
	logic clk, reset, X;
	logic Ya, Yb, Yc, Z1, Z2;
	
	hw3p3 dut (.*);

	// set up simulation clock
	parameter clk_period = 100;
	initial begin
		clk = 0;
		forever #(clk_period/2) clk = ~clk;
	end
	
	// test the design
	initial begin
		
		reset = 1; @(posedge clk); // S0
		reset = 0; @(posedge clk);

		X = 1; @(posedge clk); // S1
		X = 1; @(posedge clk); // S2
		X = 1; @(posedge clk); // S2, Z2
		X = 0; @(posedge clk); // S0, Z1
		X = 0; @(posedge clk); // S0
		X = 1; @(posedge clk); // S1
		X = 0; @(posedge clk); // S0
		
		$stop; // stop simulation
	end  // initial
	
endmodule  // hw3p3_tb
