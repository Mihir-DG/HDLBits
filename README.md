# HDLBits
Verilog Practice rip

## Basics

1. Assignment: `assign out = in;` -- sets out = in
2. Logical Inverter:  `assign out = !in;` -- sets out = LOGICAL NOT(in); returns 1 if `in` is non-zero
3. Bitwise Inverter: `assign out = ~in;` -- sets out = NOT(in)
4. Bitwise AND: `assign out = a & b` -- sets out = 1 if a and b are non-zero
5. Logical AND: `assign out = a && b` -- sets out = a AND b (bitwise)
6. Bitwise NOR: `assign out = !(a | b)` -- sets out = a NOR b = NOT(a OR b); OR is logical
7. Bitwise XNOR: `assign out = !(a ^ b)` -- there is no logical-XOR
8. Wire Declaration: `wire w1;`; allows an assignment well before the inputs of that assignment are set.

## Vectors

1. Written as [type] [upperBound: lowerBound] [vector name] ;
2. Vector splicing
      - Let `wire[31:0] 32_bit;`
      - Upper 16 bits extracted as `wire[15:0] upper16 = 32_bit[31:16];`
3. Logical vs bitwise operators make a difference now!
4. Concatenation Methods:
   - `wire [4:0] a, b;` --> `wire [8:0] c = {a, b};`
   - `wire [7:0] a;` --> `wire [31:0] sign_extended = {{24{a[7]}}, a[7:0]};`
        - Additional set of curly braces required when using multiplier (like the 24 here)
    
## Modules
1. Instantiate by position: `mod_a instance1(out1, out2, a,b,c,d);`
2. Instantiate by name: `mod_a instance1(.in1(a), .in2(b), .in3(c), .in4(d), .out1(out1), .out2(out2));`
3. Declare outputs when cascading modules for intermediates
     - Inputs to first module --> drawn as inputs to top module
     - Intermediate outputs --> declared before instantiation chain
     - Final outputs --> drawn as outputs to top module
4. See adder examples for cascaded modules
5. Basic adder -- ripple carry adder, which is slow; Carry select adder is faster, at the cost of additional components

