
log_event "Updating local Bash profile components"
create_directory "${BASH_PROFILE_LOCAL_D}"

### wci config
log_event " Updating WCI config"
THIS_FILE_NAME="wci_config.template"
THIS_FILE_PATH="${BASH_PROFILE_LOCAL_D}/${THIS_FILE_NAME}"
echo > "${THIS_FILE_PATH}"
echo '### Rename this file to wci_config.bash to configure the WCI shell environment' >> "${THIS_FILE_PATH}"
echo '' >> "${THIS_FILE_PATH}"
echo '## Uncomment this to disable the bash prompt modifications' >> "${THIS_FILE_PATH}"
echo '# WCI_ENABLE_PROMPT="FALSE"' >> "${THIS_FILE_PATH}"
echo '' >> "${THIS_FILE_PATH}"
echo '## Uncomment this to disable the login banner' >> "${THIS_FILE_PATH}"
echo '# WCI_ENABLE_BANNER="FALSE"' >> "${THIS_FILE_PATH}"
echo '' >> "${THIS_FILE_PATH}"
echo '## Uncomment this to disable the login banner contacts and links section' >> "${THIS_FILE_PATH}"
echo '# WCI_ENABLE_BANNER_CONTACTS_AND_LINKS="FALSE"' >> "${THIS_FILE_PATH}"
echo '' >> "${THIS_FILE_PATH}"
echo '## Uncomment this to disable the login banner system information section' >> "${THIS_FILE_PATH}"
echo '# WCI_ENABLE_BANNER_SYSTEM_INFO="FALSE"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
#####

### personal information
log_event " Updating personal information"
THIS_FILE_NAME="personal_info.template"
THIS_FILE_PATH="${BASH_PROFILE_LOCAL_D}/${THIS_FILE_NAME}"
echo > "${THIS_FILE_PATH}"
echo '### Rename this file to personal_info.bash to configure the WCI shell environment' >> "${THIS_FILE_PATH}"
echo '### Edit this file to add your personal information' >> "${THIS_FILE_PATH}"
echo '# FIRST_NAME="Joe"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
echo '# LAST_NAME="Bloggs"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
echo '# DISPLAY_NAME="Joe the Space Cadet"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
echo '# PHONE_NUMBERS="Personal:[PERSONAL PHONE NUMBER], Work:[WORK PHONE NUMBER]"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
echo '# EMAIL_ADDRESSES="Personal:[PERSONAL EMAIL ADDRESS], Work:[WORK EMAIL ADDRESS]"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
echo '# URLS="Git:[GIT URL], Website:[WEBSITE URL], Facebook:[FACEBOOK URL], LinkedIn:[LINKEDIN URL]"' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
#####

### search path
log_event " Updating search paths"
THIS_FILE_NAME="search_path.template"
THIS_FILE_PATH="${BASH_PROFILE_LOCAL_D}/${THIS_FILE_NAME}"
echo > "${THIS_FILE_PATH}"
echo '### Rename this file to search_path.bash to configure the WCI shell environment' >> "${THIS_FILE_PATH}"
echo '### Edit this file to add local search path config' >> "${THIS_FILE_PATH}"
echo '# PATH=${PATH}:[LOCAL PATH CONFIGURATION]' >> "${THIS_FILE_PATH}"
echo >> "${THIS_FILE_PATH}"
#####
