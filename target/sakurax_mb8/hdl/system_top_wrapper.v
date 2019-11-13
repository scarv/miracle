//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Wed May 15 08:47:50 2019
//Host        : ben running 64-bit Ubuntu 18.04.2 LTS
//Command     : generate_target system_top_wrapper.bd
//Design      : system_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_top_wrapper
   (top_clk_clk_n,
    top_clk_clk_p,
    top_gpio_tri_o,
    top_reset,
    top_uart_rxd,
    top_uart_txd);
  input top_clk_clk_n;
  input top_clk_clk_p;
  output [1:0]top_gpio_tri_o;
  input top_reset;
  input top_uart_rxd;
  output top_uart_txd;

  wire top_clk_clk_n;
  wire top_clk_clk_p;
  wire [1:0]top_gpio_tri_o;
  wire top_reset;
  wire top_uart_rxd;
  wire top_uart_txd;

  system_top system_top_i
       (.top_clk_clk_n(top_clk_clk_n),
        .top_clk_clk_p(top_clk_clk_p),
        .top_gpio_tri_o(top_gpio_tri_o),
        .top_reset(top_reset),
        .top_uart_rxd(top_uart_rxd),
        .top_uart_txd(top_uart_txd));
endmodule
