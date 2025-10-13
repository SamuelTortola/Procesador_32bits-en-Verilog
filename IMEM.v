// IMEM
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 13/10/2025

//El Instruction Memory (IMEM) es una memoria que almacena las instrucciones del programa que la CPU debe ejecutar.
//Cada instrucción es una palabra de 32 bits, y la IMEM permite acceder a estas instrucciones utilizando una dirección específica.
// La CPU utiliza la dirección proporcionada por el Program Counter (PC) para leer la instrucción correspondiente desde la IMEM.



module IMEM( 
    input  wire [31:0] addr,        // Dirección de la instrucción
    output wire [31:0] instruction // Instrucción leída
);

    reg [31:0] memory [0:15]; // Memoria de 16 palabras de 32 bits

    initial begin
        memory[0] = 32'b000000_00001_00010_00011_00000_100000; // ADD $3, $1, $2
        memory[1] = 32'b001000_01000_01001_0000000000001010; // ADDI $9, $8, 10 
        memory[2] = 32'b000000_00001_00010_00011_00000_100000; // ADD $3, $1, $2
        memory[3] = 32'b000000_00011_00100_00101_00000_100010; // SUB $5, $3, $4
        memory[4] = 32'b000000_00101_00110_00111_00000_100100; // AND $7, $5, $6
        memory[5] = 32'b000000_00111_01000_01001_00000_100101; // OR $9, $7, $8
        memory[6] = 32'b000000_01001_01010_01011_00000_101010; // SLT $11, $9, $10
        memory[7] = 32'b000000_01011_01100_01101_00000_000000; // SLL $13, $12, $11 (shamt=0)
        memory[8] = 32'b000000_01101_01110_01111_00000_000010; // SRL $15, $14, $13 (shamt=0)
        memory[9] = 32'b000000_01111_10000_10001_00000_100000; // ADD $17, $15, $16
        memory[10] = 32'b000000_10001_10010_10011_00000_100010; // SUB $19, $17, $18
        memory[11] = 32'b000000_10011_10100_10101_00000_100100; // AND $21, $19, $20
       
    end

    assign instruction = memory[addr[4:0]]; // Usa los 5 bits menos significativos

endmodule

