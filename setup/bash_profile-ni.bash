
for PROFILE_FILE in `ls -1 "${SCRIPT_DIR_PARENT_1}/cfg/bash_profile-ni.d" | grep .bash` ; do
  . "${SCRIPT_DIR_PARENT_1}/cfg/bash_profile-ni.d/${PROFILE_FILE}"
done
