
import  os
import  sys
import  logging as log

from    flask   import Flask

from    config  import DefaultConfig

sys.path.append(os.path.expandvars("$UAS_ROOT/tools/database"))

import  ldb


def connectToBackend(path, backend):
    """
    Returns an appropriate instance of a database backend based on
    the supplied path and backend parameters.
    """
    if(backend == "sqlite"):
        return ldb.backend.SQLiteBackend("sqlite:///"+path)
    else:
        raise Exception("Unknown backend '%s'" % backend)


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    # Load the application configuration
    app.config.from_object(DefaultConfig())

    log.basicConfig(level=app.config["LOG_LEVEL"])

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    db = connectToBackend(app.config["DB_PATH"],app.config["DB_BACKEND"])

    import pages
    app.register_blueprint(pages.bp)
    app.add_url_rule('/',endpoint="index")
    
    return app


def main():
    app = create_app()
    app.run()

if(__name__ == "__main__"):
    main()
