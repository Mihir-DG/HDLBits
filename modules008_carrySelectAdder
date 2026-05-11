// https://hdlbits.01xz.net/wiki/Module_cseladd

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire cin1 = 1'b0;
    wire[15:0] lower_sum;
    wire[15:0] upper_sum_cin0;
    wire[15:0] upper_sum_cin1;
    wire cout1;
    wire cout2a;
    wire cout2b;
    
    add16 adder_lower(.a(a[15:0]), .b(b[15:0]), .cin(cin1), .sum(lower_sum), .cout(cout1));
    add16 adder_upper_cin0(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(upper_sum_cin0), .cout(cout2a));
    add16 adder_upper_cin1(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(upper_sum_cin1), .cout(cout2b));
    
    always @(*) begin
        
        case(cout1)
            1'b0: sum = {upper_sum_cin0, lower_sum};
            1'b1: sum = {upper_sum_cin1, lower_sum};
        endcase
    
    end
    

endmodule
