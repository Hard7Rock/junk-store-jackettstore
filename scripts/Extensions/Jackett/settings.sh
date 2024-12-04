#!/bin/bash 
if [[ -f "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas/jacketttabconfig.json" ]]; then
    TEMP="${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas/jacketttabconfig.json"
else
    TEMP="${DECKY_PLUGIN_DIR}/conf_schemas/jacketttabconfig.json"
fi
eval $(jq -r  '.Sections[] | "\(.Name | ascii_upcase)_\(.Options[0].Key | ascii_upcase)=\"\(.Options[0].Value)\""' $TEMP )
eval $(jq -r  '.Sections[] | "\(.Name | ascii_upcase)_\(.Options[1].Key | ascii_upcase)=\"\(.Options[1].Value)\""' $TEMP )
eval $(jq -r  '.Sections[] | "\(.Name | ascii_upcase)_\(.Options[2].Key | ascii_upcase)=\"\(.Options[2].Value)\""' $TEMP )
