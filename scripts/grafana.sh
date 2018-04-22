#!/bin/bash
# Magnus Glantz, sudo@redhat.com, 2018
# Automatic install of Grafana
# Read how to complete the setup at https://blog.openshift.com/prometheus-alerts-on-openshift/

git clone https://github.com/mrsiano/grafana-ocp
cd grafana-ocp
./setup-grafana.sh prometheus-ocp openshift-metrics true
oc adm pod-network join-projects --to=grafana openshift-metrics
echo "Authentication read management-admin service account token:"
oc sa get-token management-admin -n management-infra


echo 'For cluster memory: sum(container_memory_rss) / sum(machine_memory_bytes)'
echo 'For changes in the cluster: sum(changes(container_start_time_seconds[10m]))'
echo 'For API calls: sum(apiserver_request_count{verb=~"POST|PUT|DELETE|PATCH"}[5m]) and sum(apiserver_request_count{verb=~"GET|LIST|WATCH"}[5m])'
