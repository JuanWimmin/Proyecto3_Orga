`timescale 1ns / 1ps

module tb_mar_ir;

    // Señales de prueba
    reg clk, rst, ena_ir, sel_ir, hmar;
    reg [7:0] busC;
    wire [4:0] opcode;
    wire [7:0] bus_dir;

    // Instancia del módulo top
    top_mar_ir uut (
        .clk(clk),
        .rst(rst),
        .ena_ir(ena_ir),
        .sel_ir(sel_ir),
        .hmar(hmar),
        .busC(busC),
        .opcode(opcode),
        .bus_dir(bus_dir)
    );

    // Generación de reloj
    always #5 clk = ~clk;

    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        ena_ir = 0;
        sel_ir = 0;
        hmar = 0;
        busC = 8'h00;

        // Esperar un ciclo con reset
        #10;
        rst = 0;

        // Cargar valor en IR desde busC
        busC = 8'b10101010;
        ena_ir = 1;
        #10;
        ena_ir = 0;

        // Cambiar busC, pero no debería cambiar IR (ena_ir desactivado)
        busC = 8'b11110000;
        #10;

        // Cargar en MAR
        hmar = 1;
        #10;
        hmar = 0;

        // Reset y observar limpieza
        rst = 1;
        #10;
        rst = 0;

        #20;
        $stop;
    end

endmodule
