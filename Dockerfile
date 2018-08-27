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
    pip install --upgrade urllib3==1.21.1 && \
    pip install --upgrade awscli && \
    pip install --upgrade awsebcli && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

VOLUME /root/.aws
VOLUME /project

WORKDIR /project

ENTRYPOINT ["aws"]
