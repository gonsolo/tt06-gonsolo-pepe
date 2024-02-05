/*
 * Copyright (c) 2023 Gonsolo
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_gonsolo_pepe (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);


  assign uio_out = 0;
  assign uio_oe  = 0;

  //wire [31:0] a = 32'h40000000; // 2.0
  wire [31:0] a = { ui_in, 24'h000000 }; // 2.0, first 8 bits from test.py
  //wire [31:0] b = 32'h40000000; // 2.0
  wire [31:0] b = { uio_in, 24'h000000 }; // 2.0, ditto
  wire out_valid;
  wire [31:0] out;
  // out should be 32'h40800000
  assign uo_out = out[31:24];
  // uo_out should be 8'h40

  wire _unused_ok = &{
          1'b0,
	  ena,
	  clk,
	  rst_n,
	  out,
          1'b0};

  Multiply multiply(
	.clock(clk),
	.reset(~rst_n),
	.io_a_bits(a),
	.io_b_bits(b),
	.io_out_valid(out_valid),
	.io_out_bits(out)
	);

endmodule
