stage 'build' 

parallel 'buildOnSlave1':{
	node('TestSlave1') {
	   	checkout([$class: 'GitSCM', branches: [[name: '*/JenkinsTest']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alan-wu/manage.git']]])

		echo 'Checked out'
		dir('./build') {
			echo 'In the build directory'
			sh '../../../../../cmake-3.4.3-Linux-x86_64/bin/cmake -DMPI=openmpi -DMPI_HOME="" -DSYSTEM_MPI=NO -DEVIL=YES -DOC_PYTHON_BINDINGS_USE_VIRTUALENV=NO ..'
			sh 'make'
			echo 'Built'
			step([$class: 'GitHubCommitStatusSetter', statusResultSource: [$class: 'ConditionalStatusResultSource', results: [[$class: 'BetterThanOrEqualBuildResult', message: 'Build succeeded.', result: 'SUCCESS', state: 'SUCCESS']]]])
			echo 'done'
			echo 'test'		
		}
	}
}, 'buildOnSlave2':{
	node('TestSlave2') {
	   	checkout([$class: 'GitSCM', branches: [[name: '*/JenkinsTest']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alan-wu/manage.git']]])

		echo 'Checked out'
		dir('./build') {
			sh '../../../../../cmake-3.4.3-Linux-x86_64/bin/cmake -DMPI=openmpi -DMPI_HOME="" -DSYSTEM_MPI=NO -DEVIL=YES -DOC_PYTHON_BINDINGS_USE_VIRTUALENV=NO ..'
			sh 'make'
			echo 'Built'
			step([$class: 'GitHubCommitStatusSetter', statusResultSource: [$class: 'ConditionalStatusResultSource', results: [[$class: 'BetterThanOrEqualBuildResult', message: 'Build succeeded.', result: 'SUCCESS', state: 'SUCCESS']]]])
			echo 'done'
			echo 'test'		
		}
	}
}
