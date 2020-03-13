
THIS_USER="$(logname)"

### wci utils-wks configuration base directory
WCI_CFG_BASE=~/.wci
WCI_CFG_GIT="${WCI_CFG_BASE}/cfg/git"
WCI_CFG_GIT_SET_VARIABLES="${WCI_CFG_GIT}/git_config.bash"

### wci utils-wks installation path
WCI_WKS_UTILS_PATH="$(cat "${WCI_CFG_BASE}/wks_utils.path")"
if [ "$?" -ne "0" ] ; then
  usage "WCI Config - Cannot get WCI_WKS_UTILS_PATH from file: ${WCI_WKS_UTILS_PATH}"
fi

WCI_WKS_UTILS_GIT_CONFIGURE_WORKSPACE="${WCI_WKS_UTILS_PATH}/bin/wci-git-configure_workspace"

WCI_WKS_CFG_TEMPLATES_PATH="${WCI_WKS_UTILS_PATH}/cfg/templates"



### bash profile directory for wci apps to use for non-interactive shells
BASH_PROFILE_NI_APPS_D=~/.bash_profile-ni.wci-apps.d

### bash profile directory for local to use for non-interactive shells
BASH_PROFILE_NI_LOCAL_D=~/.bash_profile-ni.local.d
BASH_PROFILE_LOCAL_D=~/.bash_profile.local.d
declare -a LOCAL_PROFILE_FILE_ARRAY
LOCAL_PROFILE_FILE_ARRAY_COUNT="0"

### customisable shell configuration
WCI_ENABLE_PROMPT="TRUE"

WCI_ENABLE_BANNER="TRUE"
WCI_ENABLE_BANNER_CONTACTS_AND_LINKS="TRUE"
WCI_ENABLE_BANNER_SYSTEM_INFO="TRUE"

### enable wci logging functionality
WCI_ENABLE_LOGGING="${WCI_ENABLE_LOGGING:-TRUE}"

### enable wci logging while piped functionality
WCI_ENABLE_LOGGING_WHILE_INPUT_IS_PIPED="${WCI_ENABLE_LOGGING_WHILE_INPUT_IS_PIPED:-TRUE}"
WCI_ENABLE_LOGGING_WHILE_OUTPUT_IS_PIPED="${WCI_ENABLE_LOGGING_WHILE_OUTPUT_IS_PIPED:-TRUE}"

### enable wci logging functionality
WCI_ENABLE_DISPLAY_EXECUTION_ENVIRONMENT_VARIABLES="${WCI_ENABLE_DISPLAY_EXECUTION_ENVIRONMENT_VARIABLES:-FALSE}"

HISTSIZE="1000000"
