
# Directory Structure

*Briefly details how the project is organised.*

---

```
$UAS_ROOT/
├── bin                         -
│   └── conf.sh                 - Workspace setup script.
├── docs                        - All project documentation, such as it is.
├── experiments                 - Contains all source codes for experiments.
│   ├── countermeasures         - Experiment catagory directory.
│   │   └── rosita-ld-ld-0      - A single experiment.
│   ├── memory-bus              -
│   ├── pipeline                -
│   ├── regfile                 -
│   └── speculation             -
├── external                    - Git submodule dependencies.
│   ├── fw-acquisition          - Acquisition framework for device comms.
│   └── scale-hw                - scale  target support files.
├── Makefile                    - Top level makefile.
├── Makefile.build              - Makefile for building experiments.
├── Makefile.common             - Common variables used across makefiles.
├── Makefile.program            - Makefile for programming devices.
├── README.md                   - Top level README.
├── requirements.txt            - Python3 module dependencies.
├── target                      - Target devices folder
│   ├── [target device]         - A single target device
│   │   ├── [target device].cfg - Configuration data for the device.
│   │   ├── build               - Build related makefiles & tools.
│   │   ├── program             - Programming related makefiles & tools.
│   │   ├── capture             - Oscilliscope configuration etc.
│   │   └── bsp                 - SoC/Board source code support files.
│   └── share                   - Common files used across all targets.
├── tools                       - Tools for managing data and tasks.
│   ├── browser                 - Analysis results web browser interface.
│   ├── database                - Trace & analysis database.
│   ├── flow                    - Trace capture & analysis flow scripts.
│   └── kernel-gen              - Target macro definitions.
└── work                        - Build & capture artifacts go here.
    └── database.sqlite         - Results database.
```
