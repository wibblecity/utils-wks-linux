
if [ "${WCI_ENABLE_PROMPT}" == "TRUE" ] ; then

  ### prompt formatting
  BOLD="\[\e[1m\]"
  BOLDRED="\e[1;31m\]"
  DEFAULTFORMAT="\[\e[0m\]"
  LOGINTIME="$(date '+%Y-%m-%d %H:%M:%S %z')"

  if [ "$(id -un)" == "root" ] ; then
    USERTYPE="\n(${BOLDRED}Super User${DEFAULTFORMAT}) - Login Time: ${LOGINTIME}"
  else
    USERTYPE=""
  fi

  PS1="\[\e]0;\u@\H:\w\a\]${BOLD}\u@\H${DEFAULTFORMAT} - WibbleCity - \$(date '+%A, %d %B %Y %H:%M:%S %z')${USERTYPE}\n\w \$: "

fi
