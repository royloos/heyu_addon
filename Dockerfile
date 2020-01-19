MAINTAINER Kevin Eye <kevineye@gmail.com>

RUN apk -U add curl build-base \
 && mkdir /build \
 && cd /build \
 && curl -LsSO https://github.com/msoap/shell2http/releases/download/1.12/shell2http-1.12.linux.arm.tar.gz \
 && tar xzf shell2http-1.12.linux.arm.tar.gz shell2http \
 && mv shell2http /usr/local/bin \
 && curl -LsSO http://www.heyu.org/download/heyu-2.11-rc1.tar.gz \
 && tar xzf heyu-2.11-rc1.tar.gz \
 && cd heyu-2.11-rc1 \
 && ./configure --sysconfdir=/etc \
 && make \
 && make install \
 && cd / \
 && apk --purge del curl build-base \
 && rm -rf /build /etc/ssl /var/cache/apk/* /lib/apk/db/*

RUN cp -r /etc/heyu /etc/heyu.default \
 && mkdir -p /usr/local/var/tmp/heyu \
 && mkdir -p /usr/local/var/lock \
 && chmod 777 /usr/local/var/tmp/heyu \
 && chmod 777 /usr/local/var/lock

VOLUME /etc/heyu
EXPOSE 80

COPY heyu-run.sh /usr/local/bin/heyu-run
CMD heyu-run
