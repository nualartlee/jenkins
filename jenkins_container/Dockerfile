FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Djava.awt.headless=true \
-Dmail.smtp.starttls.enable=true -Dmail.smtps.ssl.protocols=TLSv1.2  -Duser.timezone=America/Vancouver"

COPY create_ssh_keys.sh /usr/share/jenkins/ref/create_ssh_keys.sh
COPY print_public_key.sh /usr/share/jenkins/ref/print_public_key.sh
COPY set_user.groovy /usr/share/jenkins/ref/init.groovy.d/set_user.groovy
COPY set_ssh_key.groovy /usr/share/jenkins/ref/init.groovy.d/set_ssh_key.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
