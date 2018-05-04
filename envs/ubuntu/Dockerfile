
##
## init
##
FROM alpine AS init
RUN wget -O /tini `wget -O - -q https://api.github.com/repos/krallin/tini/releases/latest | grep browser_download_url | grep -E 'tini-static-amd64"$' | cut -d '"' -f 4` && \
    chmod +x /tini

COPY tiny-rc /tiny-rc


##
## main
##

FROM ubuntu

COPY --from=init /tini /tini
COPY --from=init /tiny-rc /tiny-rc
ENTRYPOINT ["/tini", "--", "/tiny-rc"]

COPY cases /cases
