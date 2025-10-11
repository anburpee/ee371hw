/* Testbench for Homework 2 Problem 3 */
module sign_mag_add_tb ();
	parameter N = 4;
	logic clk; // input to sync_rom
	logic [N-1:0] a, b; // input to sign_mag_add
	logic [7:0] addr;	// input to sync_rom
	logic [N-1:0] sum;   // for the output of sign_mag_add - do not rename
	logic [3:0] data;  // for the output of sync_rom - do not rename

	// for you to implement BOTH sign_mag_add and sync_rom
	sign_mag_add dut1 (.a(a), .b(b), .sum(sum));
	sync_rom dut2 (.clk(clk), .addr(addr), .data(data));

	parameter period = 10;

	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end // initial clk

	integer i, j;
	initial begin
		
		for (i = 0; i < 16; i++) begin // input "a" loops through 0-16
			a <= i; #10;
			for (j = 0; j < 16; j++) begin // input "b" loops through 0-16
				b <= j; #10;
				$display("a: %b  b: %b  sum: %b", a, b, sum);
			end
		end

		for (i = 0; i < 2**7; i++) begin
			addr <= i;
			$display("addr %b  data: %b", addr, data);
		end


		// $display("-------------------- SOME NUMBER + 0--------------------");
		// b <= 1'b0;
		// for (i = 0; i < 16; i++) begin
		// 	a <= i;
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- POS + NEG = 0 --------------------");
		// // same magnitude, different signs
		// for (i = 0; i < 8; i++) begin
		// 	a <= i; // positive
		// 	b <= i + 8; // negative
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- POS + NEG > 0 --------------------");
		// // same magnitude, different signs
		// for (i = 0; i < 7; i++) begin
		// 	a <= i + 1; // positive (Greater than negative value)
		// 	b <= i + 8;//  negative
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- POS + NEG < 0 --------------------");
		// // same magnitude, different signs
		// for (i = 0; i < 7; i++) begin
		// 	a <= i; // positive
		// 	b <= i + 9; // negative (greater than positive value)
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- POS + POS (VALID) --------------------");
		// for (i = 0; i < 4; i++) begin
		// 	a <= i; // positive
		// 	b <= i; // positive
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- POS + POS (OVERFLOW)  --------------------");
		// for (i = 0; i < 4; i++) begin
		// 	a <= i + 4; // positive
		// 	b <= i + 4; // positive
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- NEG + NEG  (VALID)--------------------");
		// for (i = 0; i < 4; i++) begin
		// 	a <= i + 8; // negative
		// 	b <= i + 8; // negative
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		// $display("-------------------- NEG + NEG  (OVERFLOW)--------------------");
		// for (i = 0; i < 4; i++) begin
		// 	a <= i + 12; // negative
		// 	b <= i + 12; // negative
		// 	#10;
		// 	$display("a: %b  b: %b  sum: %b", a, b, sum);
		// end

		$stop; // stop simulation
	end  // initial
	
endmodule  // sign_mag_add_tb