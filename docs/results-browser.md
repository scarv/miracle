
# Results Browser

*Describes the results browser web app.*

---

- The results browser is a very simple web app built using the
  [Flask](https://flask.palletsprojects.com/en/1.1.x/)
  Python application framework.

- It interfaces with the results database to present
  information on target devices, experiments, captured data
  and analyses.

- The browser can be starting by running the following commands
  from the root of the repository:

  ```sh
  $> source bin/conf.sh
  $> make -C $UAS_ROOT/tools/browser run
  make: Entering directory '/home/work/scarv/uarch-leakage/tools/browser'
  python3 app/wsgi.py
  INFO:root:Database file: '/home/work/scarv/uarch-leakage/work/database.sqlite'
   * Serving Flask app "wsgi" (lazy loading)
   * Environment: development
   * Debug mode: on
  INFO:werkzeug: * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
  ```

- This will start the server running.
  Navigating to the "Running on" address in a web-browser will show
  the app landing page.

- By default, the database the app connects too is the one
  pointed at by the environment variable `$UAS_DB`.

