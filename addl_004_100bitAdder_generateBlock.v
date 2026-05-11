// https://hdlbits.01xz.net/wiki/Adder100i

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    
    generate
        
        for (i = 0; i < 100; i = i + 1) begin : adder_instances
            
            if (i == 0) begin
                fullAdder fa0(.a(a[i]), .b(b[i]), .cin(cin), .cout(cout[i]), .sum(sum[i]));
            end
            
            else begin
                fullAdder fai(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .cout(cout[i]), .sum(sum[i]));
            end
        end               
           
    endgenerate
    
endmodule
            
module fullAdder(
    input a, b, cin,
    output cout, sum);
	
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule
