`timescale 1ns/100ps

module ZandMASgen (
    output wire Zs, MAS,
    input wire XeLTYe, Xs, Ys, AbarS
);
    // Logic for Zs
    xor (AbarSxorYs, Ys, AbarS);
    not (XeLTYenot, XeLTYe);
    and (t1, XeLTYenot, Xs);
    and (t2, XeLTYe, AbarSxorYs);
    or (Zs, t1, t2);

    // Logic for MAS
    xor (MAS, Ys, AbarS, XeLTYe);
    
endmodule