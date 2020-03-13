
function usage {
  ERROR_LOG_EVENT="$1"
  USAGE_INFO="$2"
  THIS_PID="$$"
  EXIT_STATUS="1"
  log_error_line
  log_error "##### ***** ERROR ***** ######"
  log_error
  log_error "CMD: ${SCRIPT_NAME} ${THIS_ARGS}"
  log_error "Message: ${ERROR_LOG_EVENT}"
  if [ ! -z "${USAGE_INFO}" ] ; then
    log_error
    log_error "Usage: ${SCRIPT_NAME} ${USAGE_INFO}"
    log_error
  fi
  log_error "##### ***** ERROR ***** ######"
  log_error "##### Sleeping for 5 seconds then exiting with status: ${EXIT_STATUS}"
  log_error_line
  sleep 5
  exit "${EXIT_STATUS}"
}

function log_error {
  EVENT_DATA="$1"
  THIS_PID="$$"
  LOG_TIMESTAMP=`date "+%F %H:%M:%S %z"`
  echo "${LOG_TIMESTAMP} - ${THIS_PID} - ${SCRIPT_NAME} - ERROR: ${EVENT_DATA}" >&2
}

function log_error_line {
  EVENT_DATA="$1"
  echo "${EVENT_DATA}" >&2
}

function log_event {
  if [ "${WCI_ENABLE_LOGGING}" == "TRUE" ] ; then
    EVENT_DATA="$1"
    THIS_PID="$$"
    if [ -z "${THIS_PID}" ] ; then
      usage "THIS_PID variable is empty"
    fi
    LOG_TIMESTAMP=`date "+%F %H:%M:%S %z"`
    echo "${LOG_TIMESTAMP} - ${THIS_PID} - ${SCRIPT_NAME} - ${EVENT_DATA}"
  fi
}

function log_line {
  if [ "${WCI_ENABLE_LOGGING}" == "TRUE" ] ; then
    EVENT_DATA="$1"
    echo "${EVENT_DATA}"
  fi
}

function log_pipe {
  while read LINE ; do
    if [ "${WCI_ENABLE_LOGGING}" == "TRUE" ] ; then
      echo "${LINE}"
    fi
  done < "/dev/stdin"
}

function set_execution_environment_variables {
  ### understanding location
  EXECUTED_LOCATION="$0"
  if [ "${EXECUTED_LOCATION}" == "-bash" ] || [ "${EXECUTED_LOCATION}" == "" ] ; then
    SKIPPED='TRUE'
  else
    ### getting START_DIR
    START_DIR="$(pwd)"
    if [ "$?" != "0" ] ; then
      usage "START_DIR pwd command exited with errors"
    fi
    if [ -z "${START_DIR}" ] ; then
      usage "START_DIR variable is empty"
    fi
    #####
    ### getting SCRIPT_PATH
    if [ -z "${EXECUTED_LOCATION}" ] ; then
      usage "EXECUTED_LOCATION variable is empty"
    fi
    SCRIPT_PATH="$(realpath "${EXECUTED_LOCATION}")"
    if [ "$?" != "0" ] ; then
      usage "SCRIPT_PATH realpath command exited with errors"
    fi
    if [ -z "${SCRIPT_PATH}" ] ; then
      usage "SCRIPT_PATH variable is empty"
    fi
    #####
    ### getting SCRIPT_NAME
    SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
    if [ "$?" != "0" ] ; then
      usage "SCRIPT_NAME basename command exited with an error"
    fi
    if [ -z "${SCRIPT_NAME}" ] ; then
      usage "SCRIPT_NAME variable is empty"
    fi
    if [ -z "${SCRIPT_NAME}" ] ; then
      usage "SCRIPT_NAME variable is empty"
    fi
    #####
    ### getting SCRIPT_DIR
    SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"
    if [ "$?" != "0" ] ; then
      usage "SCRIPT_PATH dirname command exited with an error"
    fi
    if [ -z "${SCRIPT_DIR}" ] ; then
      usage "SCRIPT_DIR variable is empty"
    fi
    #####
    ### getting parent directories
    if [ "${SCRIPT_DIR}" != "/" ] ; then
      SCRIPT_DIR_PARENT_1="$(dirname "${SCRIPT_DIR}")"
      if [ "$?" != "0" ] ; then
        usage "SCRIPT_DIR_PARENT_1 dirname command exited with an error"
      fi
      if [ -z "${SCRIPT_DIR_PARENT_1}" ] ; then
        usage "SCRIPT_DIR_PARENT_1 variable is empty"
      fi
    fi
    if [ "${SCRIPT_DIR_PARENT_1}" != "/" ] ; then
      SCRIPT_DIR_PARENT_2="$(dirname "${SCRIPT_DIR_PARENT_1}")"
      if [ "$?" != "0" ] ; then
        usage "SCRIPT_DIR_PARENT_2 dirname command exited with an error"
      fi
      if [ -z "${SCRIPT_DIR_PARENT_2}" ] ; then
        usage "SCRIPT_DIR_PARENT_2 variable is empty"
      fi
    fi
    if [ "${SCRIPT_DIR_PARENT_2}" != "/" ] ; then
      SCRIPT_DIR_PARENT_3="$(dirname "${SCRIPT_DIR_PARENT_2}")"
      if [ "$?" != "0" ] ; then
        usage "SCRIPT_DIR_PARENT_3 dirname command exited with an error"
      fi
      if [ -z "${SCRIPT_DIR_PARENT_3}" ] ; then
        usage "SCRIPT_DIR_PARENT_3 variable is empty"
      fi
    fi
    #####
    ### getting THIS_PID
    THIS_PID="$$"
    if [ -z "${THIS_PID}" ] ; then
      usage "THIS_PID variable is empty"
    fi
    #####
    ### printing shell location variables
    if [ "${WCI_ENABLE_DISPLAY_EXECUTION_ENVIRONMENT_VARIABLES}" == 'TRUE' ] ; then
      log_line
      log_line "${THIS_PID} - Execution Environment:"
      log_line "${THIS_PID} -  Launch:"
      log_line "${THIS_PID} -   CMD: ${EXECUTED_LOCATION} ${THIS_ARGS}"
      log_line "${THIS_PID} -   START_DIR: ${START_DIR}"
      log_line "${THIS_PID} -   ARGS: ${THIS_ARGS}"
      log_line "${THIS_PID} -  Script:"
      log_line "${THIS_PID} -   SCRIPT_NAME: ${SCRIPT_NAME}"
      log_line "${THIS_PID} -   SCRIPT_PATH: ${SCRIPT_PATH}"
      log_line "${THIS_PID} -  Path:"
      log_line "${THIS_PID} -   SCRIPT_DIR: ${SCRIPT_DIR}"
      if [ ! -z "${SCRIPT_DIR_PARENT_1}" ] ; then
        log_line "${THIS_PID} -   SCRIPT_DIR_PARENT_1: ${SCRIPT_DIR_PARENT_1}"
      fi
      if [ ! -z "${SCRIPT_DIR_PARENT_2}" ] ; then
        log_line "${THIS_PID} -   SCRIPT_DIR_PARENT_2: ${SCRIPT_DIR_PARENT_2}"
      fi
      if [ ! -z "${SCRIPT_DIR_PARENT_3}" ] ; then
        log_line "${THIS_PID} -   SCRIPT_DIR_PARENT_3: ${SCRIPT_DIR_PARENT_3}"
      fi
      log_line
    fi
    #####
  fi
}

