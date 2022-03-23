FROM daggerok/jboss-eap-7.1:7.1.61-alpine
COPY ./helloworld-project/helloworld-ws/target/*.war ${JBOSS_HOME}/standalone/deployments/
