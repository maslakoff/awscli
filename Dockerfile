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
        bash \
        && \
    pip install --upgrade pip && \
    pip install urllib3==1.21.1 && \
    pip install --upgrade awscli && \
    pip install --upgrade awsebcli && \
    rm /var/cache/apk/*

RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

ENV PUID 3434
ENV PGID 3434
ENV CIRCLECI_USER circleci

RUN addgroup -g ${PGID} ${CIRCLECI_USER} && \
    adduser -u ${PUID} -S -D ${CIRCLECI_USER} -G  ${CIRCLECI_USER} -h /home/${CIRCLECI_USER} && \
    echo '${CIRCLECI_USER} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER ${CIRCLECI_USER}

WORKDIR /home/${CIRCLECI_USER}

RUN touch .bashrc
ENV BASH_ENV=/home/${CIRCLECI_USER}/.bashrc

ENTRYPOINT ["aws"]
