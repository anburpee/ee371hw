/* Module for EE/CSE371 Homework 1 Problem 1.
 * A simple synchronous signal with a DFF and fullAdder.
 */
module hw1p1 (clk, reset, x, y, s);
	input logic clk, reset, x, y;
	output logic s;

// implementation with full adder
	logic q, c;

	// D-FF with input c
	always_ff @(posedge clk) begin
		if (reset)
			q <= 1'b0;
		else
			q <= c;
	end // always_ff

	fullAdder fa (.a(x), .b(y), .cin(q), .sum(s), .cout(c));


endmodule  // hw1p1