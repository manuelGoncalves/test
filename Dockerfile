FROM registry.access.redhat.com/jboss-eap-6/eap-openshift:6.4
EXPOSE 8080 8888
RUN curl http://10.39.42.15/hbo-go-service-1.5.2-SNAPSHOT.war -o $JBOSS_HOME/standalone/deployments/ROOT.war
