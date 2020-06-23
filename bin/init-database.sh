#!/bin/bash

echo "Creating Database: $UAS_DB"

# Initialise the database
$MIR_DB_REPO_HOME/cli.py -v $UAS_DB init

# Insert the set of targets:
TARGETS="`find $UAS_ROOT/target -maxdepth 2 -path "*.cfg"`"

$MIR_DB_REPO_HOME/cli.py -v $UAS_DB insert-targets --from-cfg $TARGETS

echo "---"
echo "Database Created."

