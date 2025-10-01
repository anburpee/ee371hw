/* Testbench for Homework 1 Problem 1 */
module hw1p1_tb();
	logic clk, reset, x, y, s;

	// instantiate hw2p1
	hw1p1 dut (.*);

	// clock period
	parameter period = 100;

	// set up clock
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end // initial clock

	// test the design
	integer i;
	initial begin
										@(posedge clk);
		reset <= 1;						@(posedge clk); // -> s0
					// test inputs from s0
		reset <= 0;	x <= 0; y <= 0;		@(posedge clk); // -> s0  s = 0
					x <= 0; y <= 1;		@(posedge clk); // -> s0, s = 1
					x <= 1; y <= 0;		@(posedge clk); // -> s0, s = 1
					x <= 1; y <= 1;		@(posedge clk); // -> s1, s = 0

					// currently in s1
					// test inputs from s1
					x <= 1; y <= 1;		@(posedge clk); // -> s1, s = 1
					x <= 0; y <= 1;		@(posedge clk); // -> s1, s = 0
					x <= 1; y <= 0;		@(posedge clk); // -> s1, s = 0
					x <= 0; y <= 0;		@(posedge clk); // -> s0, s = 1
										@(posedge clk); // s0
		$stop; // stop simulation
	end  // initial signals
	
endmodule  // hw1p1_tb
