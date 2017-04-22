#!/bin/sh
# This file is part of rawstorm.
#
#    chown is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    chown is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with chown .  If not, see <http://www.gnu.org/licenses/>.

dnf update --assumeyes &&
    dnf install --assumeyes curl &&
    dnf install --assumeyes jq &&
    dnf install --assumeyes dnf-plugins-core &&
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo &&
    dnf makecache --assumeyes fast &&
    dnf install --assumeyes docker-ce-17.03.1.ce-1.fc25 &&
    dnf update --assumeyes &&
    dnf clean all