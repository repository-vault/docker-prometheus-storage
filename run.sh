#!/bin/sh

PROC="$$"
LOCAL_VOLUME_PATH=${LOCAL_VOLUME_PATH:-/var/data/local}
REMOTE_VOLUME_PATH=${REMOTE_VOLUME_PATH:-/var/data/remote}
SNAPSHOT_INTERVAL=${SNAPSHOT_INTERVAL:-120}


trap "exit 1" 10
#send "replication now signal"
trap "killall sleep || true" 11 

abort(){
  echo "$@" "aborting" >&2
  kill -10 $PROC
}

[ ! -d "${REMOTE_VOLUME_PATH}" ] && abort "Missing REMOTE_VOLUME_PATH"
[ ! -d "${LOCAL_VOLUME_PATH}"  ] && abort "Missing LOCAL_VOLUME_PATH"


echo "Initial sync from $VOLUME_REMOTE_PATH"
rsync -av "$REMOTE_VOLUME_PATH"/ "$LOCAL_VOLUME_PATH"/


background_sync(){
  guid=$(curl -XPOST http://127.0.0.1:9000/api/v1/admin/tsdb/snapshot | jq -r '.data.name')
  echo "Got replication guid $guid"
  snapshot_dir="$LOCAL_VOLUME_PATH/snapshots/$guid"
  [! -d "$snapshot_dir" ] && abort "Invalid snapshot"
  rsync -av $snapshot_dir/ $REMOTE_VOLUME_PATH/
  rm -rf "$snapshot_dir"
  echo "Replication done, now sleeping ${SNAPSHOT_INTERVAL}"
  sleep $SNAPSHOT_INTERVAL
}

background_sync &

/bin/prometheus "$@"
