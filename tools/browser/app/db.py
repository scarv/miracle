
import  os
import  sys
import  logging as log

from    flask   import Flask, current_app, g

from    config  import DefaultConfig

import  ldb


def db_connect():
    """
    Creates a database backend object for the current request.
    """
    db_path     = current_app.config["DB_PATH"]
    db_backend  = current_app.config["DB_BACKEND"]

    if(db_backend == "sqlite"):
        g.db = ldb.backend.SQLiteBackend("sqlite:///"+db_path)
    else:
        raise Exception("Unknown backend '%s'" % backend)

    return g.db


def db_close():
    db = g.pop('db',None)

    if(db is not None):
        db.close()
