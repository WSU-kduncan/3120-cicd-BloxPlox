# Project 5 - James Nagy

## Part 1: Semantic Versioning

### CD Project Overview

* The goal of this project is to add semantic versioning to our images using `git tag` metadata in GitHub's Actions. This will be done by editing our workflow.yml file to trigger an action when a tag is pushed.We'll also be pushing our tags to DockerHub using `docker/metadata-action` in our workflow.yml file.  The second goal is to keep production up to date using webhooks. This will be done via an EC2 instance using our DockerHub image, a script to pull new images, and a webhook. 

### How to generate a `tag` in `git` / GitHub

* Generating a `tag` in GitHub is done with the command `git tag -a v1.2.0`. The tag v1.2.0 represents the version number. With the 1 representing a MAJOR version, the 2 a MINOR version, and the 0 a PATCH version. A MAJOR version change (from 1.0.0 to 2.0.0 for example) is when you make conflicting API modifications. A MINOR version change (1.1.0 to 1.2.0) is when you include some functionality in a backwards compatible way. And finally, a PATCH version change (1.0.0 to 1.0.1) is usually a small bug fix. Overall, this will generate a tag in GitHub, but it won't trigger an Action nor will it add a version to our Dockerhub image. 

* To do this, we need to make some changes to our workflow.yml file. 
