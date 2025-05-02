module IR(
    input wire clk,             // Reloj
    input wire rst,             // Reset asincrónico
    input wire ena,             // Habilitador de carga
    input wire sel,             // Selector del MUX (0 = busC, 1 = ZERO)
    input wire [7:0] busC,      // Entrada real
    output wire [4:0] opcode    // Salida: bits 7 a 3 (opcode)
);

reg [7:0] IR_reg;
wire [7:0] mux_out;

// MUX 2:1 interno
assign mux_out = (sel == 1'b0) ? busC : 8'b00000000;

// Registro con reset y enable
always @(posedge clk or posedge rst) begin
    if (rst) begin
        IR_reg <= 8'b0;
    end else if (ena) begin
        IR_reg <= mux_out;
    end
end

// Salida: solo los bits 7 a 3
assign opcode = IR_reg[7:3];

endmodule
