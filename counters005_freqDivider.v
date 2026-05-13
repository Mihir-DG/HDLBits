module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
	
    wire [3:0] q1, q2, q3;
    
    assign c_enable[0] = 1'b1;
    bcdcount counter0(.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(q1));
    
    assign c_enable[1] = (q1 == 4'd9);
    bcdcount counter1(.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(q2));
    
    assign c_enable[2] = (q1 == 4'd9 && q2 == 4'd9);
    bcdcount counter2(.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(q3));
    
    assign OneHertz = (q1 == 4'd9 && q2 == 4'd9 && q3 == 4'd9);
endmodule

// https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7b
