# Project 5 - James Nagy

## Part 1: Semantic Versioning

### CD Project Overview

* The goal of this project is to add semantic versioning to our images using `git tag` metadata in GitHub's Actions. This will be done by editing our workflow.yml file to trigger an action when a tag is pushed.We'll also be pushing our tags to DockerHub using `docker/metadata-action` in our workflow.yml file.  The second goal is to keep production up to date using webhooks. This will be done via an EC2 instance using our DockerHub image, a script to pull new images, and a webhook. 

### How to generate a `tag` in `git` / GitHub

* Generating a `tag` in GitHub is done with the command `git tag -a v1.2.0`. The tag v1.2.0 represents the version number. With the 1 representing a MAJOR version, the 2 a MINOR version, and the 0 a PATCH version. A MAJOR version change (from 1.0.0 to 2.0.0 for example) is when you make conflicting API modifications. A MINOR version change (1.1.0 to 1.2.0) is when you include some functionality in a backwards compatible way. And finally, a PATCH version change (1.0.0 to 1.0.1) is usually a small bug fix. Overall, this will generate a tag in GitHub, but it won't trigger an Action nor will it add a version to our Dockerhub image. 

### Behavior of GitHub workflow

* To do this, we need to make some changes to our workflow.yml file. The first change we need to make is to have an Action trigger when we push a new tag.

```yml
on:
  push:
    branches:
      - "main"
    tags:
      - "v*.*.*"
```
  
  Not only do we want our Action to trigger when there's a push to main, but also when a new tag is pushed. So, we add `tag:` followed by the type of tag we want it to look for. In our case, we'll be using semantic versioning. It will look for a tag with the format "v(Major number).(Minor number).(Patch number)".

* Next, we need to collect `tag` data for DockerHub. 

```yml
- name: Collecting tag data
        id: meta
        uses: docker/metadata-action@v4
        with:
          # Docker image to use as a base name for our tags
          images: |
            nagyjames/project4
          # this will generate our Docker tags based on these attributes
          tags: |
            type=semver,pattern={{major}}
            type=semver,pattern={{major}}.{{minor}}
```

  This will generate a set of tags from our repository. 

```yml
- name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
            # tags: nagyjames/project4:latest
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }} 
```

  And finally, this will build and push our Docker image with our new tag that we've created using the set of tags generated with `docker/metadata-action`.

### Link to DockerHub repository (as additional proof)
[dockerhub repo](https://hub.docker.com/repository/docker/nagyjames/project4/general)



## Part 2 - Deployment

### How to install Docker to your instance

Installing Docker on your instance is as easy as CRTL-C, CRTL-V.
* First, make sure your system is up to date by running the command `sudo apt-get update`.
* Next, install Docker with this command `sudo apt install docker.io`.
* Now, install all of the dependency packages `sudo snap install docker`
* Finally, check your version and you're good to go `docker --version`


