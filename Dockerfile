FROM library/alpine:3.5

ENV FILEBEAT_VERSION=5.2.1 \
    FILEBEAT_SHA1=694fe12e56ebf8e4c4b11b590cfb46c662e7a3c1 \
    GLIBC_VERSION=2.25-r0

# Install filebeat
RUN wget -q -O /tmp/filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz \
    && cd /tmp \
    && echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - \
    && tar xzvf filebeat.tar.gz \
    && cd filebeat-* \
    && cp filebeat /bin \
    && mkdir -p /etc/filebeat \
    && cp filebeat.yml /etc/filebeat/filebeat.example.yml \
    && rm -rf /tmp/filebeat* \
    && apk del .build-deps

HEALTHCHECK --interval=5s --timeout=3s \
    CMD ps aux | grep '[f]ilebeat' || exit 1

CMD [ "filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]



FROM tomcat:jre8-slim
ENV TZ=Europe/Budapest
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN mkdir -p /app/
RUN mkdir -p /app/users/
RUN mkdir -p /app/users/hbogo/
RUN mkdir -p /app/users/hbogo/logs/
RUN mkdir -p /app/logs/
RUN chmod -R 777  /app/logs
RUN chmod -R 777  /app/users/hbogo/logs/
RUN apt-get install nano less -y
RUN apt-get install curl less -y
RUN sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties
RUN curl http://10.39.42.66/hbo-go-service-1.5.2-SNAPSHOT.war -o /usr/local/tomcat/webapps/hbo-go-service.war
RUN chmod -R 777  /usr/local/tomcat/webapps
RUN chmod -R 777  /usr/local/tomcat/temp
RUN chmod -R 777  /usr/local/tomcat/work
RUN chmod -R 777  /usr/local/tomcat/logs


