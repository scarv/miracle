
# SCALE ARM M3 Board / lpc1313fbd48

*Description of the SCALE ARM M3 target*

---

This target is based off the [SCALE](https://github.com/dan-page/scale)
side-channel analysis boards.
Specifically, it targets the `lpc1313` SoC from NXP, containing a
3 stage ARM Cortex M3 CPU.

## Getting Started

To build and run an experiment on the target:

```sh
$> source bin/conf.sh
$> export UAS_ARM_TOOLCHAIN_ROOT=<path to 2016q3 ARM embedded toolchain>
$> make -B -f Makefile.experiment UAS_EXPERIMENT=example/addxor UAS_TARGET=scale_lpc1313fbd48 program
```

If you're target device is not connected to `/dev/ttyUSB0`, you also need
to specify `USB_PORT=<port path>`.

## System Memory Map

Device      | Base          | Range    | High Address
------------|---------------|----------|----------------
Flash       | 0x00000000    | 32K      | 0x00007FFF
SRAM        | 0x10000000    |  8K      | 0x10001FFF

---

**Useful links:**
- [iNCP lpc1313 SoC Datasheet](https://www.nxp.com/docs/en/data-sheet/LPC1311_13_42_43.pdf)
- [ARM Cortex M3 Technical Reference Manual](https://static.docs.arm.com/ddi0337/h/DDI0337H_cortex_m3_r2p0_trm.pdf)
- [ARM v7-M Architecture Reference Manual](https://static.docs.arm.com/ddi0403/ed/DDI0403E_d_armv7m_arm.pdf)

