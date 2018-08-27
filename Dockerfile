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
        sudo \
        && \
    pip install --upgrade pip && \
    pip install urllib3==1.21.1 && \
    pip install --upgrade awscli && \
    pip install --upgrade awsebcli && \
    rm /var/cache/apk/*

VOLUME /home/circleci/.aws
VOLUME /home/circleci/project

WORKDIR /home/circleci/project

ENV PUID 3434
ENV PGID 3434

RUN addgroup -g ${PGID} circleci && \
    adduser -u ${PUID} -S circleci -G circleci && \
    echo 'circleci ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-circleci && \
    chmod 0440 /etc/sudoers.d/50-circleci

USER circleci

ENTRYPOINT ["aws"]
