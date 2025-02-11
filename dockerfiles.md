for simple docker file basics <a href='./dockerFiles/dockerfile'>[click me..]</a>


the best way to run a docker container is with --init
as it will create a proxy to the server so that ctrl+c can kill the process.

```sh 
docker run --init docker-image-name
```

also if you are just playing with docker always use --rm 

```sh
docker run --init --rm docker-image-name
```  


use `--publish outer_port:inner_port` instead of `EXPOSE` 

```sh
docker xrun --init --rm --publish 3000:3000 --name my-container my-image-name
```
-p is the shorthand for --publish


---
# `.dockerignore` file
put all the files and folders in the .dockerignore file to not to copy it in the image

see example <a href='./create_a_nodejs_app/.dockerignore'>[click here]</a>