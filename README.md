# Glowroot Central Log Usage

Taking as reference the official [doc¹](https://github.com/glowroot/glowroot/wiki/Agent-Installation-%28for-Central-Collector%29) and [doc²](https://github.com/glowroot/glowroot/wiki/Central-Collector-Installation) from Glowroot, is possible to start a Cassandra database using docker

Follow the instructions as below:

1-) Run the following command to install cassandra:

```
docker run --name mycassandra -d cassandra
```

2-) Run the following command to start 

```
docker run --name myglowroot --link mycassandra:cassandra --publish 0.0.0.0:4000:4000 --publish 0.0.0.0:8181:8181 tsoutello/glowroot-central:0.13.6-1
```

You should see something like below

![](documentation\images\starting_docker_glowroot_run.png)

PS: This is not using from the official document as there is open bug from the official document which causes the issue

```
standard_init_linux.go:211: exec user process caused "no such file or directory"
```

https://github.com/glowroot/glowroot/issues/626 not resolved in [0.13.6](https://github.com/glowroot/glowroot/releases/tag/v0.13.6), 

3-) Run the instances agains the central glowroot

You can use https://github.com/timoteosoutello/dev-spring-data-rest as instance, in my case I runned two instances with the following commands in two different local ports using the 8181 (gRPC port protocol):

- java -Dserver.port=9090 -javaagent:<GLOWROOT_DIR>\glowroot.jar -Dglowroot.multi.dir=true -Dglowroot.agent.id=service-1 -Dglowroot.agent.rollup.id=production -Dglowroot.collector.address=localhost:8181 -jar <JAR_FILE>
- java -Dserver.port=9091 -javaagent:<GLOWROOT_DIR>\glowroot.jar -Dglowroot.multi.dir=true -Dglowroot.agent.id=service-2 -Dglowroot.agent.rollup.id=production -Dglowroot.collector.address=localhost:8181 -jar <JAR_FILE>

Outcome should something like below (more then one instance shall be present):

PS: The **glowroot.agent.id** will represent the service name in the selected instances

![](documentation\images\glowroot_web_instances.png)