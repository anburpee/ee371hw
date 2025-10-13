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
	// update full_next, one_left_next, emtpy_next in each case 
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
							rd_ptr_next = rd_ptr + 1;
							wr_ptr0_next = wr_ptr0 + 2; // changed from + 1'b1 -- move forward 2
							wr_ptr1_next = wr_ptr1 + 2;

							full_next = (wr_ptr1_next == rd_ptr_next);
							one_left_next = (wr_ptr0_next == rd_ptr_next);
							empty_next = 1'b0;
						end
				end // 2'b00
			2'b10:  
				begin // read
					if (~empty)	
						begin	
							rd_ptr_next = rd_ptr + 1;

							full_next = 1'b0;
							one_left_next = (rd_ptr_next == wr_ptr0);
							empty_next = (rd_ptr_next == wr_ptr1);
						end
				end // 2'b10
			2'b01:  
				begin// write
					// add conditional of ~one_left (rd_ptr != wr_ptr0)
					// there has to be at least 2 open addresses to write in data
					// since each address only stores half the width of the data written in
					if (~full & ~one_left) // ~full & (rd_ptr != wr_ptr0)
						begin
							wr_ptr0_next = wr_ptr0 + 2; // changed from + 1'b1
							wr_ptr1_next = wr_ptr1 + 2; 

							full_next = (wr_ptr1_next == rd_ptr);
							one_left_next = (wr_ptr0_next == rd_ptr);
							empty_next = 1'b0;
						end
				end // 2'b01
			2'b00: ; // no change
			default: begin
				// code here
			end
		endcase
	end  // always_comb
	
endmodule  // fifo_ctrl


// module fifo_ctrl_tb();

// endmodule