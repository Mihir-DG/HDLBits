module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire cin1 = 1'b0;
    wire cout1;
    wire cout2;
    wire[15:0] lower_sum;
    wire[15:0] upper_sum;
    
    add16 adder_lower(.a(a[15:0]), .b(b[15:0]), .cin(cin1), .sum(lower_sum), .cout(cout1));
    add16 adder_upper(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .sum(upper_sum), .cout(cout2));
    assign sum = {upper_sum, lower_sum};

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
	assign sum = a ^ b ^ cin;
    assign cout = (a && b) | (cin & (a ^ b));
endmodule

// https://hdlbits.01xz.net/wiki/Module_fadd
