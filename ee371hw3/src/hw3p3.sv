/* Arbitrary ASM chart implementation to examine output timings */
// we need to implement the mealy/moore asm chart from the hw specs!
// all inputs and outputs are 1 bit
module hw3p3 (clk, reset, X, Ya, Yb, Yc, Z1, Z2);
	input logic clk, reset, X;
	output logic Ya, Yb, Yc, Z1, Z2;

	enum {s0, s1, s2} ps, ns;
	
	// next state & output logic
	always_comb begin
		case (ps)
			s0: begin
				Ya = 1;
				Yb = 0;
				Yc = 0;
				if (X) begin
					ns = s1;
					Z1 = 0;
					Z2 = 0;
				end
				else begin
					ns = s0;
					Z1 = 0;
					Z2 = 0;
				end
			end
			s1: begin
				Ya = 0;
				Yb = 1;
				Yc = 0;
				if (X) begin
					ns = s2;
					Z1 = 0;
					Z2 = 0;
				end
				else begin
					ns = s0;
					Z1 = 0;
					Z2 = 0;
				end
			end
			s2: begin
				Ya = 0;
				Yb = 0;
				Yc = 1;
				if (X) begin
					ns = s2;
					Z1 = 0;
					Z2 = 1;
				end
				else begin
					ns = s0;
					Z1 = 1;
					Z2 = 0;
				end
			end
			default: begin
				Ya = 0;
				Yb = 0;
				Yc = 0;
				if (X) begin
					ns = s0;
					Z1 = 0;
					Z2 = 0;
				end
				else begin
					ns = s0;
					Z1 = 0;
					Z2 = 0;
				end
			end
		endcase
	end // always_comb

	// state update logic
	always_ff @(posedge clk) begin
		if (reset) 
			ps <= s0;
		else 
			ps <= ns;
	end // always_ff
	
endmodule  // hw3p3
