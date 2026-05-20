// testbench

module fsm4state_tb;

    reg tb_clk;
    reg tb_in;
    reg tb_reset;
    wire tb_out;
    wire[3:0] tb_state;

    fsm4state dut_inst (
        .clk(tb_clk),
        .in(tb_in),
        .areset(tb_reset),
        .out(tb_out),
        .state(tb_state)
    );

    localparam STATE_A = 4'b0001;
    localparam STATE_B = 4'b0010;
    localparam STATE_C = 4'b0100;
    localparam STATE_D = 4'b1000;

    task atod_highOut();

        begin
            $display(" --- Testing A-D State Transition Sequence ---");

            if (STATE_A == tb_state) $display("[PASS] Initialized cleanly to State A");
            else $display("[FAIL] Failed to reset cleanly on initialization");

            @(negedge tb_clk);
            tb_in = 1;
            check_state_and_out(STATE_B, 0);
            @(negedge tb_clk);
            tb_in = 0;
            check_state_and_out(STATE_C, 0);
            @(negedge tb_clk);
            tb_in = 1;
            check_state_and_out(STATE_D, 1); 
        end
    endtask

    task test_async();
        begin
            $display(" --- Testing validity of async reset ---");
            #10;
            @(negedge tb_clk);
            tb_reset = 0;
            repeat(2) @(negedge tb_clk)
            #2; // drive reset = 1 in the mdidle of a clock cycle
            tb_reset = 1;
            #1; // allow for a propagation delay
            if (tb_state == STATE_A && tb_out == 0) $display("[PASS] Reset works asynchronously");
            else $display("[FAIL] Reset not asynchronous");
				
				tb_reset = 0;

        end

    endtask

    task check_state_and_out(input [3:0] expected_state, input expected_out);

        begin
            @(posedge tb_clk);
            #1;
            // checking state
            if(tb_state == expected_state) $display("[PASS] State is correct: %b", tb_state);
            else $display("[FAIL] State is incorrect: Expected %b, got %b", expected_state, tb_state);
            // checking q
            if(tb_out == expected_out) $display("[PASS] Output is correct: %b", tb_out);
            else $display("[FAIL] Output is incorrect: Expected %b, got %b", expected_out, tb_out);

            $display("--- State and Output Check Completed ---");
        end
    endtask


    initial begin

        tb_clk = 0;
        tb_in = 0;
        tb_reset = 1;
        #2;
        @(negedge tb_clk);
        tb_reset = 0;
        // initialization done

        atod_highOut();
		  test_async();
    end

    always #5 tb_clk = ~ tb_clk;

endmodule
