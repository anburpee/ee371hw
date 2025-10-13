/* Testbench for Homework 3 Problem 1 */
module fifo_tb ();
	logic clk, reset, rd, wr;
	logic empty, full, one_left;
	logic [2*8-1:0] w_data; // set DATA_WIDTH to 8 for testbench
	logic [8-1:0] r_data;
	logic [4-1:0] w_addr0, w_addr1, r_addr;

	// instantiace fifo
	// DATA_WIDTH=8, ADDR_WIDTH=4 (16 different addresses) -- default
	fifo dut (.*);

	// set up clock
	parameter period = 100;
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end // initial clock

	// test the device
	integer i;
	initial begin
		reset <= 1'b1; 		@(posedge clk);
		reset <= 1'b0;		@(posedge clk);

		// read & write when empty
		wr <= 1'b1;		rd <= 1'b1; 	w_data <= 16'b1111111100000000; 	@(posedge clk);
		// read to make fifo buffer empty
						rd <= 1'b0;											@(posedge clk); 
						rd <= 1'b1;											@(posedge clk); // empty = 1
		
		reset <= 1'b1; 		@(posedge clk);
		reset <= 1'b0;		
		wr <= 1'b1;		rd <= 1'b0;		
		$display("------------wr = high, rd = low-----------");
		// write only until make buffer is full
		// should see on_left go high before full goes high
		for (i = 0; i < 8; i++) begin	// loop 8 times since w_data takes up two addresses
			w_data <= 16'b1111111100000000; 	@(posedge clk);
			$display("wr_addr0: %d  wr_addr1: %d rd_addr: %d  w_data: %b  r_data: %b  empty: %b  full: %b, one_left: %b",
					 w_addr0, w_addr1, r_addr, w_data, r_data, empty, full, one_left);
		end
		// one more clock edge to update signals
		wr <= 1'b0; 	@(posedge clk);
		$display("wr_addr0: %d  wr_addr1: %d rd_addr: %d  w_data: %b  r_data: %b  empty: %b  full: %b, one_left: %b",
					 w_addr0, w_addr1, r_addr, w_data, r_data, empty, full, one_left);

		//see what's store in register file
		$display("Array contents:");
		for (i = 0; i < 16; i++) begin
		// used ChatGPT to debug --- told me i needed to have dut.r_unit before array_reg[i]
			$display("%b", dut.r_unit.array_reg[i]); 
		end

		// now read out all the data
		// should see one_left after reading from the first address
		// should see empty go high after reading out all the data
		rd <= 1'b0;
		$display("------------wr = low, rd = toggling-----------");
		for (i = 0; i < 16; i++) begin
			rd <= 1'b1; @(posedge clk);
			rd <= 1'b0; @(posedge clk);
			$display("wr_addr0: %d  wr_addr1: %d rd_addr: %d  w_data: %b  r_data: %b  empty: %b  full: %b, one_left: %b",
					 w_addr0, w_addr1, r_addr, w_data, r_data, empty, full, one_left);
		end
		
		// see what's store in register file
		$display("Array contents:");
		for (i = 0; i < 16; i++) begin
		// used ChatGPT to debug --- told me i needed to have dut.r_unit before array_reg[i]
			$display("%b", dut.r_unit.array_reg[i]); 
		end

		// test that you can write & read when one_left

		// test that you CAN'T only write when one_left

		// test that you can't write & read OR write only when full 


		
		$stop; // stop simultion
	end  // initial
	
endmodule  // fifo_tb
