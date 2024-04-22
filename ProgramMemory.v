module ProgramMemory(
    input clk,                     // Reloj del sistema
    input [31:0] address,          // Dirección de memoria
    input [31:0] write_data,       // Datos a escribir
    input mem_write,               // Señal de habilitación de escritura
    input mem_read,                // Señal de habilitación de lectura
    output reg [31:0] read_data    // Datos leídos de la memoria
);

    // Define el tamaño de la memoria.
    // Por ejemplo, 256 palabras de 32 bits.
    parameter MEM_SIZE = 256;
    reg [31:0] memory[0:MEM_SIZE-1];

    // Proceso de lectura y escritura en memoria
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[31:2]] <= write_data;  // Escribe los datos en la memoria
        end
        if (mem_read) begin
            read_data <= memory[address[31:2]];   // Lee los datos desde la memoria
        end
    end

endmodule
