#!/bin/bash

echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_user_name": "$IPLANT_USER", "irods_zone_name": "iplant"}' | envsubst > $HOME/.irods/irods_environment.json
cd $HOME
cd circos-binder
# retrieve notebooks and place correctly in session
rm index.ipynb
rm Getting_Circos_Up_and_Running.ipynb
git clone https://github.com/fomightez/cbr-accompmatz.git
cp cbr-accompmatz/index.ipynb .
cp cbr-accompmatz/Getting_Circos_Up_and_Running.ipynb .
mv cbr-accompmatz/notebooks .
rm -rf cbr-accompmatz

exec jupyter lab --no-browser