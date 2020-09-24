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
    new_db_file_dir     = os.path.dirname(in_db_file_path)
    new_db_file_name    = "temp-" + os.path.basename(in_db_file_path)
    new_db_file_path    = os.path.join(new_db_file_dir, new_db_file_name)
   
    log.info("Database file to upload: %s" % in_db_file_path)
    log.info("Temp Database file:      %s" % new_db_file_path)
    log.info("Copying...")
    shutil.copyfile(in_db_file_path, new_db_file_path)

    log.info("Connecting...")
    conn            = sqlite3.connect(new_db_file_path)
    
    log.info("Updating columns...")
    update_query    = "UPDATE traceset_blobs SET traces = NULL;"
    log.info("> %s" % update_query)
    conn.execute(update_query)
    
    log.info("Committing changes...")
    conn.commit()

    log.info("Vaccuming Database...")
    vacuum_query = "VACUUM;"
    log.info("> %s" % vacuum_query)
    conn.execute(vacuum_query)

    conn.close()
    log.info("Ready for upload: %s" % new_db_file_path)

    sys.exit(0)


if(__name__=="__main__"):
    log.basicConfig(level=log.INFO)
    main()
