FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY 1_security.groovy /usr/share/jenkins/ref/init.groovy.d/1_security.groovy
COPY 2_init_credentials.groovy /usr/share/jenkins/ref/init.groovy.d/2_init_credentials.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt