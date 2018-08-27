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


ENV PUID 3434
ENV PGID 3434
ENV CIRCLECI_USER circleci

RUN addgroup -g ${PGID} ${CIRCLECI_USER} && \
    adduser -D -u ${PUID} -S ${CIRCLECI_USER} -G ${CIRCLECI_USER} && \
    echo '${CIRCLECI_USER} ALL=NOPASSWD: ALL' >> /etc/sudoers.d/${CIRCLECI_USER} && \
    chmod 0440 /etc/sudoers.d/${CIRCLECI_USER}

USER ${CIRCLECI_USER}

WORKDIR /home/${CIRCLECI_USER}/project

ENTRYPOINT ["aws"]
