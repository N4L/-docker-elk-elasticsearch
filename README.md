# docker-elasticsearch

Elasticsearch (part of ELK stack)

[Official](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
[Official Dockerfile on Github](https://github.com/elastic/elasticsearch-docker)
[Official Github](https://github.com/elastic/elasticsearch)
[Deprecated repo on Docker Hub](https://hub.docker.com/_/elasticsearch/)


## The `vm.max_map_count` kernel setting needs to be set to at least 262144 for production use.

Depending on your platform:

- Linux

The vm.max_map_count setting should be set permanently in /etc/sysctl.conf:

```bash
grep vm.max_map_count /etc/sysctl.conf
# or
sysctl vm.max_map_count
#vm.max_map_count=262144
```

To apply the setting on a live system type: `sysctl -w vm.max_map_count=262144`

- macOS with Docker for Mac

The vm.max_map_count setting must be set within the xhyve virtual machine:

```bash
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
```

Log in with root and no password. Then configure the sysctl setting as you would for Linux:

```bash
sysctl -w vm.max_map_count=262144
sysctl vm.max_map_count
```
