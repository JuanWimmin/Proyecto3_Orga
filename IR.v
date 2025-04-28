module IR(
    input wire CLK,
    input wire RESET,      // Reset asíncrono
    input wire HIR,         // Habilitador de carga
    input wire [7:0] DATA_IN,  // Entrada de datos (instrucción desde memoria)
    output reg [7:0] IR_OUT    // Salida del registro (instrucción almacenada)
);

// Registro con carga controlada por HIR y reset asincrónico
always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        IR_OUT <= 8'b0;           // Resetear el registro a 0
    end else if (HIR) begin
        IR_OUT <= DATA_IN;        // Capturar instrucción cuando HIR esté activo
    end
end

endmodule
