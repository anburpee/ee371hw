/* Module for EE/CSE371 Homework 1 Problem 2.
 * An arbitrary Mealy FSM.
 */
module hw1p2 (clk, reset, in, out);
	input logic clk, reset, in;
	output logic out;

	// states
	typedef enum logic [2:0] {s0, s1, s2, s3, s4} states;

	states ps, ns;


	// next state and output logic
	always_comb begin

		// default output--true except transition from s4>>s3 and input=1
		out = in; 

		case (ps)

			s0:	
				ns = in ? s4 : s3;

			s1:  	
				ns = in ? s4 : s1;

			s2:	
				ns = in ? s0 : s2;

			s3:	
				ns = in ? s2 : s1; 

			s4:	begin
				ns = in ? s3 : s2;
				out = 1'b0;
			end // s4

		endcase
	end // always_comb


	// state update logic
	always_ff @(posedge clk) begin
		if (reset)
			ps <= s0;
		else
			ps <= ns;
	end


endmodule  // hw1p2
