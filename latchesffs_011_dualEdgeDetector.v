module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] in_last = 8'bz;
    always @ (posedge clk) begin
        anyedge <= (in_last ^ in);
        in_last <= in;
    end
    
endmodule


// https://hdlbits.01xz.net/wiki/Edgedetect2
