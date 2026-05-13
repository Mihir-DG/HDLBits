module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q);
    
    wire [3:0] q0, q1, q2, q3;
    
    bcdcount digit0counter (clk, 1'b1, reset, q0);

    assign ena[1] = (q0 == 4'd9);
    bcdcount digit1counter (clk, ena[1], reset, q1);

    assign ena[2] = (q1 == 4'd9 && ena[1]);
    bcdcount digit2counter (clk, ena[2], reset, q2);

    assign ena[3] = (q2 == 4'd9 && ena[2]);
    bcdcount digit3counter (clk, ena[3], reset, q3);

    assign q = {q3, q2, q1, q0};

endmodule

module bcdcount(
    input clk, 
    input en, 
    input reset, 
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0;
        end else if (en) begin
            if (q == 4'b1001) 
                q <= 4'b0;
            else 
                q <= q + 4'd1;
        end
    end
endmodule

// https://hdlbits.01xz.net/wiki/Countbcd
