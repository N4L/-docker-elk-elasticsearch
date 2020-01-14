
ARG IMAGE_ARG_ES_IMAGE_NAME
ARG IMAGE_ARG_ES_IMAGE_VERSION

FROM docker.elastic.co/elasticsearch/${IMAGE_ARG_ES_IMAGE_NAME:-elasticsearch}:${IMAGE_ARG_ES_IMAGE_VERSION:-7.5.1} as base

FROM scratch

COPY --from=base / /

# see: https://bitbucket.org/eunjeon/seunjeon/raw/master/elasticsearch/scripts/downloader.sh
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://oss.sonatype.org/service/local/repositories/releases/content/org/bitbucket/eunjeon/elasticsearch-analysis-seunjeon/6.1.1.1/elasticsearch-analysis-seunjeon-6.1.1.1.zip

# can not find elasticsearch-jetty-2.2.0 on the Internet
#elasticsearch-jetty-2.2.0

# come with docker image
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-geoip/ingest-geoip-${IMAGE_ARG_ES_IMAGE_VERSION:-7.5.1}.zip
# come with docker image
#/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-user-agent/ingest-user-agent-${IMAGE_ARG_ES_IMAGE_VERSION:-7.5.1}.zip
RUN set -ex \
  && cd /usr/share/elasticsearch \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-icu-${IMAGE_ARG_ES_IMAGE_VERSION:-7.5.1}.zip \
  && bin/elasticsearch-plugin install --batch analysis-kuromoji \
  && bin/elasticsearch-plugin install --batch analysis-phonetic \
  && bin/elasticsearch-plugin install --batch analysis-smartcn \
  && bin/elasticsearch-plugin install --batch analysis-stempel \
  && bin/elasticsearch-plugin install --batch analysis-ukrainian \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/discovery-ec2/discovery-ec2-${IMAGE_ARG_ES_IMAGE_VERSION:-7.5.1}.zip \
  && bin/elasticsearch-plugin install --batch ingest-attachment \
  && bin/elasticsearch-plugin install --batch mapper-murmur3 \
  && bin/elasticsearch-plugin install --batch mapper-size \
  && bin/elasticsearch-plugin install --batch repository-s3

# Remove X-Pack. see: [Unable to Uninstall X-Pack with elasticsearch:5.2.2 Docker Image #36](https://github.com/elastic/elasticsearch-docker/issues/36)
# RUN set -ex \
#   && ls -la /usr/share/elasticsearch/plugins \
#   && mv /usr/share/elasticsearch/plugins/x-pack /usr/share/elasticsearch/plugins/.removing-x-pack \
#   && mv /usr/share/elasticsearch/plugins/.removing-x-pack /usr/share/elasticsearch/plugins/x-pack \
#   && /usr/share/elasticsearch/bin/elasticsearch-plugin remove x-pack

ENV ELASTIC_CONTAINER true
ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME /usr/share/elasticsearch/jdk

WORKDIR /usr/share/elasticsearch

RUN chown -R elasticsearch:0 \
      /usr/local/bin/docker-entrypoint.sh \
      config \
      data \
      logs \
    && chmod 0775 config data logs \
    && chown elasticsearch:0 \
      /usr/share/elasticsearch \
      config/elasticsearch.yml \
      config/log4j2.properties
#      config/x-pack/log4j2.properties \
#      bin/es-docker && \
#    chmod 0750 bin/es-docker

# Openshift overrides USER and uses ones with randomly uid>1024 and gid=0
# Allow ENTRYPOINT (and ES) to run even with a different user
RUN chgrp 0 /usr/local/bin/docker-entrypoint.sh && \
    chmod g=u /etc/passwd && \
    chmod 0775 /usr/local/bin/docker-entrypoint.sh

EXPOSE 9200 9300

COPY --chown=elasticsearch docker /
RUN set -ex \
  && chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# Dummy overridable parameter parsed by entrypoint
CMD ["eswrapper"]
