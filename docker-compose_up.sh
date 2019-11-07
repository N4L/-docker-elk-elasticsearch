
docker-compose down -v

read -p "Do you want clear data: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find data/data ! -name '.gitignore' -type f -exec rm -rf {} +
fi

docker-compose up -d
docker-compose logs -f
