# AWS CLI in Docker

Containerized AWS CLI and EB CLI on alpine to avoid requiring the aws cli to be installed on CI machines.

## Build

```
docker build -t maslakoff/awscli .
```

Automated build on Docker Hub

[![DockerHub Badge](http://dockeri.co/image/maslakoff/awscli)](https://hub.docker.com/r/maslakoff/awscli/)

## Usage

Configure:

```
export AWS_ACCESS_KEY_ID="<id>"
export AWS_SECRET_ACCESS_KEY="<key>"
export AWS_DEFAULT_REGION="<region>"
```

AWS S3 usage:

```
./aws.sh s3 <Command> [<Arg> ...]
```

Caveat: Because `aws.sh` mounts the current directory as `/project`, paths to local files must be relative to the current directory.

## Install

To use `aws.sh` as a drop-in replacement for calls to the aws-cli, use one of the following methods:

Add an alias to your shell:

```
alias aws='docker run --rm -t $(tty &>/dev/null && echo "-i") -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" -e "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" -v "$(pwd):/project" maslakoff/awscli'
```

Or drop it into your path named `aws`:

```
curl -o /usr/local/bin/aws https://raw.githubusercontent.com/maslakoff/awscli/master/aws.sh && chmod a+x /usr/local/bin/aws
```

## References

[AWS CLI Docs](https://aws.amazon.com/documentation/cli/)

[EB CLI Docs](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html)

