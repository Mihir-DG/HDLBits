module top_module( 
    input [254:0] in,
    output [7:0] out );

    integer i;
    reg[7:0] out_reg;
    
    always @(*) begin
        out_reg = 8'b0;
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1) begin
                out_reg = out_reg + 1;
            end
            else out_reg = out_reg;
        end
    end
    
    assign out = out_reg;
    
endmodule

// https://hdlbits.01xz.net/wiki/Popcount255

// Have to set out_reg to 8'b0 INSIDE the always block since that putting it outside means it doesn't have a prior reference value
