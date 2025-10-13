/* FIFO controller to manage a register file as a circular queue.
 * Manipulates output read and write addresses based on 1-bit
 * read (rd) and write (wr) requests and current buffer status
 * signals empty and full.
 */
module fifo_ctrl #(parameter ADDR_WIDTH=4)
                 (clk, reset, rd, wr, empty, full, w_addr, r_addr);
	
	input  logic clk, reset, rd, wr;
	output logic empty, full;
	output logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] rd_ptr, rd_ptr_next;
	logic [ADDR_WIDTH-1:0] wr_ptr, wr_ptr_next;
	logic empty_next, full_next;
	
	// output assignments
	assign w_addr = wr_ptr;
	assign r_addr = rd_ptr;
	
	// fifo controller logic
	always_ff @(posedge clk) begin
		if (reset)
			begin
				wr_ptr <= 0;
				rd_ptr <= 0;
				full   <= 0;
				empty  <= 1;
			end
		else
			begin
				wr_ptr <= wr_ptr_next;
				rd_ptr <= rd_ptr_next;
				full   <= full_next;
				empty  <= empty_next;
			end
	end  // always_ff
	
	// next state logic
	always_comb begin
		// default to keeping the current values
		rd_ptr_next = rd_ptr;
		wr_ptr_next = wr_ptr;
		empty_next = empty;
		full_next = full;
		case ({rd, wr})
			2'b11:  // read and write
				begin
					// put logic in a conditional b/c can't read and write at the same time
					// unless there's at least 1 open slot
					if (~full) 
						begin
							rd_ptr_next = rd_ptr + 1'b1;
							wr_ptr_next = wr_ptr + 2'b10; // changed from  + 1'b1
							if (wr_ptr_next == rd_ptr_next) // added logic
								full_next = 1;
						end
				end
			2'b10:  // read
				if (~empty)	// don't need to change logic
					begin	
						rd_ptr_next = rd_ptr + 1'b1;
						if (rd_ptr_next == wr_ptr)
							empty_next = 1;
						full_next = 0;
					end
			2'b01:  // write
				// add conditional of rd_ptr != wr_ptr + 1'b1
				// there has to be at least 2 open addresses to write in data
				// since each address stores the number of bits that is read out 
				// which is half the width of the data written in
				if (~full & (rd_ptr != wr_ptr + 1'b1)) 
					begin
						wr_ptr_next = wr_ptr + 2'b10; // changed from + 1'b1
						empty_next = 0;
						if (wr_ptr_next == rd_ptr)
							full_next = 1;
					end
			2'b00: ; // no change
		endcase
	end  // always_comb
	
endmodule  // fifo_ctrl
