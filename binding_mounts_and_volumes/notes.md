# Persistent Data Storage in Docker Containers

## Overview
Docker containers are ephemeral by default, meaning any data inside them is lost when the container stops. Persistent storage solutions such as **bind mounts** and **volumes** allow data to be retained even after container restarts.

## Storage Methods

### 1. Bind Mounts
Bind mounts map a specific directory from the host machine into a container.

#### Example:
```sh
docker run -d \
  --name my-container \
  --mount type=bind,source=/home/user/data,target=/app/data \
  my-image
```

| Command | Description |
|---------|-------------|
| `docker run` | Runs a new container from an image. |
| `-d` | Runs the container in detached mode (in the background). |
| `--name my-container` | Assigns a name to the container. |
| `--mount type=bind,source=/home/user/data,target=/app/data` | Mounts a host directory inside the container. |
| `my-image` | Specifies the image to use for the container. |

**Different Values:**
| Parameter | Possible Values | Description |
|-----------|----------------|-------------|
| `type=bind` | `bind` | Specifies a bind mount. |
| `source=/home/user/data` | Any valid host directory | Defines the directory on the host machine. |
| `target=/app/data` | Any valid container path | Defines where the directory is mounted inside the container. |

#### Pros:
✔ Immediate updates between host and container.
✔ Easy debugging and real-time access.

#### Cons:
❌ Full access to host files may be risky.
❌ Not portable between different hosts.

---

### 2. Docker Volumes
Docker manages **volumes** independently from the host filesystem, storing data in `/var/lib/docker/volumes/`.

#### Example:
```sh
docker volume create my-data

docker run -d \
  --name my-container \
  --mount type=volume,source=my-data,target=/app/data \
  my-image
```

| Command | Description |
|---------|-------------|
| `docker volume create my-data` | Creates a named volume called `my-data`. |
| `docker run -d` | Runs the container in detached mode. |
| `--name my-container` | Names the container as `my-container`. |
| `--mount type=volume,source=my-data,target=/app/data` | Mounts a volume inside the container. |
| `my-image` | Specifies the image used for the container. |

**Different Values:**
| Parameter | Possible Values | Description |
|-----------|----------------|-------------|
| `type=volume` | `volume` | Specifies a volume mount. |
| `source=my-data` | Any valid volume name | Defines the volume name. |
| `target=/app/data` | Any valid container path | Specifies the mount point inside the container. |

#### Pros:
✔ More **secure** than bind mounts.
✔ **Portable** between different Docker hosts.
✔ **Optimized performance** for container workloads.

#### Cons:
❌ Not directly accessible from the host filesystem.

---

## Real-World Example: Parent `docker-host` & Child Containers
### Scenario
A **parent container** (`docker-host`) manages persistent storage for **child containers** (`app1`, `app2`). This setup helps **centralize logs** and **improve security**.

#### Step 1: Create a Shared Volume
```sh
docker volume create shared-logs
```
| Command | Description |
|---------|-------------|
| `docker volume create shared-logs` | Creates a named volume `shared-logs` for storing logs. |

#### Step 2: Run the Parent Container (`docker-host`)
```sh
docker run -d \
  --name docker-host \
  --mount type=volume,source=shared-logs,target=/var/logs \
  ubuntu sleep infinity
```
| Command | Description |
|---------|-------------|
| `docker run -d` | Runs the container in detached mode. |
| `--name docker-host` | Names the container as `docker-host`. |
| `--mount type=volume,source=shared-logs,target=/var/logs` | Mounts the `shared-logs` volume in `/var/logs`. |
| `ubuntu sleep infinity` | Runs an Ubuntu container that never exits. |

#### Step 3: Run Child Containers
```sh
docker run -d \
  --name app1 \
  --mount type=volume,source=shared-logs,target=/var/logs \
  my-app-image

docker run -d \
  --name app2 \
  --mount type=volume,source=shared-logs,target=/var/logs \
  my-app-image
```
| Command | Description |
|---------|-------------|
| `docker run -d` | Runs the container in detached mode. |
| `--name app1` / `--name app2` | Names the child containers. |
| `--mount type=volume,source=shared-logs,target=/var/logs` | Mounts `shared-logs` for centralized logging. |
| `my-app-image` | Specifies the application image. |

---

## Security Best Practices

**Use Volumes Instead of Bind Mounts**: Reduces risk of unwanted host modifications.

**Read-Only Mounts Where Possible**: Prevents unintended changes.
```sh
docker run -d \
  --name my-container \
  --mount type=volume,source=my-data,target=/app/data,readonly \
  my-image
```
| Parameter | Possible Values | Description |
|-----------|----------------|-------------|
| `readonly` | `readonly` | Mounts the volume as read-only. |

**Limit Container Permissions**: Use non-root users inside containers.
```sh
docker run -d \
  --user 1001 \
  --name secure-container \
  --mount type=volume,source=my-data,target=/app/data \
  my-image
```
| Parameter | Possible Values | Description |
|-----------|----------------|-------------|
| `--user 1001` | Any valid UID | Runs the container with a specific user. |

**Backup Volumes Regularly**: Ensure critical data is not lost.
```sh
docker run --rm \
  --mount type=volume,source=my-data,target=/data \
  -v /backup:/backup \
  busybox tar czf /backup/data-backup.tar.gz -C /data .
```
| Command | Description |
|---------|-------------|
| `docker run --rm` | Runs a temporary container that is removed after execution. |
| `--mount type=volume,source=my-data,target=/data` | Mounts `my-data` inside the container. |
| `-v /backup:/backup` | Mounts a local backup directory. |
| `tar czf /backup/data-backup.tar.gz -C /data .` | Creates a compressed backup. |

---
## Conclusion
Using **volumes** and **bind mounts** effectively improves data persistence in Docker containers. Volumes are **safer**, **more portable**, and **highly recommended for production**. A parent `docker-host` container managing child containers helps in **centralized logging and security**.



# see the example

link <a href="example1.md">[click me...]</a>