
import  os
import  sys
import  logging as log

from    flask   import Flask

sys.path.append(os.path.expandvars("$UAS_ROOT/tools/database"))

from    config  import DefaultConfig

from    db      import db_connect



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

    import pages
    app.register_blueprint(pages.bp)
    app.add_url_rule('/',endpoint="index")

    import targets
    app.register_blueprint(targets.bp)
    
    return app


def main():
    app = create_app()
    app.run()

if(__name__ == "__main__"):
    main()
