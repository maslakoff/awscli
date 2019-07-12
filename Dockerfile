FROM mhart/alpine-node:10

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN apk -v --update add \
		git \
        groff \
        openssh-client \
        less \
        mailcap \
        tar \
        gzip \
        ca-certificates \
        sudo \
        bash \
        curl \
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
    echo "${CIRCLECI_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${CIRCLECI_USER}

WORKDIR /home/${CIRCLECI_USER}

RUN touch .bashrc
ENV BASH_ENV=/home/${CIRCLECI_USER}/.bashrc

ENTRYPOINT ["aws"]
