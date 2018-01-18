#!/bin/bash

# define path to install
install_path="/opt/moviegrabber"

# pex currently has a bug which is preventing local modules from loading, this
# is the workaround for now (20180117)
export PYTHONPATH="${install_path}"

# run moviegrabber using pex package
"${install_path}/lib/pex/MovieGrabber-linux64.pex" "${install_path}/MovieGrabber.py" --config /config/config --certs /config/certs --db /config/db --logs /config/logs
