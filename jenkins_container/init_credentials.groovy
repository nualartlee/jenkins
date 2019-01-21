/*
 Based on https://github.com/Accenture/adop-jenkins/blob/master/resources/init.groovy.d/adop_general.groovy
*/
import jenkins.model.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey;
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl;
import com.cloudbees.plugins.credentials.CredentialsScope;
import com.cloudbees.plugins.credentials.SystemCredentialsProvider;

// Constants
def instance = Jenkins.getInstance()

Thread.start {


    // Create a passphrase
    def ssh_key_passphrase = org.apache.commons.lang.RandomStringUtils.randomAlphanumeric(27)

    // Create keys if not already present
    println "/usr/share/jenkins/ref/create_ssh_keys.sh $ssh_key_passphrase".execute().text

    def system_credentials_provider = SystemCredentialsProvider.getInstance()

    // Add global deployment credentials for SSH
    println "--> Registering SSH Credentials"

    def ssh_key_description = "SSH credentials for remote build commands"
    def ssh_key_scope = CredentialsScope.GLOBAL
    def ssh_key_id = "build-key"
    def ssh_key_username = "manager"
    def ssh_key_private_key_source = new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource ("/var/jenkins_home/.ssh/jenkins-key")
    // def ssh_key_passphrase = null

    // Add ssh key as private key type
    ssh_credentials_exist = false
    system_credentials_provider.getCredentials().each {
        credentials = (com.cloudbees.plugins.credentials.Credentials) it
        if ( credentials.getDescription() == ssh_key_description) {
            ssh_credentials_exist = true
            println("Found existing credentials: " + ssh_key_description)
        }
    }

    if(!ssh_credentials_exist) {
        def ssh_key_domain = com.cloudbees.plugins.credentials.domains.Domain.global()
        def ssh_key_creds = new BasicSSHUserPrivateKey(ssh_key_scope,ssh_key_id,ssh_key_username,ssh_key_private_key_source,ssh_key_passphrase,ssh_key_description)
        system_credentials_provider.addCredentials(ssh_key_domain,ssh_key_creds)
    }

    // Save the state
    instance.save()
}