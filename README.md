
CROSSFLOW DOCKER SETUP AND EXECUTION
=============================================================================

This document explains how to build and setup a docker-machine running the
Crossflow Docker infrastructure setup, which includes services offered by
Apache Hadoop, Apache Hive, and Apache Flink.

Exemplary use case include:
- Clone a list of Git repositories to an instance of a HDFS distributed file system.
- Walk through all commits of a list of Git repositories stored in HDFS.


STEPS (short version):
----------------------

1) Open two instances of terminal/bash windows and change to this directory.

2) Run the following commands in one terminal/bash window:

   `$ source 1a-establish-docker-machine.sh`

   `$ source 1b-build-all.sh` (optional)

   `$ source 1c-sync-and-start-containers.sh`

3) Run the following command in the other terminal/bash window:

   `$ source 2-run-tests.sh`

4) Cleanup after use:

   `$ source 3-remove-all.sh`


EXPOSED WEB INTERFACES:
-----------------------

- Apache Hadoop Overview:

   `http://DOCKER-MACHINE-IP:50070/dfshealth.html#/`

- Apache Hadoop HDFS Directory Browser:

   `http://DOCKER-MACHINE-IP:50070/explorer.html#/`

- Apache Flink Dashboard:

   `http://DOCKER-MACHINE-IP:8081/#/overview`


NOTES AND FURTHER INFORMATION:
------------------------------

- In case script files are causing permission denied errors or similar,
  make sure they are executable. You can make all files located in the
  current directory (recursively) and ending with "sh" executable by
  running the following command:

  `$ find . -type f -iname "*.sh" -exec chmod +x {} \;`

- In order to change the test to be executed, adapt the `-Dtest` parameter in
  `2-run-tests.sh` to reflect the appropriate class and (optionally) method
  as follows:

  `$ -Dtest=JAVA_JUNIT_TEST_CLASS_NAME#JAVA_JUNIT_TEST_CLASS_METHOD_NAME`

- Executing `source 1a-establish-docker-machine.sh` will allocate a predefined
  amount of memory and disk space for the docker-machine. These default values
  can be modified by passing additional arguments as follows:

  `source 1a-establish-docker-machine.sh 4096 25000`

  Note: the 1st argument specifies the amount of memory in MB and
  the 2nd argument specifies the amount of disk space in MB.

- Executing `source 1b-build-all.sh` may take a couple of minutes to complete.

- Executing `source 1c-sync-and-start-containers.sh` may ask you to add the created
  docker-machine to your list of known hosts. Confirm by typing `yes` followed
  by return.

- Browsing to `http://DOCKER-MACHINE-IP:50070/explorer.html#/` reveals the
  content stored in HDFS.

- Browsing to `http://DOCKER-MACHINE-IP:50070/dfshealth.html#tab-datanode` will
  reveal information on running Hadoop data nodes.

- Browsing to `http://DOCKER-MACHINE-IP:8081/#/overview` will reveal the Apache
  Flink Dashboard

- The docker-machine IP address can be retrieved by running the following command:

  `$ docker-machine ip crossflow`

- All scripts are to be executed from within this directory.

- In case `java.lang.InterruptedException` is caught during runtime, it may be
  due to the documented Hadoop bug [HDFS-10429](https://issues.apache.org/jira/browse/HDFS-10429)
  and can be ignored.

- Remove data created by Hadoop by running the following command:

  `$ source 3a-remove-hadoop-data.sh`

- Remove known hosts created by Docker by running the following command:

  `$ source 3b-remove-known-docker-hosts.sh`

- Remove crossflow docker-machine created by 1a-establish-docker-machine.sh:

  `$ source 3c-remove-docker-machine.sh`

- Also see [uhopper/hadoop](https://hub.docker.com/r/uhopper/hadoop/) for more information.


STEPS (long version):
---------------------

- Create docker-machine:

  `$ docker-machine create crossflow`

- Check if created docker-machine is up and running:

  `$ docker-machine ls`

- Get environment commands for created machine:

  `$ docker-machine env crossflow`

- Enable docker client to access created machine:

  `$ eval $(docker-machine env crossflow)`

- Run the following command to build:

  `$ source 1b-build-all.sh` (optional)

- Startup containers (keep terminal/bash window open for diagnostics):

  `$ source 1c-sync-and-start-containers.sh`

- Open a new terminal/bash instance and connect to existing docker-machine:

  `$ docker-machine env crossflow`

  `$ eval $(docker-machine env crossflow)`

- Execute test:

  `$ docker run -it --rm --network crossflow --name crossflow-cli -v "$PWD":/usr/src/crossflow -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/crossflow/target" -w /usr/src/crossflow maven:3.5.4-jdk-8 mvn -Dtest=JAVA_JUNIT_TEST_CLASS_NAME#JAVA_JUNIT_TEST_CLASS_METHOD_NAME -DfailIfNoTests=false test`

- Cleanup after use:

  `$ source 3-remove-all.sh`
