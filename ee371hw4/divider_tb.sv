module divider_tb ();

    logic Clock, Resetn, s, LA, EB, Done;
    logic [7:0] DataA, DataB, R, Q;

    parameter T = 20;
    initial begin
        Clock <= 0;
        forever #(T/2) Clock <= ~Clock;
    end

    divider dut(.*);

    initial begin
        // DataA = 8'd100; DataB = 8'd10;
        // Resetn = 1;
        // s = 0; LA = 1; EB = 1; @(posedge Clock);
        // LA = 0; EB = 0; s = 1; @(posedge Clock);

        for (int i = 0; i < 50; i++) begin
            DataA = $random % 256; DataB = $random % 256;
            if (DataB == 0)
                continue;
            Resetn = 0; @(posedge Clock);
            Resetn = 1;

            s = 0; LA = 1; EB = 1; @(posedge Clock);
            LA = 0; EB = 0; s = 1; @(posedge Clock);

            wait (Done); @(posedge Clock);

            if (Q === (DataA / DataB) && R === (DataA % DataB))
                $display ("Pass: [A]: %d, [B]: %d", DataA, DataB);

            else
                $display ("Fail: [A]: %d, [B]: %d", DataA, DataB);
            
            repeat(2) @(posedge Clock);

        end

        $stop;

    end

endmodule