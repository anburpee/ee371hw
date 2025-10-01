/* Module for EE/CSE371 Homework 1 Problem 1.
 * A simple synchronous signal with a DFF and fullAdder.
 */
module hw1p1 (clk, reset, x, y, s);
	input logic clock, reset, x, y;
	output logic s;

	// states
	enum {s0, s1} ps, ns;

	// next state logic
	always_comb begin
		case(ps)

			s0:		x & y ? ns = s1 : ns = s0;

			s1: 	~(x & y) ? ns = s0 : ns = s1;

		endcase
	end // always_comb


	// state update logic
	always_ff @(posedge clk) begin
		if (reset)
			ps <= s0;
		else
			ps <= ns;
	end // always_ff


	// output logic
	assign s = (((ps == s0) & (x ^ y)) | ((ps == s1) & ~(x ^ y)))


endmodule  // hw1p1
