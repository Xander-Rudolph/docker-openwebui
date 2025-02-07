#!/bin/bash

# # Handle file ownership as root... which doesn't seem to work...
# inotifywait -m -r --format '%w%f' \
#   -e create -e moved_to -e modify \
#   /data/models |
# while IFS= read -r file; do
#   chown sduser:sduser "$file" || true
# done &

# # force permissions... also doesn't help
# umask 0002

# Just force update the owner for christake... restart is required
chown -R sduser:sduser /outputs /data

# Switch to sduser and execute the original command
exec gosu sduser "$@"
