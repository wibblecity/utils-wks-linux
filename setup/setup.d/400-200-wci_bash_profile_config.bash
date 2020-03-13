
log_event "Configuring profile for interactive users"
update_symlink "${WCI_BASH_PROFILE_D_PATH}" "${APP_PATH}/cfg/bash_profile.d"
if [ -f "${LOCAL_BASH_PROFILE}" ] ; then
  THIS_BACKUP_DIR="${WCI_CFG_BASE}/backups/bash_profile"
  mkdir -p "${THIS_BACKUP_DIR}"
  TIME_STAMP=`date "+%Y%m%d%H%M%S"`
  cp "${LOCAL_BASH_PROFILE}" "${THIS_BACKUP_DIR}/bash_profile.${TIME_STAMP}"
  LOCAL_BASH_PROFILE_CONTENTS=`grep -v "### WCI PROFILE HOOK" ~/.bash_profile`
fi
echo "${LOCAL_BASH_PROFILE_CONTENTS}" > "${LOCAL_BASH_PROFILE}"
echo "for PROFILE_FILE in \`ls -1 "${WCI_BASH_PROFILE_D_PATH}" | grep ".bash$"\` ; do . \""${WCI_BASH_PROFILE_D_PATH}"/\${PROFILE_FILE}\" ; done ### WCI PROFILE HOOK" >> "${LOCAL_BASH_PROFILE}"
log_event

log_event "Configuring profile for non-interactive users"
update_symlink "${NI_PROFILE_D_PATH}" "${APP_PATH}/cfg/bash_profile-ni.d"
echo "for PROFILE_FILE in \`ls -1 "${NI_PROFILE_D_PATH}" | grep ".bash$"\` ; do . \""${NI_PROFILE_D_PATH}"/\${PROFILE_FILE}\" ; done" > "${NI_PROFILE_FILE}"
echo >> "${NI_PROFILE_FILE}"
echo 'set_execution_environment_variables' >> "${NI_PROFILE_FILE}"
echo >> "${NI_PROFILE_FILE}"
log_event
