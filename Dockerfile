FROM tomcat:jre8-slim
ENV TZ=Europe/Budapest
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install nano less -y
RUN apt-get install curl less -y
RUN sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties
RUN curl http://10.39.42.66/hbo-go-service-1.5.2-SNAPSHOT.war -o /usr/local/tomcat/webapps/
