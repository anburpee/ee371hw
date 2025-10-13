/* Register file module for specified data and address bus widths.
 * Asynchronous read port (r_addr -> r_data) and synchronous write
 * port (w_data -> w_addr if w_en).
 */

 // DATA_WIDTH is the number of bits read out at a time;
 // the actual width of the data written in is 2*DATA_WIDTH
module reg_file #(parameter DATA_WIDTH=8, ADDR_WIDTH=2) // change default ADDR_WIDTH to 4 to match other files?
                (clk, w_data, w_en, w_addr, r_addr, r_data);

	input  logic clk, w_en;
	input  logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	input  logic [2*DATA_WIDTH-1:0] w_data; // multiplied width by 2
	output logic [DATA_WIDTH-1:0] r_data;
	
	// array declaration (registers)
	logic [2*DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1]; // changed to 2*DATA_WIDTH
	
	// write operation (synchronous)
	always_ff @(posedge clk)
	   if (w_en)
		   array_reg[w_addr] <= w_data;
	
	// read operation (asynchronous)
	assign r_data = array_reg[r_addr];
	
endmodule  // reg_file