stage 'build' 

parallel 'Slave1':{
	node('TestSlave1') {
		dir('./oc/manage') {
		   	checkout([$class: 'GitSCM', branches: [[name: '*/JenkinsTest']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alan-wu/manage.git']]])
	}
		echo 'Checked out'
		dir('./oc/manage/build') {
			echo 'In the build directory'
			sh '../../../../../../../cmake-3.4.3-Linux-x86_64/bin/cmake -DMPI=openmpi -DMPI_HOME="" -DSYSTEM_MPI=NO -DEVIL=YES -DOC_PYTHON_BINDINGS_USE_VIRTUALENV=NO ..'
			sh 'make'
			echo 'Built'
			echo 'done'
			echo 'test'		
		}
	}
}, 'Slave2':{
	node('TestSlave2') {
		echo 'HPC Disabled'
	}
}, 'Slave3':{
	node('TestSlave3') {
		dir('./oc/manage') {
		   	checkout([$class: 'GitSCM', branches: [[name: '*/JenkinsTest']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/alan-wu/manage.git']]])
		}
		echo 'Checked out'
		dir('./oc/manage/build') {
			sh '/Users/mwu035/cmake-3.6.1/CMake.app/Contents/bin/cmake -DEVIL=YES  -DOC_USE_GTEST=YES -DOC_BUILD_ZINC_TESTS=YES -DBUILD_TESTS=OFF ..'
			sh 'make'
			echo 'Built'
			echo 'done'
			echo 'test'		
		}
	}
}

step([$class: 'GitHubCommitStatusSetter', statusResultSource: [$class: 'ConditionalStatusResultSource', results: [[$class: 'BetterThanOrEqualBuildResult', message: 'Build succeeded.', result: 'SUCCESS', state: 'SUCCESS']]]])

stage 'tests'

parallel 'Slave1':{
	node('TestSlave1') {
		echo 'Zinc tests'
		dir('./oc/build/x86_64_linux/gnu-C4.8-gnu-F4.8/no_mpi/zinc/release') {
			sh 'make test'
		}
		echo 'iron tests'
		dir('./oc/build/x86_64_linux/gnu-C4.8-gnu-F4.8/openmpi_release/iron/release') {
			sh 'make test'
		}
	}
}, 'Slave2':{
	node('TestSlave2') {
		echo 'HPC Disabled'
	}
}, 'Slave3':{
	node('TestSlave3') {
		echo 'Zinc tests'
		dir('./oc/build/x86_64_darwin/clang-C6.0-gnu-F4.5/no_mpi/zinc/release') {
		   	sh 'make test'
		}
	}
}
