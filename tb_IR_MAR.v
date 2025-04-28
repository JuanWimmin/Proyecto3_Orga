`timescale 1ns / 1ps

module tb_IR_MAR();

// Señales para MAR
reg CLK;
reg RESET_MAR;
reg HMAR;
reg [7:0] BUS_C;
wire [7:0] BUS_DIR;

// Señales para IR
reg RESET_IR;
reg HIR;
reg [7:0] DATA_IN;
wire [7:0] IR_OUT;

// Instancia del MAR
MAR MAR_inst (
    .CLK(CLK),
    .RESET(RESET_MAR),
    .HMAR(HMAR),
    .BUS_C(BUS_C),
    .BUS_DIR(BUS_DIR)
);

// Instancia del IR
IR IR_inst (
    .CLK(CLK),
    .RESET(RESET_IR),
    .HIR(HIR),
    .DATA_IN(DATA_IN),
    .IR_OUT(IR_OUT)
);

// Generador de reloj
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;  // Periodo de 10ns
end

// Estímulos de prueba
initial begin
    // Inicialización
    RESET_MAR = 1;
    RESET_IR = 1;
    HMAR = 0;
    HIR = 0;
    BUS_C = 8'h00;
    DATA_IN = 8'h00;

    #10;  // Esperar 10ns

    // Quitar reset
    RESET_MAR = 0;
    RESET_IR = 0;

    // Escribir en MAR
    BUS_C = 8'hA5;
    HMAR = 1;
    #10;
    HMAR = 0;  // Deshabilitar después de cargar

    // Escribir en IR
    DATA_IN = 8'h3C;
    HIR = 1;
    #10;
    HIR = 0;  // Deshabilitar después de cargar

    // Intentar cambiar BUS_C e DATA_IN sin habilitar HIR ni HMAR
    BUS_C = 8'hF0;
    DATA_IN = 8'h99;
    #10;

    // Activar de nuevo HIR para cargar nueva instrucción
    HIR = 1;
    #10;
    HIR = 0;

    // Activar de nuevo HMAR para cargar nueva dirección
    HMAR = 1;
    #10;
    HMAR = 0;

    #20;
    $finish;  // Terminar simulación
end

endmodule
