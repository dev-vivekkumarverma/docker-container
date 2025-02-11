
# Welcome to the first step to `docker`
## `how to run`
run the alpine:3.10

```sh
docker run -it alpine:3.10
```


```sh
docker run -it node:12-stretch bash
```


to kill all the running containers

```sh
docker kill $(docker ps -q)
```

---

# `Dockerfile`

It is basically a `series of instruction` that is used `for building the doceker containers`

build a `dockerfile` reffer the link <a href='./dockerfiles.md'>[click here ...]</a>