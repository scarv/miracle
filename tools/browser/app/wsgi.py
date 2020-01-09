
import  os
import  logging as log

from    flask   import Flask

from    config  import DefaultConfig

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
    
    import experiments
    app.register_blueprint(experiments.bp)

    for experiment_results_dir in app.config["EXPERIMENT_DIRS"]:
        experiments.discoverExperimentsInDirectory(experiment_results_dir)

    import targets
    app.register_blueprint(targets.bp)

    for target_name in targets.bp.target_devices:
        targets.bp.target_devices[target_name].discoverExperimentsForTarget(
            experiments.bp.experiments
        )

    return app

def main():
    app = create_app()
    app.run()

if(__name__ == "__main__"):
    main()
