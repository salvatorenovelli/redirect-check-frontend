
node {
    def project = 'redirect-check-180020'
    def appName = 'redirect-check-frontend'

    def svcName = "${appName}-service"

    def imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

    checkout scm

    stage 'Build project'

    sh("yarn install")
    sh("yarn build")

    stage 'Build image'
    sh("mv build docker")
    sh("docker build docker -t ${imageTag}")

    stage 'Push image to registry'
    sh("gcloud docker -- push ${imageTag}")

    stage "Deploy Application"
    sh("sed -i.bak 's#<IMAGE_TAG_DO_NOT_EDIT>#${imageTag}#' k8s/production.yaml")
    sh("cat k8s/production.yaml")
//  sh("kubectl --namespace=default apply -f k8s/production.yaml")

}
