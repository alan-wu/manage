stage 'build' 

parallel 'Slave1':{
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
}, 'Slave2':{
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

stage 'tests'

parallel 'Slave1':{
	node('TestSlave1') {
		echo 'Zinc tests'
		dir('../build/x86_64_linux/gnu-C4.8-gnu-F4.8/no_mpi/zinc/release') {
			sh 'make test'
		}
		echo 'iron tests'
		dir('../build/x86_64_linux/gnu-C4.8-gnu-F4.8/openmpi_release/iron/release') {
			sh 'make test'
		}
	}
}, 'Slave2':{
	node('TestSlave2') {
		dir('./build/x86_64_linux/gnu-C4.8-gnu-F4.8/no_mpi/zinc/release') {
			sh 'make test'
		}
	}
}
