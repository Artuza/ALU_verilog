`timescale 1ns / 1ps

module testbench_ProgramCounter;
    // Inputs
    reg clk;
    reg reset;
    reg [31:0] nextPC;
    reg enable;

    // Output
    wire [31:0] pc;

    // Instanciación del módulo ProgramCounter
    ProgramCounter uut (
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .enable(enable),
        .pc(pc)
    );

    // Generación de la señal de reloj
    always #5 clk = ~clk;  // Reloj con periodo de 10ns

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        nextPC = 0;
        enable = 0;

        // Esperar a que el reloj se estabilice
        #10;

        // Caso de prueba 1: Reset del PC
        reset = 1; #10;
        reset = 0; #10;

        // Caso de prueba 2: Cambio de PC con enable
        nextPC = 32'h00000010; enable = 1; #20;
        nextPC = 32'h00000020; #10;

        // Caso de prueba 3: PC no cambia si enable es 0
        enable = 0;
        nextPC = 32'h00000030; #20;

        // Reactivar enable y cambiar PC
        enable = 1;
        nextPC = 32'h00000040; #10;

        // Finalizar simulación
        $finish;
    end

    initial begin
        $monitor("At time %t, reset = %b, enable = %b, nextPC = %h, pc = %h", 
                 $time, reset, enable, nextPC, pc);
    end
endmodule
