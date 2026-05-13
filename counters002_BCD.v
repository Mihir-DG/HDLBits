module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
    
        if(reset | q == 4'b1001) q <= 4'b0; // 4'b1001 = 4'd9
        else q <= q + 4'd1;
    
    end

endmodule

// https://hdlbits.01xz.net/wiki/Count10
