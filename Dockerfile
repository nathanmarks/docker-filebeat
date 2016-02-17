FROM debian:jessie

ENV FILEBEAT_VERSION 1.1.1
ENV FILEBEAT_SHA1 05f99d2f61fee1608d01f583a2d0737a53bbd4b5 

ADD https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz /tmp/filebeat.tar.gz

RUN echo "${FILEBEAT_SHA1}  /tmp/filebeat.tar.gz" > /tmp/filebeat.sha1 && \
    sha1sum -c /tmp/filebeat.sha1 && \
    mkdir -p /usr/src/filebeat && \
    mkdir -p /etc/filebeat && \
    tar zxvf /tmp/filebeat.tar.gz -C /usr/src/filebeat && \
    cp /usr/src/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64/filebeat /bin && \
    cp /usr/src/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64/filebeat.yml /etc/filebeat && \
    cp /usr/src/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64/filebeat.template.json /etc/filebeat && \
    rm -rf /tmp/filebeat.tar.gz /tmp/filebeat.sha1

ENTRYPOINT ["/bin/filebeat", "-e", "-v", "-c", "/etc/filebeat/filebeat.yml"]
