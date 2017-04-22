#!/bin/sh

( [ ! -z "${PACKAGE}" ] || (echo Fedora Package not specified && exit 65)) &&
    ( [ ! -z "${ENTRYPOINT}" ] || (echo Fedora Entry Point not specified && exit 66)) &&
    ( [ ! -z "${ORGANIZATION}" ] || (echo Docker Organization not specified && exit 67)) &&
    ( [ ! -z "${DOCKERHUB_ID}" ] || (echo DockerHub User ID not specified && exit 68)) &&
    ( [ ! -z "${DOCKERHUB_PASSWORD}" ] || (echo DockerHub Password not specified && exit 69)) &&
    ( [ ! -z "${VERSION}" ] || (echo Docker Version not specified && exit 69)) &&
    cd $(mktemp -d) &&
    (cat > Dockerfile <<EOF
FROM wildwarehouse/fedora:0.0.0
USER root
RUN \
    dnf update --assumeyes && \
    dnf install --assumeyes ${PACKAGE} && \
    dnf update --assumeyes && \
    dnf clean all
USER user
ENTRYPOINT [ "${ENTRYPOINT}" ]
CMD [ ]
EOF
    ) &&
    docker build --tag ${ORGANIZATION}/${ENTRYPOINT}:${VERSION} . &&
    (cat <<EOF
{
    "username": "${DOCKERHUB_ID}",
    "password": "${DOCKERHUB_PASSWORD}"
}
EOF
    ) | curl -s -H "Content-Type: application/json" -X POST -d @- https://hub.docker.com/v2/users/login/ | jq -r .token > token.txt &&
    TOKEN=$(cat token.txt) &&
    curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${ORGANIZATION}/${ENTRYPOINT} &&
    docker login --username ${DOCKERHUB_ID} --password ${DOCKERHUB_PASSWORD} &&
    docker push ${ORGANIZATION}/${ENTRYPOINT}:${VERSION}