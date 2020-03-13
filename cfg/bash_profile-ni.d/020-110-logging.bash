
### implement the logging configuration rules
if [ "${WCI_ENABLE_LOGGING}" == "TRUE" ] ; then
  WCI_ENABLE_LOGGING="FALSE"
  if [ -t 0 ] || [ "${WCI_ENABLE_LOGGING_WHILE_INPUT_IS_PIPED}" == "TRUE" ] ; then
    if [ -t 1 ] || [ "${WCI_ENABLE_LOGGING_WHILE_OUTPUT_IS_PIPED}" == "TRUE" ] ; then
      WCI_ENABLE_LOGGING="TRUE"
    fi
  fi
fi
