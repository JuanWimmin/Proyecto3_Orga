module System (
    input wire clk,
    input wire rst,
    input wire ena_ir,
    input wire sel_ir,
    input wire hmar,
    input wire [7:0] busC,
    output wire [4:0] opcode,
    output wire [7:0] bus_dir
);

    // Instancia de IR
    IR ir_inst (
        .clk(clk),
        .rst(rst),
        .ena(ena_ir),
        .sel(sel_ir),
        .busC(busC),
        .opcode(opcode)
    );

    // Instancia de MAR
    MAR mar_inst (
        .CLK(clk),
        .RESET(rst),
        .BUS_C(busC),
        .HMAR(hmar),
        .BUS_DIR(bus_dir)
    );

endmodule
