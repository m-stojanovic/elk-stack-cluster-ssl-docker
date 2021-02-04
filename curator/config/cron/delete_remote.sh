#!/bin/bash
/usr/bin/curator --config /config/config.yml /config/actions/delete_remote_indices.yml &> /config/logs/curator-delete-remote-indices-$(date "+%Y-%m-%d-%H:%M:%S")

