
AGENT_BIN="${WCI_WKS_UTILS_PATH}/bin/agent"
if [ ! -f "${AGENT_BIN}" ] ; then
  usage "WCI Agent - ${AGENT_BIN} does not exist or is not a file"
fi

AGENT_LOG_FILE="${WCI_CFG_BASE}/logs/agent.log"

WCI_AGENT_STARTED="FALSE"
PSCHECK=`ps aux | grep ruby | grep agent-executive | grep -c "^${THIS_USER}"`
if [ "${PSCHECK}" -eq "0" ] ; then
  mkdir -p `dirname "${AGENT_LOG_FILE}"`
  chmod 700 "${AGENT_BIN}"
  (nohup "${AGENT_BIN}" >> "${AGENT_LOG_FILE}" 2>&1 &)
  WCI_AGENT_STARTED="TRUE"
fi
