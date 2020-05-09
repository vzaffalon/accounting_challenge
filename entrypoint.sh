#!/bin/bash
set -e

# If the database exists, migrate. Otherwise setup (create and migrate)
# bundle exec rake db:migrate > /dev/null || bundle exec rake db:create db:migrate db:seed
echo "Done!"

# built_lock_file="/tmp/Gemfile.lock"
# current_lock_file="/app/Gemfile.lock"

# function cp_built_lock_file() {
#     cp "${built_lock_file}" "${current_lock_file}"
# }

# if [ -f "${current_lock_file}" ]; then
#     diff="$(diff "${built_lock_file}" "${current_lock_file}")"
#     if [ "${diff}" != "" 2>/dev/null ]; then
#         cp_built_lock_file
#     fi
# else
#     cp_built_lock_file
# fi

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"