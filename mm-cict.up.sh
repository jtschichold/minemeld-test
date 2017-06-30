#!/bin/bash
# set -x
set -e

source ./config.sh

function check_environment {
    local error=0

    declare -a env_variables=(
        "ANSIBLE_PLAYBOOK"
        "CICT_CLIENT_LOCATION"
        "CICT_AWS_KEY_NAME"
        "CICT_AWS_REGION"
        "CICT_ADMIN_USERNAME"
        "CICT_ADMIN_PASSWORD"
        "CICT_AWS_ACCESS_KEY_ID"
        "CICT_AWS_SECRET_ACCESS_KEY"
        "CICT_SSH_PRIVATE_KEY_FILE"
        "SLAVE_AWS_REGION"
        "SLAVE_SSH_PRIVATE_KEY_FILE"
        "SLAVE_AWS_KEY_NAME"
    )

    for ev in "${env_variables[@]}"; do
        if [ ! -n "${!ev}" ]; then
            echo -e "\033[31m>> ERROR\033[0m - variable $ev undefined, check config.sh"
            ((error++))
        else
            export $ev
        fi
    done

    if [ ! "$error" -eq "0" ]; then
        exit 1
    fi

    echo -e "\033[32m>> INFO\033[0m - all the variables seem ok!"
}

function setup_jenkins {
    echo -e "\033[32m>> INFO\033[0m - starting the playbook"
    $ANSIBLE_PLAYBOOK infrastructure/infrastructure.yml
}

check_environment
setup_jenkins
