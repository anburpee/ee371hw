module divider_tb ();

    logic Clock, Resetn, s, LA, EB, Done;
    logic [7:0] DataA, DataB;
    logic [7:0] R, Q;

    parameter T = 10;
    initial begin
        Clock <= 0;
        forever #(T/2) Clock <= ~Clock;
    end

    divider dut(.*);
    initial begin
        DataA = 8'b11001101; DataB = 8'b00100110;
        DataA = 8'b00011111; DataB = 8'b00000010;
        DataA = 8'b11111000; DataB = 8'b00100110;
        DataA = 8'b11001101; DataB = 8'b00110111;
        Resetn = 0; @(posedge Clock); // pulse reset (active low)
        Resetn = 1; // reset off
        s = 0; LA = 1; EB = 1; @(posedge Clock);
        LA = 0; EB = 0; s = 1; @(posedge Clock);

        #100
        $stop;
    end

endmodule