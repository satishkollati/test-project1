FROM ubuntu
RUN apt-get -y update && apt-get install openjdk-11-jdk -y
RUN apt-get install vim -y
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.69/bin/apache-tomcat-9.0.69.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.69.tar.gz
RUN mv apache-tomcat-9.0.69 tomcat
RUN rm -rf /opt/tomcat/webapps/host-manager/META-INF/context.xml
COPY context1 /opt/tomcat/webapps/host-manager/META-INF/context.xml
RUN rm -rf /opt/tomcat/webapps/manager/META-INF/context.xml
COPY context2 /opt/tomcat/webapps/manager/META-INF/context.xml
RUN rm -rf /opt/tomcat/conf/tomcat-users.xml
COPY users  /opt/tomcat/conf/tomcat-users.xml
WORKDIR /var/lib/jenkins/workspace/Pipeline/webapp/target
COPY *.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
