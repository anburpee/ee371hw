/* FIFO controller to manage a register file as a circular queue.
 * Manipulates output read and write addresses based on 1-bit
 * read (rd) and write (wr) requests and current buffer status
 * signals empty and full.
 */
module fifo_ctrl #(parameter ADDR_WIDTH=4)
                 (clk, reset, rd, wr, empty, full, one_left, w_addr0, w_addr1, r_addr);
	
	input  logic clk, reset, rd, wr;
	output logic empty, full, one_left;
	// split up w_addr to w_addr0 and w_addr1
	// w_addr0 stores the LSBs of the data written in
	// w_addr1 stores the MSBs of the data written in
	output logic [ADDR_WIDTH-1:0] w_addr0, w_addr1, r_addr;
	
	// signal declarations
	logic [ADDR_WIDTH-1:0] rd_ptr, rd_ptr_next;
	// split up wr_ptr to wr_ptr0 and wr_ptr1
	logic [ADDR_WIDTH-1:0] wr_ptr0, wr_ptr0_next, wr_ptr1, wr_ptr1_next;

	logic full_next, empty_next, one_left_next; // new -- intermediate logic signals
	
	// output assignments
	assign w_addr0 = wr_ptr0; // new
	assign w_addr1 = wr_ptr1; // new
	assign r_addr = rd_ptr;
	
	// fifo controller logic
	always_ff @(posedge clk) begin
		if (reset)
			begin
				wr_ptr0 <= 1;	// new -- starting position -- need to specify width??
				wr_ptr1 <= 0;	// new -- starting position
				rd_ptr <= 0;
				full   <= 0;
				empty  <= 1;
				one_left <= 0; // new
			end
		else
			begin
				wr_ptr0 <= wr_ptr0_next;	// new
				wr_ptr1 <= wr_ptr1_next;	// new
				rd_ptr <= rd_ptr_next;
				full   <= full_next;
				empty  <= empty_next;
				one_left <= one_left_next; // new
			end
	end  // always_ff
	
	// next state logic
	always_comb begin
		// default to keeping the current values
		rd_ptr_next = rd_ptr;
		wr_ptr0_next = wr_ptr0;
		wr_ptr1_next = wr_ptr1;
		empty_next = empty;
		full_next = full;
		one_left_next = one_left;
		case ({rd, wr})
			2'b11:  // read and write
				begin
					// put logic in a conditional b/c can't read and write at the same time
					// unless there's at least 1 open slot
					if (~full) 
						begin
							rd_ptr_next = rd_ptr + 1'b1;
							wr_ptr0_next = wr_ptr0 + 2'b10; // changed from + 1'b1 -- move forward 2
							wr_ptr1_next = wr_ptr1 + 2'b10;
							if (wr_ptr1_next == rd_ptr_next) // added logic to full signal -- one left condition
								full_next = 1;
								one_left_next = 0;
							else if (wr_ptr0_next == rd_ptr_next ) // added logic for one_left signal
								one_left_next = 1;
						end
				end
			2'b10:  // read
				if (~empty)	
					begin	
						rd_ptr_next = rd_ptr + 1'b1;
						if (rd_ptr_next == wr_ptr1) // changed from wr_ptr to wr_ptr1
							empty_next = 1;
						else if (one_left) // if one_left before read -- rd_ptr == wr_ptr0
							one_left_next = 0;
						else if (full)	// added logic for one_left
							one_left_next = 1;
						full_next = 0;
					end
			2'b01:  // write
				// add conditional of ~one_left (rd_ptr != wr_ptr0)
				// there has to be at least 2 open addresses to write in data
				// since each address only stores half the width of the data written in
				if (~full & ~one_left) // ~full & (rd_ptr != wr_ptr0)
					begin
						wr_ptr0_next = wr_ptr0 + 2'b10; // changed from + 1'b1
						wr_ptr1_next = wr_ptr1 + 2'b10; 
						empty_next = 0;
						if (wr_ptr1_next == rd_ptr) // changed from wr_ptr_next == rd_ptr
							full_next = 1;
						else if (wr_ptr0_next == rd_ptr) // adde logic for one_left
							one_left_next = 1;
					end
			2'b00: ; // no change
		endcase
	end  // always_comb
	
endmodule  // fifo_ctrl
