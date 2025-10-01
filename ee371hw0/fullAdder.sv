module fullAdder (a, b, cin, sum, cout);
    input logic a, b, cin;
    output logic sum, cout;

    assign sum = a ^ b^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module fullAdder_testbench();
    logic a, b, cin, sum, cout;

    fullAdder dut (a, b, cin, sum, cout);

    integer i;
    initial begin
        for (i=0; i<2**3; i++) begin
            {a, b, cin} = i;
            #10;
        end // for loop
    end // initial
endmodule