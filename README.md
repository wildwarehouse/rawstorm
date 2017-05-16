<!--
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
-->

# Synopsis

This automates the process of creating docker images.
If creating a docker image is just installing a package using dnf, then this can do that.

Since this image asks for sensitive information (your dockerhub password), you should not run it if you do not trust it.

# Usage

In the below snippet:

1. change the 3rd line to a dockerhub organization that you control,
2. change the 4th line to your dockerhub id (emorymerryman is my dockerhub id)
3. change the 5th line to your dockerhub password ({password} is not my dockerhub password) - if you do not trust the image, then do not run it

```
export ENTRYPOINT=tee &&
    export ORGANIZATION=bigsummer &&
    export DOCKERHUB_ID=emorymerryman &&
    export DOCKERHUB_PASSWORD=<PASSWORD> &&
    export VERSION=0.1.0 &&
    docker \
        container \
        run \
        --interactive \
        --rm \
        --env ENTRYPOINT \
        --env ORGANIZATION \
        --env DOCKERHUB_ID \
        --env DOCKERHUB_PASSWORD \
        --env VERSION \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        wildwarehouse/rawstorm:0.1.0
```

This creates a docker image with ssh and publishes it to dockerhub.