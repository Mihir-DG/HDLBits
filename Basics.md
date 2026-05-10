### Topics covered so far
*(will keep updating)*

1. Assignment: `assign out = in;` -- sets out = in
2. Logical Inverter:  `assign out = !in;` -- sets out = LOGICAL NOT(in); returns 1 if `in` is non-zero
3. Bitwise Inverter: `assign out = ~in;` -- sets out = NOT(in)
4. Logical AND: `assign out = a & b` -- sets out = 1 if a and b are non-zero
5. Bitwise AND: `assign out = a && b` -- sets out = a AND b (bitwise)
6. Logical NOR: `assign out = !(a | b)` -- sets out = a NOR b = NOT(a OR b); OR is logical
7. Bitwise XNOR: `assign out = !(a ^ b)` -- there is no logical-XOR
8. Wire Declaration: `wire w1;`; allows an assignment well before the inputs of that assignment are set.
