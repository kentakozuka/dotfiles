#!/usr/bin/env zsh

GCLOUD=$(echo "#[fg=green] GCLOUD: "$(gcloud config configurations list | awk '$2 == "True" { print $1}'))
KUBE=$(echo "#[fg=yellow] KUBE: "$(kubectl config current-context))

echo "#[bg=colour232]" $GCLOUD $KUBE