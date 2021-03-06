#!/bin/sh
# This file is part of rawstorm.
#
#    rawstorm is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    rawstorm is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with rawstorm .  If not, see <http://www.gnu.org/licenses/>.

( [ ! -z "${ENTRYPOINT}" ] || (echo Fedora Entry Point not specified && exit 66)) &&
    ( [ ! -z "${ORGANIZATION}" ] || (echo Docker Organization not specified && exit 67)) &&
    ( [ ! -z "${DOCKERHUB_ID}" ] || (echo DockerHub User ID not specified && exit 68)) &&
    ( [ ! -z "${DOCKERHUB_PASSWORD}" ] || (echo DockerHub Password not specified && exit 69)) &&
    ( [ ! -z "${VERSION}" ] || (echo Docker Version not specified && exit 69)) &&
    cd $(mktemp -d) &&
    (cat > Dockerfile <<EOF
FROM wildwarehouse/fedora:0.1.3
EOF
    ) &&
    docker build --build-arg PROGRAM_NAME=${ENTRYPOINT} --tag ${ORGANIZATION}/${ENTRYPOINT}:${VERSION} . &&
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