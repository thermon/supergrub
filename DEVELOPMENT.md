This file contains some advice for developing Super Grub2 Disk daily.

Once you have developed Super Grub2 Disk please check [INSTALL.md](INSTALL.md) file on how to make a proper public release.

# How does Super Grub2 Disk versioning work?

## Beta release example

2.02s1-beta1 means:

- 2.02: Upstream Grub 2.02 version
- s1 : Super Grub2 Disk scripts version (inside this Upstream Grub version)
- beta1: Beta 1

## Stable release example

2.02s1 means:

- 2.02: Upstream Grub 2.02 version
- s1 : Super Grub2 Disk scripts version (inside this Upstream Grub version)

# Super Grub2 Disk Release instructions

Make sure that the commit found at: grub-build-config file is the one you have used to build it (usually it will be the case).
Make Bump commit that summarizes all of the changes from the latest commit.
```
git commit -m 'Bump version to NEWVERSION.'
```

E.g.
```
git commit -m 'Bump version to 2.06s2-beta1.'
```

Then continue with [INSTALL.md - Docker - Release build instructions](INSTALL.md#docker---release-build).

When you make a public announcement make sure to reflect the exact commit or tag you are using to build grub so that grub experts can understand what features to expect from our grub build.

# Docker - Manual development

## Docker - Requirements

Please check [INSTALL.md - Docker - Requirements](INSTALL.md#docker---requirements).

## Debian minimal installation

We first create a Debian 11 minimal installation so that we can install required packages.
```
docker build --tag supergrub-manual-builder . -f manual-builder.Dockerfile
```
## Some developing

Develop whatever you want inside of the docker

```
docker run -it --privileged -v /dev:/dev -v $(pwd):/supergrub2-repo:ro -v $(pwd)/releases:/supergrub2-build/releases:rw -v $(pwd)/news-releases:/supergrub2-build/news-releases:rw -v $(pwd)/secureboot-binaries:/supergrub2-build/secureboot-binaries:rw -v $(pwd)/secureboot.d/sha256sums:/supergrub2-build/secureboot.d/sha256sums:rw supergrub-manual-builder:latest
```

## Save your current work
So you need to save your current work so that when you reboot your machine you don't lose your current work inside of the docker image.

- Exit from your docker.

- Identify your docker container id.

```
rescatuxs@adrianpc2020:~$ docker ps -a
CONTAINER ID   IMAGE                             COMMAND                  CREATED          STATUS                      PORTS     NAMES
266d2332828a   supergrub-manual-builder:latest   "bash"                   5 minutes ago    Exited (0) 3 minutes ago              sleepy_pascal
164e04ac8430   supergrub-manual-builder:latest   "-v /home/rescatuxs/…"   6 minutes ago    Created                               loving_snyder
7bc628fc3fb2   6704c2737d6d                      "-v /home/rescatuxs/…"   8 minutes ago    Created                               angry_jang
c027082f37df   6704c2737d6d                      "-v /home/rescatuxs/…"   13 minutes ago   Created                               dreamy_goodall
7bd0f3fc4440   6704c2737d6d                      "bash"                   16 minutes ago   Exited (0) 14 minutes ago             modest_khorana
d28f50a47eff   hello-world                       "/hello"                 36 minutes ago   Exited (0) 36 minutes ago             gifted_sutherland
```

- Commit your recent changes into it:

```
rescatuxs@adrianpc2020:~$ docker commit 266d2332828a supergrub-manual-builder:latest
sha256:bf28c6efaa1595dfde6571a7e257c80c03fa3276fcb698d827f67541e6cbc504
```
## Some more developing

```
docker run -it --privileged -v /dev:/dev -v $(pwd):/supergrub2-repo:ro -v $(pwd)/releases:/supergrub2-build/releases:rw -v $(pwd)/news-releases:/supergrub2-build/news-releases:rw -v $(pwd)/secureboot-binaries:/supergrub2-build/secureboot-binaries:rw -v $(pwd)/secureboot.d/sha256sums:/supergrub2-build/secureboot.d/sha256sums:rw supergrub-manual-builder:latest
```

**Do not run** `docker build` again because you will lose your changes.

## Usual git stuff inside Docker image

Use a local-only branch for docker development minimal changes

```
cd /supergrub2-build
git pull origin
```

## Tip - How to attach to running container

```
docker exec -it 644ca2ffdfe5 bash
```

This is useful when you want the container to keep building and at the same time you want to keep a look at the logs.

# Additional documentation

## How to update Grub installation

Modify `grub-build-config` file so that `GRUB2_COMMIT` reflects the commit or tag that you want to use in order to base your Super Grub2 Disk release.
Also commit that change locally so that the build can use it.
Never use a moving target like the master branch. Well, actually, you can use it, but please read the 'What to do when you release a new Super Grub2 Disk version' section.

Then you just run:
```
./grub-build-002-clean-and-update
./grub-build-003-build-all
./grub-build-004-make-check (optional)
./grub-build-005-install-all
```
.
