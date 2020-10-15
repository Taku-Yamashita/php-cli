![](https://github.com/Taku-Yamashita/php-cli/workflows/Build/badge.svg)
![](https://github.com/Taku-Yamashita/php-cli/workflows/Test/badge.svg)
![](https://badgen.net/github/dependabot/Taku-Yamashita/php-cli)

docker run --rm -v "$PWD":/app -w /app ytaku/php-cli:${VERSION} -v

docker run --rm -v "$PWD":/app -w /app ytaku/php-cli:${VERSION} -dmemory_limit=-1 /usr/local/bin/composer
