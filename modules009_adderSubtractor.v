module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire cout1;
    wire [15:0] lower_sum;
    wire [15:0] upper_sum;
    wire [31:0] b_xord = b ^ {32{sub}}; 
    
    add16 adder_lower(.a(a[15:0]), .b(b_xord[15:0]), .cin(sub), .cout(cout1), .sum(lower_sum));
    add16 adder_upper(.a(a[31:16]), .b(b_xord[31:16]), .cin(cout1), .sum(upper_sum));
    assign sum = {upper_sum, lower_sum};


endmodule
