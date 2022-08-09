
### finding binaries
RUBY_BIN="$(which ruby)"
if [ "$?" -ne "0" ] ; then
  usage "Cannot locate ruby binary"
fi

PYTHON_BIN="$(which python3)"
if [ "$?" -ne "0" ] ; then
  usage "Cannot locate python3 binary"
fi
#####
