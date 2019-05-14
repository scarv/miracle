
# Sakura-X Microblaze 3 Stage

*Description of the Sakura-X FPGA Microblaze 3 stage softcore target.*

---

This target is an FPGA CPU Softcore: The *Microblaze* provided by Xilinx.
The *Microblaze* is a highly configurable soft CPU design, which can be
included as a managment core in larger FPGA systems.

The target FPGA platform is a SAKURA-X development board
(see links below, also known as the Sasebo-GIII),
designed for side-channel analysis.
It consists of a Xilinx Kintex-7 `xc7k160tfbg676-3` target FPGA, and a
Xilinx Spartan-6 `xc6lx45-fgg484c-3` companion FPGA.
We use only the Kintex-7 FPGA for this target, the Spartan-6 companion FPGA
is left un-programmed.

This target configures the Microblaze as follows:
- Pipeline Stages: 3
- Instruction & Data AXI Bus
- Instruction & Data Local Memory Bus
- HW Integer Divider: Enabled
- HW Multiplier: Enabled
- Barrel Shifter: Enabled
- Exception Catching / Raising
- Debug Interface Support
- Implementation Strategy: Area Optimised
- MMU: None


The wider SoC system implemented on the FPGA consists of:
- The Microblaze CPU
  - Local memory bus access to 8K of BRAMs
  - Microblaze Debug module
- An AXI interconnect
  - AXI Access to 32K of BRAMs
  - 2 GPIO Pins
  - UART - 9600 Baud
- Processor System Reset Module
- Clock Generator Core - 12.5 Mhz

Notes:
- The AXI interconnect has an register stage between the master and
  slave ports.
- The LMB interfaces have no such registering.

## System Memory Map

Device      | Base          | Range    | High Address
------------|---------------|----------|----------------
UART        | 0x40600000    |  4K      | 0x40600FFF
GPIO        | 0x40000000    |  4K      | 0x40000FFF
LMB BRAM    | 0x10000000    |  8K      | 0x10001FFF
AXI BRAM    | 0x00000000    | 32K      | 0x00007FFF

## Pin Locations

Pin     | SAKURA-X Pin Name     | RTL Signal Name
--------|-----------------------|-----------------------------------------------
`AC2`   | `K_CLK_OSC0_HSTL_N`   | `top_clk_clk_n`
`AB2`   | `K_CLK_OSC0_HSTL_P`   | `top_clk_clk_p`
`D19`   | `K_HEADER_0`          | `top_uart_rxd`
`N17`   | `K_HEADER_1`          | `top_uart_txd`
`N16`   | `K_HEADER_2`          | `top_gpio_tri_o[0]` (Trigger)
`G20`   | `K_LED_0`             | `top_gpio_tri_o[1]` (Debug LED)
`L19`   | `K_LED_1`             | ?
`K18`   | `K_LED_3`             | ?
`H19`   | `K_LED_4`             | ?
`L23`   | `K_PUSHSW`            | `top_reset`

---

**Useful Links:**
- [SAKURA-X FPGA Development Platform](http://satoh.cs.uec.ac.jp/SAKURA/hardware/SAKURA-X.html)
  - [Purchasing](http://www.troche.com/sakura/order.html)
- [Xilinx UG984 Microblaze Processor Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_3/ug984-vivado-microblaze-ref.pdf)
