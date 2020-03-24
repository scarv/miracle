
# Database

*Describes the database used to manage experiment data and analysis
 results.*

---


- The results database is responsible for:

  - Storing information on target devices

  - Storing captured experiment data and relating that back to the
    device it was captured for.

  - Storing analysis results for experiment data.

  - Acting as a backend to the results browser, and an easy way to
    share results data.

- The database is built using
  [SQLAlchemy](https://www.sqlalchemy.org/)
  as an interface layer
  and [SQLite](https://sqlite.org/index.html)
  as the backend.

- Source code for managing the database is kept in
  `tools/database/`.

  - `tools/database/ldb/` Contains the database schema and Python3 modules
    for initialising and accessing it.

  - `tools/database/cli.py` is a simple front-end script for performing
    ad-hoc querying and management of the database.

    Running:
    ```sh
    ./tools/database/cli.py --help
    ```
    Will show how to use the CLI script.

- Captured experiment data is inserted into the database by the
  `tools/flow/CaptureInterface.py` module.

- Experiment analysis data is extracted and inserted by the
  `tools/flow/AnalysisInterface.py` module.

