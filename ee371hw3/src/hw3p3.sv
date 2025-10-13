/* Arbitrary ASM chart implementation to examine output timings */
// we need to implement the mealy/moore asm chart from the hw specs !
module hw3p3 (clk, reset, X, Ya, Yb, Yc, Z1, Z2);
	input logic clk, reset, X;
	output logic Ya, Yb, Yc, Z1, Z2;

	enum logic [1:0] {s0, s1, s2} states;
	states ps, ns;
	
	always_comb begin
		case (ps)

		s0: begin
			Ya = 1;
			Yb = 0;
			Yc = 0;
			if (X) begin
				ns = S1;
				Z1 = 0;
				Z2 = 0;
			end
			else begin
				ns = S0;
				Z1 = 0;
				Z2 = 0;
			end
		end
		s1: begin
			Ya = 0;
			Yb = 1;
			Yc = 0;
			if (X) begin
				ns = S2;
				Z1 = 0;
				Z2 = 0;
			end
			else begin
				ns = S0;
				Z1 = 0;
				Z2 = 0;
			end
		end
		s2: begin
			Ya = 0;
			Yb = 0;
			Yc = 1;
			if (X) begin
				ns = S2;
				Z1 = 0;
				Z2 = 1;
			end
			else begin
				ns = S0;
				Z1 = 1;
				Z2 = 0;
			end
		end
		endcase
	end

	always_ff @(posedge clk) begin
		if (reset) 
			ps <= s0;
		else 
			ps <= ns;
	end
	
endmodule  // hw3p3
