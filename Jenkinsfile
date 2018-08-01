def DockerApp

node ('Docker') {
        stage ('Checkout') {
                checkout scm
        }
        withDockerRegistry([credentialsId: '99ec6d6e-d2f6-4af6-9bbc-3ee43e321123', url: 'http://registry.dyalog.com:5000']) {
                stage ('Build Docker Image') {
                        DockerApp = docker.build 'registry.dyalog.com:5000/dyalog/miserver:ms3'
                }
                stage ('Test website') {
                        def MiServer = DockerApp.run ()
                        try {
				//Get the IP of the container
				def DOCKER_MS = sh (
					script: "docker inspect ${MiServer.id} | jq .[0].NetworkSettings.IPAddress | sed 's/\"//g'",
					returnStdout: true
				).trim()
                                sh "sleep 5; curl -s --retry 5 --retry-delay 5 -q http://${DOCKER_MS}:8080/ | grep \"Dyalog MiServer 3.0 Sample Site\" >/dev/null"
                                MiServer.stop()
                        } catch (Exception e) {
                                println 'Failed to find string "Dyalog MiServer 3.0 Sample Site" cleaning up.'
				sh "docker logs ${MiServer.id}"
                                sh "git rev-parse --short HEAD > .git/commit-id"
                                withCredentials([string(credentialsId: '7ac3a2c6-484c-4879-ac85-2b0db71a7e58', variable: 'GHTOKEN')]) {
                                        commit_id = readFile('.git/commit-id')
                                        sh "./githubComment.sh ${MiServer.id} ${commit_id}"
                                }
                                MiServer.stop()
                                sh 'docker rmi registry.dyalog.com:5000/dyalog/miserver:ms3'
                                throw e;
                        }
                }
                stage ('Publish Docker image') {
                        if (env.BRANCH_NAME.contains('MiServer3')) {
                                sh 'docker push registry.dyalog.com:5000/dyalog/miserver:ms3'
                        }
                }
        }

        stage ('Cleanup') {
                        if (env.BRANCH_NAME.contains('MiServer3')) {
                                sh 'docker rmi registry.dyalog.com:5000/dyalog/miserver:ms3'
                        }
        }
	
	stage ('Github Upload') {
		withCredentials([string(credentialsId: '7ac3a2c6-484c-4879-ac85-2b0db71a7e58', variable: 'GHTOKEN')]) {
			sh './GH-Release.sh'
		}

        }


}

