module hw1p4 (clk, a, b, c, y, x);

   input  logic clk, a, b, c;
   output logic y;
   output logic x;

   always_ff @(posedge clk) begin
      x = a & b;
      y = x | c;
   end  // always_ff

		
endmodule  // circuit1



// module hw1p4 (clk, a, b, c, y);
//
//    input  logic clk, a, b, c;
//    output logic y;
//    logic x;
//
//    always_ff @(posedge clk) begin
//       y <= x | c;
//       x <= a & b;
//    end  // always_ff
//
// endmodule  // circuit2