#!/bin/bash

export IBM_ES_REGION={{ inventory.parameters.region }}
export IBMCLOUD_HTTP_TIMEOUT=60
export IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY}

export ibmcloud0="docker run -it \
  -e X_FEATURE_SANDBOX=true \
  -e SCHEMATICSGITTOKEN=/$IBM_GITLAB_PAT \
  -e IBMCLOUD_API_KEY=/$TF_CDT_IBMCLOUD_APIKEY \
  -v "/$(pwd):/$(pwd)" \
  -w /$(pwd) \
  --user /$(id -u):/$(id -g) \
  {{ inventory.parameters.docker_image }}"

ibmcloud0 login -r $IBM_ES_REGION
ibmcloud0 is target gen 2

ibmcloud0 "$@"