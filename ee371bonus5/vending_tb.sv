module vending_tb();
    // generates random coin inputs to vending machine
    // until a randomly-chosen number of gumballs have been dispensed
    class coin_gen;
        // Q2: define class
        rand bit [2:0] num_gum;
        rand bit D, N;

        constraint c_num_gum {
            // num_gum inside {3, 4, 5, 6}; // redundant
            num_gum dist {3:=35, 4:=35, 5:=15, 6:=15};
        } 

        function integer get_num_gum();
            return num_gum;
        endfunction

        function bit [1:0] next_coin();
            integer a = $urandom_range(0,2);
            case(a)
                0: begin D = 0; N = 0; end
                1: begin D = 0; N = 1; end
                2: begin D = 1; N = 0; end
            endcase
            return {D, N};
        endfunction

    endclass // coin_gen

    parameter T = 20; // clock period
    logic clk, Reset, D, N;
    logic Ready, Coin, Dispense, Return;

    vending dut (.*); // vending machine module

    coin_gen cg; // coin  generator object handle

    initial begin
        clk <= 0;
        forever #(T/2) clk <= ~clk;
    end

    integer i, var;
    initial begin
        // Q3.1 instantiate and randomized ecoin_gen obj
        cg = new();
        // Q3.2 randomize coin_gen object
        cg.randomize();
        // if (!cg.randomize()) $finish;

        // first reset the system
        Reset = 1; D = 0; N = 0; @(posedge clk);
        Reset = 0; @(posedge clk);

        // Q3.3
        var = cg.get_num_gum();
        for (i = 0; i < var; i++) begin
            while (!Dispense) begin
                {D, N} = cg.next_coin();
                @(posedge clk);
            end
            $display("dispensed at time %t", $time);
        end

        @(posedge clk);
        $finish;
    end

    // Q4: define assertions
    property within_five;
        @(posedge clk)
        Coin |=> ##[0:3] Dispense ##1 Ready;
    endproperty
    assert property (within_five)
        else $error ("too many clock cycles");


endmodule // vending_tb