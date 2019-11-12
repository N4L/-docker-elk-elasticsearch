
$p = (pwd) -replace "([A-Z]{1}):\\","/`$1/"
$env:PWD = ($p.substring(0,2).ToLower() + $p.substring(2)).replace("\", "/")
Get-ChildItem Env:PWD

$env:LOGGER_LEVEL = "INFO"
#$env:LOGGER_LEVEL = "TRACE"
$env:ELASTICSEARCH_THREAD_POOL_WRITE_SIZE = "3"
$env:ES_JAVA_OPTS = "-Xms5120m -Xmx5120m"
$env:MEM_LIMIT = "10g"

$env:IMAGE_ARG_ES_IMAGE_NAME = 'elasticsearch'

docker-compose down -v

$confirmation = Read-Host "Do you want clear data"
if ($confirmation -eq "y") {
    Remove-Item -Path "data\data\*" -Exclude ".gitignore" -Recurse;
}

docker-compose up -d
docker-compose logs -f
