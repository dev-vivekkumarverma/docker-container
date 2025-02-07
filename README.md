# docker-container
Hey, this is for learning and practicing docker in step by step process


`Note:` In this project we will creat everything inside a parent container. It is safe and and any failure will be limited to the parent container itself.

### Pre-requisits:
-   docker must be installed on the system.

## Use the given code to `create parent docker container`

```shell
docker run -it --name docker-host --rm --privileged ubuntu:bionic
```
