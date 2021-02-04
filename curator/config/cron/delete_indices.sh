#!/bin/bash
/usr/bin/curator --config /config/config.yml /config/actions/delete_indices.yml &> /config/logs/curator-delete-indices-$(date "+%Y-%m-%d-%H:%M:%S")
