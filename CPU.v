module CPU(
    input clk,            
    input reset,          
    output wire [31:0] alu_result,
    output wire NegativeFlag,
    output wire ZeroFlag
);

    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] nextPC;
    wire [31:0] jumpAddress;
    wire isJump;
    wire enable_pc = 1;
    wire [31:0] alu_operand_a;
    wire [31:0] alu_operand_b;
    wire [3:0] alu_op;
    wire alu_cout;

    ProgramCounter pc(
    .clk(clk),
    .reset(reset),
    .nextPC(nextPC),
    .enable(enable_pc),
    .pc(pc_out)  // Salida que lleva la dirección actual a la ProgramMemory
	);

// Instancia de la Memoria de Programa
ProgramMemory program_memory(
    .clk(clk),
    .address(pc_out),
    .write_data(32'b0),       // Esto es un ejemplo, debes proporcionar los datos reales de escritura si es necesario.
    .mem_write(mem_write),    // Debes definir esta señal en tu módulo CPU basado en la lógica de control.
    .mem_read(mem_read),      // Debes definir esta señal en tu módulo CPU basado en la lógica de control.
    .read_data(instruction)
);


    // Decodificación de la instrucción y configuración de la ALU
    assign nextPC = pc_out + 4;  // Incremento simple de PC
    assign isJump = (instruction[31:28] == 4'b1111);  // Opcode de salto incondicional
    assign jumpAddress = instruction[27:0];           // Dirección de salto

    assign alu_operand_a = pc_out;              // Ejemplo: usar PC como operando
    assign alu_operand_b = instruction[15:0];   // Parte de la instrucción como operando
    assign alu_op = instruction[31:28];         // Código de operación desde instrucción

    // Instancia de la ALU
    alu alu_unit(
        .a(alu_operand_a),
        .b(alu_operand_b),
        .cin(1'b0),  // Asumimos que el carry in no es necesario para este ejemplo
        .opcode(alu_op),
        .result(alu_result),
        .cout(alu_cout),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

endmodule
