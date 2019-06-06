FROM tomcat:jre8-slim
RUN curl http://10.39.42.66/hbo-go-service-1.5.2-SNAPSHOT.war -o ./webaspps/hbo.war
