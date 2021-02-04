#!/bin/bash
/usr/bin/curator --config /config/config.yml /config/actions/reindex_remote.yml &> /config/logs/curator-reindex-remote-$(date "+%Y-%m-%d-%H:%M:%S")


