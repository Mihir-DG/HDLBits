module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    always @ (posedge clk) begin
    
        if (L) Q <= r_in;
        else Q <= q_in;
    
    end
    
endmodule

// https://hdlbits.01xz.net/wiki/Mt2015_muxdff
