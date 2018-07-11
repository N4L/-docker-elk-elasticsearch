
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3


# see: https://bitbucket.org/eunjeon/seunjeon/raw/master/elasticsearch/scripts/downloader.sh
#bin/elasticsearch-plugin install --batch https://oss.sonatype.org/service/local/repositories/releases/content/org/bitbucket/eunjeon/elasticsearch-analysis-seunjeon/6.1.1.1/elasticsearch-analysis-seunjeon-6.1.1.1.zip

# can not find elasticsearch-jetty-2.2.0 on the Internet
#elasticsearch-jetty-2.2.0

# come with docker image
#bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-geoip/ingest-geoip-6.2.3.zip
# come with docker image
#bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-user-agent/ingest-user-agent-6.2.3.zip
RUN set -ex \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-icu-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-phonetic/analysis-phonetic-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-stempel/analysis-stempel-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-ukrainian/analysis-ukrainian-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/discovery-ec2/discovery-ec2-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/ingest-attachment/ingest-attachment-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/mapper-murmur3/mapper-murmur3-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/mapper-size/mapper-size-6.2.3.zip \
  && bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/repository-s3/repository-s3-6.2.3.zip
