module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
	parameter A=0, B=1, C=2, D=3;
    wire[3:0] state;
    wire[3:0] next_state;
    
    assign next_state[A] = (state[A] | state[C]) && (~in);
	assign next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
    assign next_state[C] = ~(in) && (state[B] | state[D]);
    assign next_state[D] = in && state[C];
    
    // State flip-flops with asynchronous reset
	
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= 4'b0;
            state[A] <= 1'b1;
        end
    	else state <= next_state;
    end
    
    // Output logic
    assign out = (state[D]);
endmodule

// https://hdlbits.01xz.net/wiki/Fsm3
