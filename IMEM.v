// IMEM
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094
// Fecha: 13/10/2025



module IMEM(
    input  wire [31:0] addr,        // Dirección de la instrucción
    output wire [31:0] instruction // Instrucción leída
);

    reg [31:0] memory [0:15]; // Memoria de 16 palabras de 32 bits

    initial begin
        memory[0] = 32'b000000_00001_00010_00011_00000_100000; // ADD $3, $1, $2
        memory[1] = 32'b001000_01000_01001_0000000000001010;   // ADDI $9, $8, 10
        memory[2] = 32'b000100_00001_00010_0000000000000100;   // BEQ $1, $2, 4
        memory[3] = 32'b100011_00001_00010_0000000000000000;   // LW $2, 0($1)
        memory[4] = 32'b101011_00001_00010_0000000000000000;   // SW $2, 0($1)
        memory[5] = 32'b000000_00010_00011_00100_00000_100010; // SUB $4, $2, $3
        memory[6] = 32'b000000_00011_00100_00101_00000_100100; // AND $5, $3, $4
        memory[7] = 32'b000000_00100_00101_00110_00000_100101; // OR $6, $4, $5
        memory[8] = 32'b000000_00101_00110_00111_00000_101010; // SLT $7, $5, $6
        memory[9] = 32'b000010_00000000000000000000001100;     // J 12
        // Puedes inicializar el resto si lo deseas
    end

    assign instruction = memory[addr[4:0]]; // Usa los 5 bits menos significativos

endmodule