function get_array_from_stdin {
  THIS_ARRAY_ELEMENT_COUNT="0"
  if [ ! -t 0 ] ; then
    while read LINE ; do
      THIS_ARRAY[${THIS_ARRAY_ELEMENT_COUNT}]="${LINE}"
      THIS_ARRAY_ELEMENT_COUNT=$((${THIS_ARRAY_ELEMENT_COUNT} + 1))
    done < "/dev/stdin"
  fi
  TARGET="$1"
  if [ "${TARGET}" != "" ] ; then
    THIS_ARRAY[${THIS_ARRAY_ELEMENT_COUNT}]="${TARGET}"
  fi
}

function create_directory {
  TARGET="$1"
  if [ ! -d "${TARGET}" ] ; then
    log_event "Creating directory: ${TARGET}"
    mkdir -p "${TARGET}"
  fi
}

function set_permissions_on_dir {
  TARGET="$1"
  PERM_STRING="$2"
  if [ ! -d "${TARGET}" ] ; then
    usage "TARGET: ${TARGET} does not exist or is not a directory"
  fi
  log_event "Setting permissions on: ${TARGET} to ${PERM_STRING}"
  chmod -R "${PERM_STRING}" "${TARGET}"
}

function update_symlink {
  SYMLINK="$1"
  TARGET="$2"
  if [ ! -e "${TARGET}" ] ; then
    usage "TARGET: ${TARGET} does not exist"
  fi
  if [ -L "${SYMLINK}" ] ; then
    rm "${SYMLINK}"
  fi
  log_event "Creating symlink from: ${SYMLINK} to: ${TARGET}"
  ln -s "${TARGET}" "${SYMLINK}"
}

function bash_profile_directory {
  THIS_PROFILE_D_PATH="$1"
  create_directory "${THIS_PROFILE_D_PATH}"
  for PROFILE_FILE in `ls -1 ${THIS_PROFILE_D_PATH} | grep .bash` ; do
    PROFILE_FILE_PATH="${THIS_PROFILE_D_PATH}/${PROFILE_FILE}"
    . ${PROFILE_FILE_PATH}
    if [ "$?" -ne "0" ] ; then
      usage "Bash Profile - Including file: ${PROFILE_FILE_PATH} exited with errors"
    fi
  done
}

function cleanup_string {
  while read LINE ; do
    echo -n "${LINE}" | sed "s/_____/ /g" | sed "s/^ *//g"
  done < "/dev/stdin"
}

function format_string_for_for_loop {
  while read LINE ; do
    echo -n "${LINE}" | sed "s/ /_____/g" | sed "s/,/ /g"
  done < "/dev/stdin"
}
