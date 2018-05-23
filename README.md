# Jenkins CI Test

## Run

```bash
git clone https://github.com/magnobiet/ci-test-jenkins.git && cd $_
mkdir -p data/jenkins
sudo chown -Rf 1000:1000 data/
docker-compose up -d
```

## References

- https://github.com/jenkinsci/docker/blob/master/README.md
