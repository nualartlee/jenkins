FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
COPY init_credentials.groovy /usr/share/jenkins/ref/init.groovy.d/init_credentials.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Copy ssh key and set ownership
USER root
RUN mkdir /var/jenkins_home/.ssh
RUN cp /run/secrets/jenkins-key /var/jenkins_home/.ssh/jenkins-key
RUN cp /run/secrets/jenkins-key.pub /var/jenkins_home/.ssh/jenkins-key.pub
RUN chown jenkins:jenkins /var/jenkins_home/.ssh/jenkins-key
RUN chown jenkins:jenkins /var/jenkins_home/.ssh/jenkins-key.pub
USER jenkins

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt