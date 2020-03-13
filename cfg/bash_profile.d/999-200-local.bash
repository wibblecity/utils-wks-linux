
### settings defaults for personal information
FIRST_NAME=""
LAST_NAME=""
DISPLAY_NAME=""
PHONE_NUMBERS=""
EMAIL_ADDRESSES=""
URLS=""

### including the local Bash profile components
THIS_TARGET_DIR="${BASH_PROFILE_LOCAL_D}"
create_directory "${THIS_TARGET_DIR}"
for PROFILE_FILE in `ls -1 ${THIS_TARGET_DIR} | grep .bash` ; do
  . ${THIS_TARGET_DIR}/${PROFILE_FILE}
  if [ "$?" -ne "0" ] ; then
    usage "WCI Local Bash Profile - Including file: ${THIS_TARGET_DIR}/${PROFILE_FILE} exited with errors"
  fi
  LOCAL_PROFILE_FILE_ARRAY[${LOCAL_PROFILE_FILE_ARRAY_COUNT}]="${THIS_TARGET_DIR}/${PROFILE_FILE}"
  LOCAL_PROFILE_FILE_ARRAY_COUNT=$((${LOCAL_PROFILE_FILE_ARRAY_COUNT} + 1))
done
#####
