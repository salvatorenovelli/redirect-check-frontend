#!/bin/sh


export PROJECT_ID=redirect-check-180020
export VERSION=`jq -r '.version' package.json`
export ARTIFACT_ID=`jq -r '.name' package.json`

export IMAGE_TAG=gcr.io/${PROJECT_ID}/${ARTIFACT_ID}:${VERSION}


if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

echo "Going to $1 ${IMAGE_TAG}"

case $1 in
    "build" )
        yarn install
        yarn build
        mv build docker
        echo "Building ${IMAGE_TAG}"
        docker build docker -t ${IMAGE_TAG}
    ;;
    "clean" )
        rm -rf build
        rm -rf docker/build
    ;;
    "run" )
        docker run --name ${ARTIFACT_ID} -it --rm -p 3001:3001 ${IMAGE_TAG}
    ;;
    "push" )
        gcloud docker -- push ${IMAGE_TAG}
    ;;
    "deploy" )
        kubectl delete -f k8s/production.yaml
        sed -i.bak "s#<IMAGE_TAG_DO_NOT_EDIT>#${IMAGE_TAG}#" k8s/production.yaml
        kubectl apply -f k8s/
        mv k8s/production.yaml.bak k8s/production.yaml
    ;;
esac


