FROM ruby:2.4-slim

ENV LANG="C.UTF-8" \
    DEPS="build-essential git libsqlite3-dev sqlite3 sudo" \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    BEEF_PASSWORD=beef123 \
    BEEF_USER=admin \
    BEEF_HOOK=hook.js \
    BEEF_HOOK_SESSION_NAME=BEEFHOOK \
    BEEF_PROXY_IP=

RUN apt-get update && \
	apt-get -y install $DEPS && \
	git clone --depth=1 --branch=master https://github.com/beefproject/beef.git /opt/beef
	
WORKDIR /opt/beef

RUN sed -i 's/apt-get/apt-get -y/g' install && \
	echo Y | /bin/bash install

COPY entrypoint.sh /tmp/entrypoint.sh

VOLUME /root/.beef

EXPOSE 3000 6789 61985 61986

ENTRYPOINT ["/tmp/entrypoint.sh"]
