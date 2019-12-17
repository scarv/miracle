
import os

from flask import Flask

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

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
    
    import experiments
    app.register_blueprint(experiments.bp)

    return app

def main():
    app = create_app()

    app.run()

if(__name__ == "__main__"):
    main()
