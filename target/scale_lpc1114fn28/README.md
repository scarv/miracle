
# SCALE ARM M0 Board / lpc1114fn28

*Description of the SCALE ARM M0 target*

---

This target is based off the [SCALE](https://github.com/dan-page/scale)
side-channel analysis boards.
Specifically, it targets the `lpc1114` SoC from NXP, containing a
3 stage ARM Cortex M0 CPU.

## Getting Started

To build and run an experiment on the target:

```sh
$> source bin/conf.sh
$> export UAS_ARM_TOOLCHAIN_ROOT=<path to 2016q3 ARM embedded toolchain>
$> make -B -f Makefile.experiment UAS_EXPERIMENT=example/addxor UAS_TARGET=scale_lpc1114fn28 program
```

If you're target device is not connected to `/dev/ttyUSB0`, you also need
to specify `USB_PORT=<port path>`.

---

**Useful links:**
- [NXP lpc1114 SoC Data Sheet](https://www.nxp.com/docs/en/data-sheet/LPC111X.pdf)
- [ARM Cortex M0 Technical reference](https://static.docs.arm.com/ddi0432/c/DDI0432C_cortex_m0_r0p0_trm.pdf)
- [ARM v6-M Architecture Reference Manual](https://static.docs.arm.com/ddi0419/e/DDI0419E_armv6m_arm.pdf)

