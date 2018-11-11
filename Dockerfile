
ARG IMAGE_ARG_ES_IMAGE_NAME
ARG IMAGE_ARG_ES_IMAGE_VERSION

FROM docker.elastic.co/elasticsearch/${IMAGE_ARG_ES_IMAGE_NAME:-elasticsearch}:${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10} as base

FROM scratch

COPY --from=base / /

# see: https://bitbucket.org/eunjeon/seunjeon/raw/master/elasticsearch/scripts/downloader.sh
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://oss.sonatype.org/service/local/repositories/releases/content/org/bitbucket/eunjeon/elasticsearch-analysis-seunjeon/6.1.1.1/elasticsearch-analysis-seunjeon-6.1.1.1.zip

# can not find elasticsearch-jetty-2.2.0 on the Internet
#elasticsearch-jetty-2.2.0

# come with docker image
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-geoip/ingest-geoip-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip
# come with docker image
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-user-agent/ingest-user-agent-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip
RUN set -ex \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-icu-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-phonetic/analysis-phonetic-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-stempel/analysis-stempel-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-ukrainian/analysis-ukrainian-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/discovery-ec2/discovery-ec2-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-attachment/ingest-attachment-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/mapper-murmur3/mapper-murmur3-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/mapper-size/mapper-size-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/repository-s3/repository-s3-${IMAGE_ARG_ES_IMAGE_VERSION:-5.6.10}.zip

# Remove X-Pack. see: [Unable to Uninstall X-Pack with elasticsearch:5.2.2 Docker Image #36](https://github.com/elastic/elasticsearch-docker/issues/36)
RUN set -ex \
  && ls -la /usr/share/elasticsearch/plugins \
  && mv /usr/share/elasticsearch/plugins/x-pack /usr/share/elasticsearch/plugins/.removing-x-pack \
  && mv /usr/share/elasticsearch/plugins/.removing-x-pack /usr/share/elasticsearch/plugins/x-pack \
  && /usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack

ENV ELASTIC_CONTAINER true
ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

WORKDIR /usr/share/elasticsearch

RUN chown -R elasticsearch:elasticsearch \
      config \
      data \
      logs && \
    chown elasticsearch:elasticsearch \
      /usr/share/elasticsearch \
      config/elasticsearch.yml \
      config/log4j2.properties \
      config/x-pack/log4j2.properties \
      bin/es-docker && \
    chmod 0750 bin/es-docker

USER elasticsearch

CMD ["/bin/bash", "bin/es-docker"]

EXPOSE 9200 9300
