
# Getting Started

---

## Checking out the repository

```sh
git checkout https://github.com/scarv/uarch-leakage.git
cd uarch-leakage
git submodule update --init --recursive
```

## Installing Dependencies

### Python3 Required Modules

- From the root of the repository, run:

  ```sh
  pip3 install -r requirements.txt
  ```
  
  to install all standard required python modules for the project.


- You will also need to install the drivers and Python3 API wrappers
  for the PicoScope 5000 oscilliscope.
  Instructions for this are found
  [here](https://github.com/picotech/picosdk-python-wrappers).


## Toolchains

Not all toolchains need to be installed.
Only the ones for the targets which you care about.

### ARM

- The project has so far used the ARM 2016 Q1 toolchain.

- Download from
  [this](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads/5-2016-q1-update)
  page.

- Once installed, you must point the `UAS_ARM_TOOLCHAIN_ROOT`
  environment variable at the root of the installation:

  ```
  export UAS_ARM_TOOLCHAIN_ROOT=/path/to/installation
  ```

### Intel ISSM

- This is required only for the `intel_d2000` target.

- Download from [here](https://software.intel.com/en-us/articles/issm-toolchain-only-download)

- Once installed, you must point the `IAMCU_TOOLCHAIN_DIR`
  environment variable at the root of the installation:

  ```
  export IAMCU_TOOLCHAIN_DIR=/path/to/installation
  ```

### RISC-V

- A RISC-V toolchain can be easily 
  [built from scratch](https://github.com/riscv/riscv-gnu-toolchain),
  or
  [downloaded from SiFive](https://www.sifive.com/boards).

- Once installed, you must point the `RISCV`
  environment variable at the root of the installation:

  ```
  export RISCV=/path/to/installation
  ```

### Vivado and MicroBlaze

- Vivado and the Microblaze toolchain (required for the `sakurax_*` targets)
  can be downloaded from
  [here](https://www.xilinx.com/products/design-tools/vivado.html)

  - The project has so far been tested with version `2019.1`.

- After installation:

  - Set the `VIVADO_ROOT` environment variable to the root of the vivado
    installation.

  - Likewise, set the `UAS_MICROBLAZE_TOOLCHAIN_ROOT` environment
    variable to the root of the Microblaze toolchain installation.

    This is usually under `/opt/Xilinx/SDK/<VERSION>/gnu/microblaze/bin`


