
if [ "${WCI_ENABLE_BANNER}" == "TRUE" ] ; then

  TITLE_INDENT='#'

  if [ ! -z "${DISPLAY_NAME}" ] ; then
    THIS_DISPLAY_NAME="${DISPLAY_NAME}"
  elif [ ! -z "${FIRST_NAME}" ] ; then
    THIS_DISPLAY_NAME="${FIRST_NAME}"
  else
    THIS_DISPLAY_NAME=""
  fi

  if [ ! -z "${FIRST_NAME}" ] ; then
    if [ ! -z "${LAST_NAME}" ] ; then
      THIS_FULL_NAME="${FIRST_NAME} ${LAST_NAME}"
    else
      THIS_FULL_NAME="${FIRST_NAME}"
    fi
  else
    THIS_FULL_NAME=""
  fi

  echo
  echo "#####  Welcome to WibbleCity  #####"
  echo
  if [ ! -z "${THIS_FULL_NAME}" ] ; then
      echo "Name: ${THIS_FULL_NAME}"
  fi
  echo "Username: ${THIS_USER}"
  echo "Hostname: `hostname`"
  echo

  if [ "${WCI_ENABLE_BANNER_CONTACTS_AND_LINKS}" == "TRUE" ] ; then

    if [ ! -z "${PHONE_NUMBERS}" ] ; then
      echo "${TITLE_INDENT} Phone:"
      if [ ! -z "${PHONE_NUMBERS}" ] ; then
        for THIS_CONFIG in `echo "${PHONE_NUMBERS}" | format_string_for_for_loop` ; do
          PROPERTY=`echo "${THIS_CONFIG}" | cut -f1 -d: | cleanup_string`
          VALUE=`echo "${THIS_CONFIG}" | cut -f2- -d: | cleanup_string`
          echo "  ${PROPERTY}: ${VALUE}"
        done
      fi
      echo
    fi

    if [ ! -z "${EMAIL_ADDRESSES}" ] ; then
      echo "${TITLE_INDENT} E-Mail:"
      if [ ! -z "${EMAIL_ADDRESSES}" ] ; then
        for THIS_CONFIG in `echo "${EMAIL_ADDRESSES}" | format_string_for_for_loop` ; do
          PROPERTY=`echo "${THIS_CONFIG}" | cut -f1 -d: | cleanup_string`
          VALUE=`echo "${THIS_CONFIG}" | cut -f2- -d: | cleanup_string`
          echo "  ${PROPERTY}: ${VALUE}"
        done
      fi
      echo
    fi

    echo "${TITLE_INDENT} URLs:"
    if [ ! -z "${URLS}" ] ; then
      echo "  Personal:"
      for THIS_CONFIG in `echo "${URLS}" | format_string_for_for_loop` ; do
        PROPERTY=`echo "${THIS_CONFIG}" | cut -f1 -d: | cleanup_string`
        VALUE=`echo "${THIS_CONFIG}" | cut -f2- -d: | cleanup_string`
        echo "    ${PROPERTY}: ${VALUE}"
      done
    fi
    echo "  WibbleCity:"
    echo "    Git Hub: https://github.com/wibblecity"
    echo

  fi

  if [ "${WCI_ENABLE_BANNER_SYSTEM_INFO}" == "TRUE" ] ; then

    echo "${TITLE_INDENT} Local Bash Profile:"
    echo "  Location: ${BASH_PROFILE_LOCAL_D}"
    for LOCAL_PROFILE_FILE in "${LOCAL_PROFILE_FILE_ARRAY[@]}" ; do
      echo "    Included: ${LOCAL_PROFILE_FILE}"
    done
    echo

    echo "${TITLE_INDENT} Search Path:"
    for THIS_PATH in `echo "${PATH}" | sed "s/:/ /g"` ; do
      echo "  ${THIS_PATH}"
    done
    echo

    echo "${TITLE_INDENT} OS Information:"
    sw_vers
    echo

    echo "${TITLE_INDENT} Filesystem Information:"
    df -Hl
    echo

    echo "${TITLE_INDENT} Statistics:"
    uptime
    echo

  fi

  NOW_HOUR=`date "+%H"`
  TIMEZONE_MODIFIER=`date "+%z"`
  if [ "${NOW_HOUR}" -lt "12" ] ; then
    GREETING="Good morning"
  elif [ "${NOW_HOUR}" -lt "18" ] ; then
    GREETING="Good afternoon"
  else
    GREETING="Good evening"
  fi

  if [ ! -z "${THIS_DISPLAY_NAME}" ] ; then
    GREETING_SUFFIX=", ${THIS_DISPLAY_NAME}"
  else
    GREETING_SUFFIX=""
  fi

  echo -n "${GREETING}${GREETING_SUFFIX}, your timezone is: UTC ${TIMEZONE_MODIFIER}"
  if [ "${WCI_AGENT_STARTED}" == "TRUE" ] ; then
    echo " - ***** The WCI agent has been started ***** Log: ${AGENT_LOG_FILE}"
  else
    echo
  fi
  echo "  PWD: `pwd`"
  echo

fi
