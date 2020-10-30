#!/usr/bin/python3

"""
This script is for preparing the working traces database for upload to
the Miracle EC2 instance. It:
- Creates a file-system level copy
- Removes all of the raw trace sets
- Vacuums the coppied file to make it as small as possible.
"""

import sys
import os
import shutil
import logging as log
import argparse
import sqlite3

def build_argparser():
    parser = argparse.ArgumentParser()

    parser.add_argument("src_db",type=str,
        help="path to the database to prepare for upload")

    return parser

def main():
    parser  = build_argparser()
    args    = parser.parse_args()
    
    in_db_file_path     = os.path.abspath(args.src_db)
   
    log.info("Database file to Vacuum: %s" % in_db_file_path)
    conn            = sqlite3.connect(in_db_file_path)
    log.info("Vaccuming Database...")
    vacuum_query = "VACUUM;"
    log.info("> %s" % vacuum_query)
    conn.execute(vacuum_query)

    conn.close()

    sys.exit(0)


if(__name__=="__main__"):
    log.basicConfig(level=log.INFO)
    main()
