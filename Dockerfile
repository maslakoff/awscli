FROM alpine:3.6

RUN apk -v --update add \
		git \
        python \
        python-dev \
        py-pip \
        groff \
        openssh-client \
        less \
        mailcap \
        tar \
        gzip \
        ca-certificates \
        && \
    pip install --upgrade pip && \
    pip install urllib3==1.21.1 && \
    pip install --upgrade awscli && \
    pip install --upgrade awsebcli && \
    rm /var/cache/apk/*

VOLUME /home/circleci/.aws
VOLUME /home/circleci/project

WORKDIR /home/circleci/project

USER circleci

ENTRYPOINT ["aws"]
