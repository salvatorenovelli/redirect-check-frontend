node {
    def project = 'redirect-check-180020'
    def appName = 'redirect-check-backend'

    def svcName = "${appName}-service"

    def imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

    checkout scm

    stage 'Build project'
    sh("npm install yarn")
    sh("yarn install")
    sh("yarn build")

    stage 'Build image'
    sh("docker build docker -t ${imageTag}")

    stage 'Push image to registry'
    sh("gcloud docker -- push ${imageTag}")

    stage "Deploy Application"
    sh("sed -i.bak 's#<IMAGE_TAG_DO_NOT_EDIT>#${imageTag}#' k8s/production.yaml")
    sh("cat k8s/production.yaml")
//    sh("kubectl --namespace=default apply -f k8s/production.yaml")

}
