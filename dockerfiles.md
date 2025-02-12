for simple docker file basics <a href='./dockerFiles/dockerfile'>[click me..]</a>

# build docker image from docker file


```docker
docker build -t image_name -f dir/to/docker_file
```

use of tags xyz

```docker
docker build -t image_name:xyz -f dir/to/docker_file
```

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
docker run --init --rm --publish 3000:3000 --name my-container my-image-name
```
-p is the shorthand for --publish

see example this <a href='./create_a_nodejs_app/Dockerfile'>[click me..]</a>
---
# multi-stage docker file

use `From base_image_name as stage_name` in dockerfile say the stage name is `first_stage`
```dockerfile
From base_image_name as stage_name
```

in the satage where you want to copy something from `fist_stage` use

```dockerfile
COPY --from:stage_name --chown=user_group:username /stage_content_dir /destination_dir
```
for more see here.. <a href="./multistage_build/multistage_build.md">[click me...]</a>

### see the Multistage build of a flask app 
- link <a href='./multistage_flask_app/multi_stage_flask_app.md'> [click me...]</a>
---
# `.dockerignore` file
put all the files and folders in the .dockerignore file to not to copy it in the image

see example <a href='./create_a_nodejs_app/.dockerignore'>[click here]</a>

---
## important: volumes and mounts

Notes and example link : <a href="./binding_mounts_and_volumes/notes.md">[click me]</a>