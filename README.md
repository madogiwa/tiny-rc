
This is "rc" script for Linux containers implement by shell only.
The tiny-rc supported various containers such as:

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

RUN wget -O /dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
    chmod +x /dumb-init

RUN wget -O /tiny-rc https://github.com/madogiwa/tiny-rc/releases/download/v0.1.2/tiny-rc && \
    chmod +x /tiny-rc


##
## main
##
FROM debian

# Tiny-rc cannot use as PID 1.
# You need specifiy any init program into ENTRYPOINT.
COPY --from=init /dumb-init /dumb-init
COPY --from=init /tiny-rc /tiny-rc
ENTRYPOINT ["/dumb-init", "--", "/tiny-rc"]
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

|name|defalut|description|
|---|---|---|
|TINYRC_INIT_DIR|/tiny-rc.d|directory path|
|TINYRC_LIVENESS_PROBE_INTERVAL|30|interval of 'liveness probe'|
|TINYRC_SHUTDOWN_PROBE_INTERVAL|3|interval of 'shutdown probe'|
|TINYRC_SHUTDOWN_TIMEOUT|120|send SIGTERM to PID 1 and exit tiny-rc when 'shutdown probe' timeout exceed.|
|TINYRC_SHUTDOWN_SIGNAL|TERM|signal type which is sent after 'liveness probe' finished.|
|TINYRC_DISABLE_LOGGING|(undef)|disable logging|
|TINYRC_LOG_LEVEL|5|log level (3=ERROR, 5=WARN, 7=INFO, 9=DEBUG)|
