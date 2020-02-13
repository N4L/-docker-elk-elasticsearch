# docker-elasticsearch

Elasticsearch (part of ELK stack)


[Official](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)  
[Official Dockerfile on Github](https://github.com/elastic/elasticsearch/blob/master/distribution/docker/src/docker/Dockerfile)  
[Official Github](https://github.com/elastic/elasticsearch)  
[Deprecated repo on Docker Hub](https://hub.docker.com/_/elasticsearch/)  


https://www.docker.elastic.co/


Default username/password: elastic/changeme


## Enable monitoring

PUT _cluster/settings
```json
{
  "persistent": {
    "xpack.monitoring.collection.enabled": true
  }
}
```


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


Default Kibana plugins come with docker image:  

ingest-geoip        6.2.3  
ingest-user-agent   6.2.3  

AWS Kibana instance plugins:  

analysis-icu        6.2.3  
analysis-kuromoji   6.2.3  
analysis-phonetic   6.2.3  
analysis-seunjeon   x.x.x.x  (AWS only)  
analysis-smartcn    6.2.3  
analysis-stempel    6.2.3  
analysis-ukrainian  6.2.3  
discovery-ec2       6.2.3  
elasticsearch-jetty 2.2.0    (AWS only)  
ingest-attachment   6.2.3  
ingest-user-agent   6.2.3  
mapper-murmur3      6.2.3  
mapper-size         6.2.3  
repository-s3       6.2.3  


### Performance

`GET /_stats`

If we are a write-heavy Elasticsearch user, 
we should use a tool like iostat to keep an eye on disk IO metrics over time.

`index.translog.flush_threshold_size`
