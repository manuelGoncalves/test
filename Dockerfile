FROM tomcat:jre8-slim
RUN curl http://10.39.42.15/hbo-go-service-1.5.2-SNAPSHOT.war
