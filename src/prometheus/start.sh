#!/bin/sh
killall -15 prometheus
killall -15 node_exporter
nohup prometheus --config.file "/etc/prometheus/prometheus.yml" --storage.tsdb.path "/etc/prometheus/data/" &
nohup node_exporter --collector.textfile.directory /var/lib/node_exporter/textfile_collector --collector.systemd --collector.systemd.unit-whitelist="(docker|ssh|rsyslog).service" &
