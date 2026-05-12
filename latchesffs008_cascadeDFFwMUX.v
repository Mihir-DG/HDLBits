module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    always @(posedge clk) begin
    	
        if (L) Q <= R;
        else begin
            if (E) Q <= w;
        end
    
    end 

endmodule

// https://hdlbits.01xz.net/wiki/Exams/2014_q4a
