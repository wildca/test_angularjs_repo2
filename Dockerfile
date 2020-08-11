FROM ubuntu:14.04
MAINTAINER Mathias Latzko <mathias.latzko@iconicfuture.com>
MAINTAINER Andreas Pohlmann <pohlmann@aero-code.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen de_DE.UTF-8 en_US.UTF-8 de_DE de_DE@euro en_US

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD pre-update /

RUN dpkg-reconfigure -f noninteractive tzdata \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        bzip2 \
        ca-certificates \
        less \
        libgpm2 \
        locales \
        ncurses-term \
        procps \
        psmisc \
        software-properties-common \
        supervisor \
        vim \
        nodejs \
        npm \
        nginx-core \
        git \
    && apt-get -y remove \
        vim-tiny \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g less watch-less bower \
    && mkdir /srv/www \
    && chown -R www-data:www-data /srv

COPY post-update /

RUN cd /var/log \
    && find -type f | xargs rm \
    && rm -rf apt fsck news upstart \
    && touch btmp lastlog wtmp \
    && chgrp utmp lastlog \
    && chmod 664 lastlog \
    && chmod 600 btmp

CMD [ "sh", "/run.sh" ]

VOLUME [ "/srv/www" ]

EXPOSE 80