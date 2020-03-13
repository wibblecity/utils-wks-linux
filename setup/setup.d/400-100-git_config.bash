
log_event "Configuring Git"
create_directory "${WCI_CFG_GIT}"
log_event

### wci config
log_event " Updating Git config template"
THIS_FILE_NAME="git_config.template"
THIS_SOURCE_PATH="${WCI_WKS_CFG_TEMPLATES_PATH}/git"
THIS_FILE_PATH="${WCI_CFG_GIT}/${THIS_FILE_NAME}"
if [ ! -f "${THIS_SOURCE_PATH}/${THIS_FILE_NAME}" ] ; then
  usage "Git config template file is missing: ${THIS_SOURCE_PATH}/${THIS_FILE_NAME}"
fi
cp ${THIS_SOURCE_PATH}/${THIS_FILE_NAME} ${THIS_FILE_PATH}
#####
