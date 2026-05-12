module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_last = 8'b0;
    always @ (posedge clk) begin
        pedge <= ~(in_last) & in;
        in_last <= in;
    end
    
endmodule


// https://hdlbits.01xz.net/wiki/Edgedetect
