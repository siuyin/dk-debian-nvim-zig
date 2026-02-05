# nvim editor on Debian

Sets up `zig` with `zls` language server and `nvim` on Debian.


## Build
```
docker build . -t <YOUR_IMAGE_TAG: eg siuyin/ziged:latest>
```

## Run
```
docker run --name ziged -it -v ${HOME}:/h <YOUR_IMAGE_TAG>
```

## Cleanup
```
docker rm ziged
doker rmi <YOUR_IMAGE_TAG>
```
