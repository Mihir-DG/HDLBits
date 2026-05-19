# HDLBits Solutions
Verilog Practice rip

## Contents
1. Basics
2. Vectors
3. Modules
4. Procedures
5. Additional Verilog
6. Latches and DFFs
7. Counters
8. Shift Registers
9. FSMs
10. Test Benches
11. Questa Run Sequence


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

## Counters
1. Reset behavior works the same as DFFs
2. Load value is the value used to overwrite previous value when reset is enabled.
3. You can slow down a clock in one of two ways:
         - Slow Enables: Requires a secondary enable signal that indicates when the counter should actually jump.
         - Cascaded counters: Putting two 0-9 counters together such that second one is only enabled when first one hits 9. For example, if you have a 100 Hz enable signal driving the first one, the second one counts at 10 Hz, since it's only turned on 10% of the time. See counters005_freqDivider.v
4. BCD counter ==> 0-9 decimal counter

## Shift Registers
1. Right shift: 0110 --> 0011
2. Left shift: 0110 --> 1100
3. Use concatenation operators for optimizing shift implementations: eg., `q <= {q[98:0], q[99]};` performs a left circular shift. See shiftRegister003
4. See LFSR implementation in shiftRegister005; should generally be done using vector concatenation.

## Finite State Machines (FSMs)
1. Use `parameter` for state encodings; creates labels for numbers, improves readability + easier to change state encodings since it's declared at the top.
2. Define state transition logic in a combinational block; Sequential block should iterate the FSM (`state <= next_state`). Use conditional assignments for output assignments after these blocks, ideally. See `FSM001_async.v`
3. Use `regs` for `state` and `next_state` --> modifiable in a sequential block.
4. Note that reset functionality is NOT included in the state transition logic block (combinational); it's part of the sequential block (state transition *mechanics*). This goes for both asynchronous and synchronous resets.
5. One-Hot State Encodings: instead of having separate registers for states (through `parameter`), vectorize the process. For example, for states `A, B, C, D`, set `state[3:0]` where `state[0]` corresponds to `A`, `state[1]` corresponds to `B`, etc.
6. For one-hot cases, a valid state definition means that there can only be one `1` in the vector -- one-hit rule. For example, `state = C` corresponds to `state[3:0] = 0010`; Any sequence like `1010` is invalid in this context - for more advanced applications, filter out these invalid states and throw an error somehow?
7. Be wary of using logic simplification on one-hot machine encodings. Things like subtractionary/exclusionary simplifications create issues when dealing with random state sequences that don't follow the one-hit rule. General rule of thumb is to not simplify beyond any order of operations simplifications: eg., `(A AND C) OR (A AND B) = (A OR B) AND C`

## Designing Test Benches
- Creates a simulation environment to verify the functionality of a digital design
- DUT --> Device Under Test
- Test bench --> *Separate*, *top-level* module that: generates input stimuli, captures output, compares that output against expected output
- Generated with `functions` and `tasks`
- tb_DUT doesn't have any ports (no I/O) -- as the top-level entity, all instantiations to the DUT are made internally
- https://chipverify.com/verilog/verilog-testbench
  
**General Workflow:**
1. Declare top-level tb (test bench) module; again, no ports
2. Declare signals for the DUT connection: inputs are regs, outputs are wires, any additional monitoring signals should be regs
3. Instantiate DUT and connect signals declared in step 2 to the module instantiation
4. Initialize test bench inputs using an `initial` block. Include a `$finish` timestamp as well at the end of the initial block to end the simulation.
5. Write test stimulus using a `task`
      - Commonly used structures for test stimulus:
        - `#(10)` --> delays for 10 time units, and allows inputs to settle + prevents race conditions through concurrency
        - `$random` -->  generates random numbers based on the width of the bus it's being applied to. (applied to a single-lead wire, randomly switches between 0 and 1, but on a 3-bit wire, generates 0-7 randomly)
        - Clock generation --> `always #5 clk = ~clk;` --> creates a clock with 10 ns period.
        - Calls checker code at the end of the test.
        - $monitor("Time = %0t clk = %0d sig = %0d", $time, clk, sig); --> This system task will print out the signal values everytime they change (used in `initial` block generally, before input initialization)

6. Write checker code, generally using a combination of `functions` and `tasks`. Top-level is usually a task.

- The (stratified) event queue decides the order of operations for every time step in a simulation.
- `$stop` vs `$finish` --> stop pauses the simulation, allowing inspection and then continuing. Finishing terminates the simulation entirely for an end-state inspection.
- `.vcd` files create scriptable output that you can use to inspect the output later. See https://chipverify.com/verilog/verilog-vcd. There's some important functions you should know - `$dumpfile` (specify filename, defaults to `dump.vcd`), `$dumpvars` (controls which variables are recorded), `$dumpon`, `$dumpoff` (toggled recording control), `$dumpall` (creates a checkpoint), `$dumplimit` (sets a size limit on vcd file, in bytes)


## Questa Run Sequence
1. `cd C:/Users/mdasg/Desktop/FPGAPractice/DFF` --> sub in whatever the top level folder is
2. `vlib work`
3. `vlog my_dff.v dff_tb.v`
4. `vsim -voptargs="+acc" work.dff_tb`
5. `add wave *`
6. `run 150 ns`
