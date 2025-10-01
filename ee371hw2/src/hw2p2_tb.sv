/* Testbench for Homework 1 Problem 2 */
module hw2p2_tb();
	logic clk, reset, in, out;

	// instantiate hw2p2
	hw2p2 dut (.*);

	initial begin
									@(posedge clk);
		reset <= 1;					@(posedge clk); // -> s0

		reset <= 0;	in <= 0;		@(posedge clk); // -> s3  out = 0
					in <= 0;		@(posedge clk); // -> s1  out = 0
					in <= 0;		@(posedge clk); // -> s1  out = 0
					in <= 1;		@(posedge clk); // -> s4  out = 1
					in <= 1;		@(posedge clk); // -> s3  out = 0
					in <= 1;		@(posedge clk); // -> s2  out = 1
					in <= 0;		@(posedge clk); // -> s2  out = 0
					in <= 1;		@(posedge clk); // -> s0  out = 1
					in <= 1;		@(posedge clk); // -> s4  out = 1
					in <= 0;		@(posedge clk); // -> s2  out = 0
									@(posedge clk);

		$stop; // end simulation
	end  // initial
	
endmodule  // hw1p2_tb
