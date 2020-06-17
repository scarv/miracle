import logging as log
import os
import sys

from flask import Flask
from waitress import serve

sys.path.append(os.path.expandvars("$UAS_ROOT/tools/database"))

from config import DefaultConfig


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    # Load the application configuration
    app.config.from_object(DefaultConfig())

    log.basicConfig(level=app.config["LOG_LEVEL"])

    log.info("Database file: '%s'" % app.config["DB_PATH"])

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    import pages
    app.register_blueprint(pages.bp)
    app.add_url_rule('/', endpoint="index")

    import targets
    app.register_blueprint(targets.bp)

    import experiments
    app.register_blueprint(experiments.bp)

    import plot
    app.register_blueprint(plot.bp)

    return app


def main():
    app = create_app()
    serve(app)


if (__name__ == "__main__"):
    main()
