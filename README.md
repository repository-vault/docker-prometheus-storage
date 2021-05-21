# Motivation
Prometheus storage with simple fault tolerance

This is a very simple fault tolerant prometheus storage server, using a remote volume for backup and initial sync

This instance runs periodical snapshot and backup thems to the remote volume
Before starting, the last remote backup is downloaded

To force instant snapshot, use

docker kill -11 prometheus-storage



# Configuration
Configure using env vars
```
LOCAL_VOLUME_PATH  :=/var/data/local
REMOTE_VOLUME_PATH :=/var/data/remote
SNAPSHOT_INTERVAL  :=120
```

# Credits
* [131](https://github.com/131)
