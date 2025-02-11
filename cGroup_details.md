-   Let's come to the docker-host container's root dir

Now install cgroup-tools and htop

```sh
apt-get install -y cgroup-tools htop
```

Create a cGroup `/sandbox`

Use this command

```sh
cgcreate -g cpu,memory,blkio,freezer,devices:/sandbox
```

if any error occurs

Check if cgroups are mounted:

```bash
mount | grep cgroup
```
If you don’t see cgroups mounted, try manually mounting them:

```bash
sudo mount -t cgroup2 none /sys/fs/cgroup
```