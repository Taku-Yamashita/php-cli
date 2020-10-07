![](https://github.com/Taku-Yamashita/php-cli/workflows/Build/badge.svg)

docker run --rm -v "$PWD":/app -w /app ytaku/php-cli:${VERSION} -v

docker run --rm -v "$PWD":/app -w /app ytaku/php-cli:${VERSION} -dmemory_limit=-1 /usr/local/bin/composer
