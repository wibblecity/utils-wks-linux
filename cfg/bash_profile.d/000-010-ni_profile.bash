
NI_PROFILE=~/.bash_profile-ni
if [ -f "${NI_PROFILE}" ] ; then
  . "${NI_PROFILE}"
else
  exit 1
fi
