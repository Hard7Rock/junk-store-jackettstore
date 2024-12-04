#!/bin/sh
#
PLATFORMS+=("Jackett")

if [[ "${PLATFORM}" == "Jackett" ]]; then
    source "${DECKY_PLUGIN_DIR}/scripts/${Extensions}/Jackett/settings.sh"
fi


function Jackett_init() {
	echo ""
}

function Jackett_refresh() {
    TEMP=$(Jackett_init)
    echo "{\"Type\": \"RefreshContent\", \"Content\": {\"Message\": \"Refreshed\"}}"
}

function Jackett_loginstatus(){
	echo ""
}

function Jackett_refresh() {
	echo ""
}
function Jackett_getgames(){
    get_steam_env
    SEARCH_RESULT="[]"
    if [ -z "${1}" ]; then
        FILTER=""
    else
        FILTER="${1}"
	if [[ ${#FILTER} >3 ]]; then
		SEARCH_RESULT_FILE="/tmp/jackett_search_result.json"
		curl -f  "${TORRENT_JACKETURL}/api/v2.0/indexers/all/results?apikey=${TORRENT_JACKETAPIKEY}&Category=1000&Query=$(echo ${FILTER} | tr " " "+" )" -o $SEARCH_RESULT_FILE
		SEARCH_RESULT=$(jq '.Results[] | {"Name": .Description, "Images":[],"ShortName": .Title, "SteamClientId": null}' $SEARCH_RESULT_FILE | jq -s)
	fi
    fi
    if [ -z "${2}" ]; then
        INSTALLED="false"
    else
        INSTALLED="${2}"
    fi
     if [ -z "${3}" ]; then
        LIMIT="true"
    else
        LIMIT="${3}"
    fi
    #{"Type": "GameGrid", "Content": {"NeedsLogin": "true", "Games": []}}

    TEMP="{\"Type\": \"GameGrid\", \"Content\": {\"NeedsLogin\": \"true\", \"Games\": $SEARCH_RESULT}}"
    echo $TEMP
}
function Jackett_saveplatformconfig(){
	echo ""
}
function Jackett_getplatformconfig(){
	echo ""
}
function Jackett_cancelinstall(){
	#todo
    echo "{\"Type\": \"Success\", \"Content\": {\"Message\": \"${1} installation Cancelled\"}}"
}
function Jackett_download(){
	#todo
    echo "{\"Type\": \"Progress\", \"Content\": {\"Message\": \"Downloading\"}}"
}
function Jackett_getprogress(){
	#todo
	echo '{"Type": "ProgressUpdate", "Content": null}'
#{"Type": "ProgressUpdate", "Content": {"Percentage": 0.0, "Description": "Downloaded 0.0 MB/83.78 MB (0.0%)\nSpeed: 0.00 MB/s"}}

#{"Type": "ProgressUpdate", "Content": {"Percentage": 37.0, "Description": "Downloaded 17.75 MB/29.85 MB (37.0%)\nSpeed: 18.99 MB/s"}}
#{"Type": "ProgressUpdate", "Content": {"Percentage": 99, "Description": "Downloaded 29.85 MB/29.85 MB (99%)\nSpeed: 12.99 MB/s"}}
#{"Type": "ProgressUpdate", "Content": {"Percentage": 100, "Description": "Finished installation process"}}


	
}
function Jackett_update(){
	echo ""
}
function Jackett_install-overlay(){
	echo ""
}
function Jackett_update-overlay(){
	echo ""
}
function Jackett_remove-overlay(){
	echo ""
}
function Jackett_download-saves(){
	echo ""
}
function Jackett_verify(){
	echo ""
}
function Jackett_protontricks(){
	echo ""
}
function Jackett_import(){
	echo ""
}
function Jackett_move(){
	echo ""
}
function Jackett_install(){
	echo ""
}
function Jackett_getlaunchoptions(){
	echo ""
}
function Jackett_uninstall(){
	echo ""
}
function Jackett_getgamedetails(){
ENTRY=$(jq --arg searchTitle "$1" '.Results[] | select(.Title == $searchTitle)'  /tmp/jackett_search_result.json)

curl --silent $(echo $ENTRY | jq -r  ".Guid" ) -o /tmp/jackett_game_page.html

IMG=$(htmlq -a title '.img-right' -f  /tmp/jackett_game_page.html)
DESCR=$(htmlq --text '.post_body div .q' -f  /tmp/jackett_game_page.html)
echo $DESCR >> /tmp/debug.log


echo '{"Type":"GameDetails","Content":{"Title":"TEST","Description":"AAAAAaaAAAAAaaaAAA","ApplicationPath":null,"ManualPath":null,"RootFolder":null,"ConfigurationPath":null,"SteamClientID":null,"ShortName":"TEST Short name","Editors":[],"Images":["https://images.gog.com/3c857012e2ecba738202b5ecf92eb6e7631527472149204cf6305473a428ce18.jpg?namespace=gamesdb"]}}' | jq --arg title "$1" --arg descr "$DESCR" --arg img "$IMG" '.Content.Title = $title |  .Content.Description = $descr | .Content.Images[0] = $img'
}


function Jackett_getgamesize(){
	echo "{\"Type\": \"GameSize\", \"Content\": {\"DiskSize\": \"\"}}"
}
function Jackett_loginstatus(){
	get_steam_env

	STATUS="{\"Type\": \"LoginStatus\", \"Content\": {\"Username\": \"$TORRENT_JACKETURL\", \"LoggedIn\""
	curl -f  "$TORRENT_JACKETURL/api/v2.0/indexers/all/results?apikey=$TORRENT_JACKETAPIKEY&Query=Cowboy Bebop" && \
	echo "$STATUS: true}}" || \
	echo "$STATUS: false}}"

}
#function Jackett_enable-eos-overlay(){
#	echo ""
#}
#function Jackett_disable-eos-overlay(){
#	echo ""
#}
function Jackett_run-exe(){
	echo ""
}
function Jackett_registry-fix(){
	echo ""
}
function Jackett_login(){
	echo ""
}
function Jackett_login-launch-options(){
	echo ""
}
function Jackett_logout(){
	echo ""
}
function Jackett_getsetting(){
	echo '{"Type": "Setting", "Content": {"name": "1", "value": ""}}'
}
function Jackett_savesetting(){
	echo ""
}
function Jackett_gettabconfig() {
# Check if conf_schemas directory exists, create it if not
    if [[ ! -d "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas" ]]; then
        mkdir -p "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas"
    fi
    if [[ -f "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas/jacketttabconfig.json" ]]; then
        TEMP=$(cat "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas/jacketttabconfig.json")
    else
        TEMP=$(cat "${DECKY_PLUGIN_DIR}/conf_schemas/jacketttabconfig.json")
    fi
    echo "{\"Type\":\"IniContent\", \"Content\": ${TEMP}}"
}

function Jackett_savetabconfig() {
    cat > "${DECKY_PLUGIN_RUNTIME_DIR}/conf_schemas/jacketttabconfig.json"
    echo "{\"Type\": \"Success\", \"Content\": {\"Message\": \"Jackett tab config saved\"}}"
}

function Jackett_getjsonimages(){
	echo ""
}
