#!/bin/sh

dnf update --assumeyes &&
    dnf install --assumeyes curl &&
    dnf install --assumeyes jq &&
    dnf install --assumeyes dnf-plugins-core &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf makecache --assumeyes fast &&
    dnf install --assumeyes docker-ce-17.03.1.ce-1.fc25 &&
    dnf update --assumeyes &&
    dnf clean all