# HDLBits Solutions
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

## Procedures
1. Combinational always blocks -- `always @(*) begin ... end`
   - Any signal assigned inside this block must be declared as a reg. However, because the block is combinational, the physical hardware will just be wires and gates.
   - Used instead of `assign`; allows the use of more complex logic though, like `case` and `if/else` conditionals; Procedural => conditionals
   - For conditionals, make sure you have a default case; if not, creates latches that "remembers" the last value
   - See procedures001_combinationalAlways.v
2. Clocked always blocks -- `always @(posedge clk) begin ... end`
   - Clocked always blocks create a blob of combinational logic just like combinational always blocks, but also creates a set of flip-flops (or "registers") at the output of the blob of combinational logic.
   - Instead of the outputs of the blob of logic being visible immediately, the outputs are visible only immediately after the next (posedge clk)
3. Assignment types:
      - Continuous assignments -- `assign a = b;` --> *cannot* be used inside a procedure (`always` block)
      - Procedural blocking assignments -- `a = b;` use in procedural combinational circuit (combinational `always` block)
      - Procedural non-blocking assignments -- `a <= b;` use in procedural sequential circuit (clocked `always` block)
- For 2 and 3, see procedures002_assignmentTypes.v + procedures002_timing.png
- Procedural non-blocking assignments usually lead to a delay (state changes on clk edge) not seen in continuous or blocking assignments.
5. Incompletely defined procedural outcomes (without defaults (for cases) / elses (for ifs) ) usually yields a warning: `Warning (10240): ... inferring latch(es)`
6. `casez` allows you to use cases with X's (don't cares) -- written as `z` or `?` in Verilog. See procedures_007_casezPriorityEncoder.v

## Additional Verilog
1. Ternary operators: `assign out = (sel == 1'b1)? x : y` --> assign `out = x` if `sel = 1`, else assign `out = y`.
2. Wide-gate reduction: 100-input gates can be implemented on a vector
   - eg.: `assign parity = ^ in[7:0];` ==> `parity = in[7] ^ in[6] ^ in[5] .... ^ in [0];`
   - Applies to ANDs, ORs, NOTs, XORs
3. You need to use generate blocks to repetitively instantiate hardware; Calling a module multiple times requires a generate block. See addl_004!

## Latches and Flip-Flops
1. Create a D flip-flop by simply assigning an input-output pair in a sequential logic block -- `q <= d`; also applies for wires `q[n:m]` and `d[n:m]` to create `(N - M + 1)` flip-flops.
2. Active high synchronous reset => on positive edge, if `reset == 1`, set `q = 0;`
3. Positive edge of clock ==> `always @ (posedge clk)`; Negative edge => `negedge`
4. Asynchronous reset ==> has to be included in `always @ (*reset condition here*)` block
5. Latches --> follows input always (always @(*)) IF enable is ON. See latchesffs005_latch.v
6. When combining DFFs with gates, you don't need to use an initialization vector (IV) in the module definition. Application in a larger chain may change that, not sure yet.
7. LFSRs built with gates + DFFs!
8. Sequential Dependency: If `b` depends on `a`, then the "correct" value of `b` will be delayed by one clock cycle after `a` being updated, if they're both being kept in a DFF sequential block. If `b` needs to update alongside `a` move it to a continuous assignment OUTSIDE the sequential block. See `z` assignment in latchesffs_009_sequentialDependency.v 
