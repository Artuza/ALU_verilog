module ProgramMemory(
    input clk,                         // Reloj del sistema
    input [7:0] address,               // Dirección de memoria de 8 bits para 256 localidades
    input [31:0] write_data,           // Datos a escribir
    input mem_write,                   // Señal de habilitación de escritura
    input mem_read,                    // Señal de habilitación de lectura
    output reg [31:0] read_data        // Datos leídos de la memoria
);

    parameter MEM_SIZE = 256;          // Tamaño de la memoria: 256 palabras de 32 bits
    reg [31:0] memory[0:MEM_SIZE-1];   // Memoria RAM

    // Proceso de lectura y escritura en memoria
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address] <= write_data;  // Escribe los datos en la memoria si mem_write está activo
        end
        if (mem_read) begin
            read_data <= memory[address];  // Actualiza el registro de datos leídos si mem_read está activo
        end
    end

endmodule
