#!/bin/bash

# Verify the installed MySql version.
docker exec --tty ${container_id} env TERM=xterm mysql -V