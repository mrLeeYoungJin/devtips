# docker 명령어

## build

### Dockerfile 경로 위치에서 실행
```
docker build --tag gwlab/project .
```

## run
```
docker run -d --name project -p 8080:8080 gwlab/project
```

## container delete

```
docker rm -f project
```

## images delete

```
docker rmi gwlab/project
or
docker rmi tagId
```

