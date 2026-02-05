# nvim editor on Alpine

Sets up `uv`, `ruff`linter/formatter and `ty` type checker.


## Build
```
docker build . -t <YOUR_IMAGE_TAG: eg siuyin/edt:latest>
```

## Run
```
docker run --name edt -it -v ${HOME}:/h <YOUR_IMAGE_TAG>
```

## Cleanup
```
docker rm edt
doker rmi <YOUR_IMAGE_TAG>
```
