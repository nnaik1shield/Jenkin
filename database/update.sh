export RESPFILE=$1
if [ "$RESPFILE" == "" ]; then
    sqlplus /nolog @update_linux.sql ask.sql
else
    sqlplus /nolog @update_linux.sql "$RESPFILE"
fi
