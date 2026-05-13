module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    
    always @(posedge clk) begin
    
		integer i;
        if (load) begin
            q <= data;
        end 
        else if (ena == 2'b01) begin
         
            for (i = 98; i > 0; i = i - 1) begin
                q[i] <= q[i + 1];
            end
            q[0] <= q[1];
            q[99] <= q[0];
        end
        else if (ena == 2'b10) begin
            
            for (i = 1; i < 99; i = i + 1) begin
                q[i] <= q[i - 1];
            end
            q[0] <= q[99];
            q[99] <= q[98];
        end
    
    end 

    // q <= {q[98:0], q[99]}; performs a left circular shift
endmodule

// https://hdlbits.01xz.net/wiki/Rotate100
