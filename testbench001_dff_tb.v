// test bench file

// step 1: declare module dff_tb; (no ports)
module dff_tb;

	// step 2: declare all ports to DUT with reg input + wire output
	reg clk; // inputs (regs)
	reg reset;
	reg [7:0] d;
	//reg [7:0] prev_q; // auxilary variable used for checker
	
	wire [7:0] q; // output (wire)
	
	// step 3: instantiate DUT
	my_dff dut_inst (
		.clk (clk),
		.reset (reset),
		.d (d),
		.q(q)
		);
	
	
	task one_to_ten();
		integer i;
		begin		
			$display(" ---- Counting from 1 to 10 ---- ");
			reset = 0;
			for (i = 0; i < 10; i = i + 1) begin
				@(negedge clk); // drive data on negedge
				d = i;

				check_q(i);
			end
		end
	endtask
	
	task reset_dominance();
		begin
			$display("---- Testing Reset Dominance -----");
			reset = 0;
			
			@(negedge clk); // Drive d and reset high at neg edge
			d = 8'hFF;
			reset = 1;
			
			@(posedge clk)
			#1;
			
			if (q == 8'h00) $display("[PASS] Reset overrode data.");
			else $display("[FAIL]");
			
			@(negedge clk);
			reset = 0;
		end
	endtask
	
	task check_q(input [7:0] expected);
		begin
			@(posedge clk); // only read values at positive edges
			#1 // avoids race conditions
			if (q == expected) $display("Check Q Passed");
			else $display("Check Q FAILED");
		end	
	endtask
	
	
// step 4: initialize test bench variables (inputs)
	initial begin
		
		d = 0;
		clk = 0;
		reset = 1;
		#2
		@(negedge clk); // waits for a falling edge
		reset = 0; // releases the reset
		
		one_to_ten();
		#1
		reset_dominance();
		
		#100
		$display("All tasks complete");
		
	end
	
	always #5 clk = ~ clk; // 10 ns period
	
	

endmodule
