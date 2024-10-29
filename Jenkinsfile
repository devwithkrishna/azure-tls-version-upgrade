
pipeline{
    agent{
        docker {image 'mcr.microsoft.com/azure-cli' 
         args "--user root --privileged" }
    }
options {
        ansiColor('xterm')
    }
    parameters {
        string(name: 'azure_storage_account_name', defaultValue: 'techarchitectssa', description: 'names of azure storage account')
        string(name: 'azure_storage_account_rg', defaultValue: 'ARCHITECTS-STORAGE-RG', description: 'azure resource group name')
        choice(name: 'tls_version', choices: ['TLS_0', 'TLS_1', 'TLS_2'], description: 'Minimum TLS version')

    }
    
    stages{
         
        stage('Deleting the resource groups'){
            steps{
                withCredentials([azureServicePrincipal(credentialsId: 'Contributor-role-SP',
                                                    subscriptionIdVariable: 'SUBS_ID',
                                                    clientIdVariable: 'CLIENT_ID',
                                                    clientSecretVariable: 'CLIENT_SECRET',
                                                    tenantIdVariable: 'TENANT_ID')]) {


                echo "============== starting script ================="
                sh '''
                
                '''
                sh (script:"az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID && \
                az account show && \
                ls && \
                chmod +x tls_changes.sh && \
                ./tls_changes.sh '${params.azure_storage_account_name}' '${params.azure_storage_account_rg}' '${params.tls_version}'")
                                           
                }
            }
        }
    }    
post {
        // Clean after build
       
        always {
            echo "========Cleaning workspace========"
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
                
        }
    }
}
