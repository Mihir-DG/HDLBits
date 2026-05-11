// https://hdlbits.01xz.net/wiki/Module_add

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cin1;
    assign cin1 = 1'b0;
    wire [15:0] lower_sum;
    wire [15:0] upper_sum;
    wire cout1;
    wire cout2;
    
    add16 adderLow(.a(a[15:0]), .b(b[15:0]), .cin(cin1), .sum(lower_sum), .cout(cout1));
    add16 adderUp(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .sum(upper_sum), .cout(cout2));
    assign sum[31:16] = upper_sum;
    assign sum[15:0] = lower_sum;

endmodule
