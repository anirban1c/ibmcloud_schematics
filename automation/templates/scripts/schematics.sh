#!/bin/bash

# export these
#export SCHEMATICSGITTOKEN=
export IBM_ES_REGION={{ inventory.parameters.region }}
export IBMCLOUD_HTTP_TIMEOUT=60
export IBMCLOUD_API_KEY=${IBMCLOUD_API_KEY}
WS_FILE_NAME=../terraform/schematics.json
VAR_WS_FILE_NAME=sch-tf-vars.tfvars


echo "Init environment"

WS_NAME=$(cat ${WS_FILE_NAME} | jq -r '.name')

echo "Workspace name set to : ${WS_NAME}"

ibmcloud login -r ${IBM_ES_REGION}
echo "Init environment"

WS_ID=$(ibmcloud terraform workspace list --json | \
 				jq  --arg ws_name $WS_NAME -r '.workspaces[] | select(.name==$ws_name) | .id' \
        | jq -r --slurp --raw-input 'split("\n")[0]')

echo "Workspace ID : ${WS_ID}"


exitOnLastError(){
last_status=$?
if [ "$last_status" -ne 0 ]; then
    echo "ERROR: Last command failed with an status code of $last_status. Aborting execution"
    ibmcloud logout
    exit $last_status
fi

}


new() {
  ibmcloud schematics workspace new -f ${WS_FILE_NAME} \
				  -g ${SCHEMATICSGITTOKEN}
}

update() {
  ibmcloud schematics workspace update --id ${WS_ID} \
          -f ${WS_FILE_NAME} \

}

refresh() {
  ibmcloud schematics refresh --id ${WS_ID} \
          -f ${WS_FILE_NAME} \

}

plan() {
  ibmcloud schematics plan --id "${WS_ID}" \
        --json

}

apply() {
  ibmcloud schematics apply --id "${WS_ID}"  \
        --json -f

}

destroy() {
  ibmcloud schematics destroy --id "${WS_ID}" --json -f

}

state-list() {
  ibmcloud schematics state list --id "${WS_ID}"

}

delete() {
  ibmcloud schematics workspace delete --id ${WS_ID} -f
}

logs() {
  # pick the last action
  export WS_ACTION_ID=$(ibmcloud terraform workspace action --id=${WS_ID} \
		--json | jq -r '.actions[0].action_id')

  echo "Action ID : ${WS_ACTION_ID}"

  ibmcloud schematics logs --id ${WS_ID} \
      --act-id ${WS_ACTION_ID}
}

case "$1" in
  new)
    new
    exitOnLastError
    ;;
  update)
    update
    exitOnLastError
    ;;
  plan)
    plan
    exitOnLastError
    ;;
  apply)
    apply
    exitOnLastError
    ;;
  logs)
    logs
    exitOnLastError
    ;;
  destroy)
    destroy
    ;;
  delete)
    delete
    ;;
  state-list)
    state-list
    ;;
  refresh)
    refresh
    ;;
  *)
    echo "Usage: $0 TF commands"
esac