module MAR(
    input wire CLK,
    input wire RESET,          // Nuevo: señal de reset asíncrono
    input wire [7:0] BUS_C,
    input wire HMAR,
    output reg [7:0] BUS_DIR
);

always @(negedge CLK or posedge RESET) begin
    if (RESET) begin
        BUS_DIR <= 8'b0;        // Al resetear, ponemos BUS_DIR en cero
    end else if (HMAR) begin
        BUS_DIR <= BUS_C;       // Si HMAR está activo, copiamos BUS_C
    end
end

endmodule
