#!/bin/sh
#
# Cloud Hook: post-db-copy
#
# The post-db-copy hook is run whenever you use the Workflow page to copy a
# database from one environment to another. See ../README.md for
# details.
#
# Usage: post-db-copy site target-env db-name source-env

site="$1"
target_env="$2"
db_name="$3"
source_env="$4"
drush_cmd="/var/www/html/${site}.${target_env}/vendor/bin/drush"

echo "$site.$target_env: Received copy of database $db_name from $source_env."
echo "Sanitizing database $db_name on $site.$target_env..."
$drush_cmd @${site}.${target_env} status
$drush_cmd @${site}.${target_env} sql:sanitize -y
$drush_cmd @${site}.${target_env} cr

echo "$(date) Post DB Copy Triggered" >> /tmp/post-db-copy.log
