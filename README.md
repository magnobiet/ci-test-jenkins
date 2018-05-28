# Jenkins CI Test

## Run

```bash
git clone https://github.com/magnobiet/ci-test-jenkins.git && cd $_

sudo addgroup jenkins
sudo usermod -a -G jenkins $USER

mkdir -p data/jenkins
sudo chown -Rf jenkins:$USER

docker-compose up -d
```

## Packages

- Node.js
  - [NPM](https://www.npmjs.com)
  - [Yarn](https://yarnpkg.com/)
  - [Bower](https://bower.io)
  - [Gulp](https://gulpjs.com)
  - [Grunt](https://gruntjs.com)
  - [webpack](https://webpack.js.org/)
- PHP
  - [Composer](https://github.com/composer/composer)
  - [PHPUnit](https://github.com/sebastianbergmann/phpunit/)
  - [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)
  - [PHPLOC](https://github.com/sebastianbergmann/phploc)
  - [PHP_Depend](https://github.com/pdepend/pdepend)
  - [PHPMD](https://github.com/phpmd/phpmd)
  - [PHPCPD](https://github.com/sebastianbergmann/phpcpd)
  - [phpDox](https://github.com/theseer/phpdox)

## References

- https://github.com/jenkinsci/docker
- https://github.com/afonsof/jenkins-material-theme
- http://jenkins-php.org/
