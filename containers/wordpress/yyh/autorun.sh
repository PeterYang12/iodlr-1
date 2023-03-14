#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
RUN_COUNT=${RUN_COUNT:-1}
IMAGE_NAME=${IMAGE_NAME:-""}
DATA_FOLDER=${DATA_FOLDER:-"."}

while test $# -gt 0; do
    case "$1" in
    -h | --help)
        echo "run.sh - run workload and calculate total TPS"
        echo " "
        echo "run.sh [options]"
        echo " "
        echo "options:"
        echo "-h, --help                 show brief help"
        echo "--image <image_name>       specify a container image to use"
        echo "--RUN_COUNT <num>          specify the count of running"
        echo "--DATA_FOLDER <path>       specify the path of data folder"
        exit 0
        ;;
    --image)
        shift
        if test $# -gt 0; then
            export IMAGE_NAME=$1
        else
            echo "no contain image specified"
            exit 1
        fi
        shift
        ;;
    --RUN_COUNT)
        shift
        if test $# -gt 0; then
            export RUN_COUNT=$1
        else
            echo "no running RUN_COUNT specified"
            exit 1
        fi
        shift
        ;;
    --DATA_FOLDER)
        shift
        if test $# -gt 0; then
            export DATA_FOLDER=$1
        else
            echo "no running DATA_FOLDER specified"
            exit 1
        fi
        shift
        ;;
    *)
        break
        ;;
    esac
done


cd ./$DATA_FOLDER

for ((i = 0; i < ${RUN_COUNT}; i++)); do
    mkdir run_${i}
    cp ../process-spr-emon-data.sh run_${i}/
    cp ../collect-spr-emon.sh run_${i}/
    cp ../run.sh run_${i}/
    cd run_${i}
    ../../run.sh --image $IMAGE_NAME --count 8 --numa-pinning
    cd ..
done
