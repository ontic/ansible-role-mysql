#!/bin/bash

# Verify the installed MySQL version.
docker exec --tty ${container_id} env TERM=xterm mysql -V