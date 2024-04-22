module ProgramCounter(
    input clk,            // Señal de reloj
    input reset,          // Señal de reinicio
    input [31:0] nextPC,  // Próxima dirección de PC
    input enable,         // Habilitar actualización del PC
    output reg [31:0] pc  // Valor actual del PC
);

    // Inicialización y actualización del PC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0; // Valor inicial del PC tras reset
        end else if (enable) begin
            pc <= nextPC; // Actualiza el PC si está habilitado
        end
    end

endmodule
