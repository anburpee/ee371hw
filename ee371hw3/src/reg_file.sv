/* Register file module for specified data and address bus widths.
 * Asynchronous read port (r_addr -> r_data) and synchronous write
 * port (w_data -> w_addr if w_en).
 */

 // DATA_WIDTH is the number of bits read out at a time;
 // the actual width of the data written in is 2*DATA_WIDTH
module reg_file #(parameter DATA_WIDTH=8, ADDR_WIDTH=4) // change default ADDR_WIDTH to 4 to match other files
                (clk, w_data, w_en, w_addr0, w_addr1, r_addr, r_data);

	input  logic clk, w_en;
	input  logic [ADDR_WIDTH-1:0] w_addr0, w_addr1, r_addr;
	input  logic [2*DATA_WIDTH-1:0] w_data; // multiplied width by 2
	output logic [DATA_WIDTH-1:0] r_data;
	
	// array declaration (registers)
	logic [DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1]; 
	
	// write operation (synchronous)
	always_ff @(posedge clk)
	   if (w_en) begin
		   array_reg[w_addr0] <= w_data[DATA_WIDTH-1:0];	// LSBs of data
		   array_reg[w_addr1] <= w_data[2*DATA_WIDTH-1:DATA_WIDTH];	// MSBs of data
	   end
	// read operation (asynchronous)
	assign r_data = array_reg[r_addr];
	
endmodule  // reg_file