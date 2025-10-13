module testbench_PC;

//**********************************************************************************************

    // ================================================
    // 1. DECLARACIÓN DE SEÑALES
    // ================================================
    // Señales para conectar al DUT (Design Under Test)

    reg clk;
    reg reset;
    reg [31:0] next_pc;
    wire [31:0] current_pc;


    integer start, finish;

     // ================================================
    // 2. INSTANCIACIÓN DEL DISEÑO BAJO PRUEBA (DUT)
    // ================================================

     PC dut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );


     // ================================================
    // 3. GENERACIÓN DE ESTÍMULOS Y MONITOREO
    // ================================================


    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 unidades de tiempo
    end

   // Estímulos y monitoreo
    initial begin
        reset = 1;
        next_pc = 32'h00000000;
        #10; // Espera algunos ciclos de reloj

        reset = 0; // Desactiva reset

        // Prueba: cambia next_pc cada ciclo
        repeat (8) begin
            @(posedge clk);
            $display("Time=%0t | reset=%b | next_pc=%h | current_pc=%h", $time, reset, next_pc, current_pc);
            next_pc = next_pc + 32'h4; // Incrementa en 4 
        end

        $finish;
    end

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, testbench);
    end

endmodule



//**********************************************************************************************

module testbench_imem;

    reg [31:0] addr;
    wire [31:0] instruction;

    // Instancia del módulo IMEM
    IMEM dut (
        .addr(addr),
        .instruction(instruction)
    );

    integer i;



    initial begin
        $display("Addr   | Instruction         | Opcode | rs | rt | rd | shamt | funct | immediate");
     
        for (i = 0; i < 10; i = i + 1) begin
            addr = i;
            #1; // Espera a que instruction se actualice

            // Extrae campos para tipo R
            $display("%2d     | %h | %2b     | %2d | %2d | %2d | %2d    | %2d    | %h",
                addr,
                instruction,
                instruction[31:26], // opcode
                instruction[25:21], // rs
                instruction[20:16], // rt
                instruction[15:11], // rd
                instruction[10:6],  // shamt
                instruction[5:0],   // funct
                instruction[15:0]   // immediate
            );
        end
        $finish;
    end

    initial begin
        $dumpfile("imem_tb.vcd");
        $dumpvars(0, testbench_imem);
    end

endmodule


//**********************************************************************************************

module testbench_PC_IMEM;

    reg clk;
    reg reset;
    reg [31:0] next_pc;
    wire [31:0] current_pc;
    wire [31:0] instruction;

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

    integer i;

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        next_pc = 0;
        #12;
        reset = 0;

        // Avanza el PC automáticamente y muestra instrucción y campos
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            next_pc = current_pc + 1; // Avanza de 4 en 4 (tamaño típico de instrucción MIPS)

            $display("PC=%0d, Instr=%b", current_pc, instruction);
            $display("opcode=%b rs=%b rt=%b rd=%b shamt=%b funct=%b immediate=%b",
                instruction[31:26], // opcode
                instruction[25:21], // rs
                instruction[20:16], // rt
                instruction[15:11], // rd
                instruction[10:6],  // shamt
                instruction[5:0],   // funct
                instruction[15:0]   // immediate
            );
            $display("");
        end

        $finish;
    end

    initial begin
        $dumpfile("pc_imem_tb.vcd");
        $dumpvars(0, testbench_PC_IMEM);
    end

endmodule


//**********************************************************************************************