
export LOGGER_LEVEL="INFO"
#export LOGGER_LEVEL="TRACE"
export ELASTICSEARCH_THREAD_POOL_WRITE_SIZE="3"
export ES_JAVA_OPTS="-Xms5120m -Xmx5120m"
export MEM_LIMIT="10g"

docker-compose down -v

read -p "Do you want clear data: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find data/usr/share/elasticsearch/data ! -name '.gitignore' -type f -exec rm -rf {} +
fi

docker-compose up -d
docker-compose logs -f
