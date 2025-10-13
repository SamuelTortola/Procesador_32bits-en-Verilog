module PC_IMEM_wrapper(
    input clk,
    input reset,
    input [31:0] next_pc,
    output [31:0] current_pc,
    output [31:0] instruction
);

    // Instancia del PC
    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    // Instancia de IMEM
    IMEM imem_inst (
        .addr(current_pc),
        .instruction(instruction)
    );

endmodule