
### finding binaries
RUBY_BIN="$(which ruby)"
if [ "$?" -ne "0" ] ; then
  usage "Cannot locate ruby binary"
fi

PYTHON_BIN="$(which python)"
if [ "$?" -ne "0" ] ; then
  usage "Cannot locate python binary"
fi
#####
