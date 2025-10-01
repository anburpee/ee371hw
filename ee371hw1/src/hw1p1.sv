/* Module for EE/CSE371 Homework 1 Problem 1.
 * A simple synchronous signal with a DFF and fullAdder.
 */
module hw1p1 (clk, reset, x, y, s);
	input logic clk, reset, x, y;
	output logic s;

// 	// states
// 	enum {s0, s1} ps, ns; // ps = Q, ns = C

// 	// next state logic
// 	always_comb begin
// 		case(ps)

// 			s0:		ns = x & y ? s1 : s0;

// 			s1: 	ns = ~(x & y) ? s0 : s1;

// 		endcase
// 	end // always_comb


// 	// state update logic
	// always_ff @(posedge clk) begin
// 		if (reset)
// 			ps <= s0;
// 		else
// 			ps <= ns;
// 	end // always_ff


//	// output logic
// 	assign s = (((ps == s0) & (x ^ y)) | ((ps == s1) & ~(x ^ y)))


// endmodule  // hw1p1


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