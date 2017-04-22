

```
export PACKAGE=openssh-clients &&
    export ENTRYPOINT=ssh &&
    export ORGANIZATION=bigsummer &&
    export DOCKERHUB_ID=emorymerryman &&
    export DOCKERHUB_PASSWORD={password} &&
    export VERSION=0.0.00 &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --env PACKAGE \
        --env ENTRYPOINT \
        --env ORGANIZATION \
        --env DOCKERHUB_ID \
        --env DOCKERHUB_PASSWORD \
        --env VERSION \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        wildwarehouse/rawstorm:0.0.0
```