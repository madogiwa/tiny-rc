
This is "rc" script for multi-process Linux containers implement by shell script only.

## What is useful for this?

Sometimes, to make a multi-process container is inevitable.
A simple approach to make multi-process container is write shell script as following.

```
#!/bin/sh
cron &                  # run cron as background process
nginx -g 'daemon off;'  # run nginx as foreground process

## In Dockerfile, specify this shell script as CMD
## CMD ["run.sh"]
```

This approach has disadvantage which do not have error handling.
For example, even if cron dies, nginx will keep running.

An other approach is introduce a supervisor program such as `supervisord`.
Supervisor program has error handling. However, this approach has another disadvantage which is painfull of install. How to install of supervisor is depend on base image as follows.

```
## for debian
RUN apt-get update && apt-get install -y supervisor

## for alpine
RUN apk update && apk add -u py-pip && pip install supervisor

## for centos:7
RUN yum install -y epel-release && yum install -y python-pip && pip install superisor

## for ...
RUN ...
```

The tiny-rc is implemented by shell script only. So no additional install needed.
Also, the tiny-rc is supported various containers such as:

- [alpine](https://hub.docker.com/_/alpine/)
- [ubuntu](https://hub.docker.com/_/ubuntu/)
- [debian](https://hub.docker.com/_/debian/)
- [centos](https://hub.docker.com/_/centos/)

## How to Use

The example Dockerfile is as follows.

```
##
## init (for download only)
##
FROM alpine AS init

RUN wget -O /tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-static-amd64 && \
    chmod +x /tini

RUN wget -O /tiny-rc https://github.com/madogiwa/tiny-rc/releases/download/v0.1.6/tiny-rc && \
    chmod +x /tiny-rc


##
## main
##
FROM debian

# Tiny-rc cannot use as PID 1.
# You need specifiy any init program into ENTRYPOINT.
COPY --from=init /tini /tini
COPY --from=init /tiny-rc /tiny-rc
ENTRYPOINT ["/tini", "--", "/tiny-rc"]
COPY tiny-rc.d /tiny-rc.d

# Your app or service is specified into CMD.
COPY main_service /app/main_service 
CMD ["/app/main_service"]
```

The tiny-rc does following steps.

1. execute `*.unit` in `$TINYRC_INIT_DIR`.
3. start `*.service` in `$TINYRC_INIT_DIR` as background process.
4. execute `CMD`.
5. wait until any `*.service` or `CMD` exited. ('liveness probe')
6. send `$TINYRC_SHUTDOWN_SIGNAL` to all `*.service` and `CMD`.
7. wait until all `*.service` and `CMD` exited. ('shutdown probe')

- Default `$TINYRC_INIT_DIR` is `/tiny-rc.d`.
- Defalut `$TINYRC_SHUTDOWN_SIGNAL` is `TERM`.


## Environments

You can customize behavior using environment value.

|name|default value|description|
|---|---|---|
|TINYRC_INIT_DIR|/tiny-rc.d|directory path|
|TINYRC_LIVENESS_PROBE_INTERVAL|1|interval of 'liveness probe'|
|TINYRC_SHUTDOWN_PROBE_INTERVAL|1|interval of 'shutdown probe'|
|TINYRC_SHUTDOWN_TIMEOUT|90|send SIGTERM to PID 1 and exit tiny-rc when 'shutdown probe' timeout exceed.|
|TINYRC_SHUTDOWN_SIGNAL|TERM|signal type which is sent after 'liveness probe' finished.|
|TINYRC_DISABLE_LOGGING|(undef)|disable logging|
|TINYRC_LOG_LEVEL|5|log level (3=ERROR, 5=WARN, 7=INFO, 9=DEBUG)|
