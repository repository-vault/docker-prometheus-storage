# Motivation

Prometheus storage with simple fault tolerance

[131hub/prometheus-storage] is a very simple fault tolerant prometheus storage server docker container, using a remote volume for backup and initial sync

This instance runs periodical snapshot and backup thems to the remote volume
Before starting, the last remote backup is downloaded

To force instant snapshot, use `docker kill -11 prometheus-storage`


# Usage
```
docker run -v /data/local:/data/local -v /data/remote:/data/remote  131hub/prometheus-storage
```


# Configuration
Configure using env vars
```
LOCAL_VOLUME_PATH  :=/data/local
REMOTE_VOLUME_PATH :=/data/remote
SNAPSHOT_INTERVAL  :=120
```


# Advance usage

```
# Force sync
docker kill -s SIGUSR1 $(docker ps -q --filter "name=prometheus")


# restart without initial sync
touch $LOCAL_VOLUME_PATH/nosync


```

# Credits
* [131](https://github.com/131)
