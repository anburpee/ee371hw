/* FIFO buffer FWFT implementation for specified data and address
 * bus widths based on internal register file and FIFO controller.
 * Inputs: 1-bit rd removes head of buffer and 1-bit wr writes
 * w_data to the tail of the buffer.
 * Outputs: 1-bit empty, one_left, and full indicate the status of the buffer
 * and r_data holds the value of the head of the buffer (unless empty).
 */

module fifo #(parameter DATA_WIDTH=8, ADDR_WIDTH=4)
            (clk, reset, rd, wr, empty, full, one_left, w_data, r_data);
			 //, w_addr0, w_addr1, r_addr); // for simulation

	input  logic clk, reset, rd, wr;
	output logic empty, full, one_left;
	input  logic [2*DATA_WIDTH-1:0] w_data; // multiplied bit width by 2
	output logic [DATA_WIDTH-1:0] r_data;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] w_addr0, w_addr1, r_addr; // split up w_addr
	//output logic [ADDR_WIDTH-1:0] w_addr0, w_addr1, r_addr; // for simulation
	logic w_en;
	
	// enable write only when (wr is high and)FIFO is:
	// 1) one empty address left AND reading (can only write if also reading)
	// 2) not full AND not one empty addresses left (at least 2 left--can write without reading)
	assign w_en = wr & ((one_left & rd) | (~full & ~one_left)); // changed logic from wr & (~full | rd)
	
	// instantiate FIFO controller and register file
	fifo_ctrl #(ADDR_WIDTH) c_unit (.*);
	reg_file #(DATA_WIDTH, ADDR_WIDTH) r_unit (.*);
	
endmodule  // fifo