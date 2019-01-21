FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

USER root
RUN mkdir /var/jenkins_home/.ssh
RUN ssh-keygen -f /var/jenkins_home/.ssh/jenkins-key -q -N ""
RUN chown -R jenkins:jenkins /var/jenkins_home/.ssh
USER jenkins

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
COPY init_credentials.groovy /usr/share/jenkins/ref/init.groovy.d/init_credentials.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
