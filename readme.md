docker run --rm -v "$PWD":/app -w /app php/cli:7.4 -v

docker run --rm -v "$PWD":/app -w /app php/cli:7.4 -dmemory_limit=-1 /usr/local/bin/composer update
