module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @ (posedge clk) begin
        if (reset | (q == 4'b1001 & slowena)) q <= 4'b0;
        else begin
            if (slowena) q <= q + 4'd1;
        end
    end

endmodule

//https://hdlbits.01xz.net/wiki/Countslow
