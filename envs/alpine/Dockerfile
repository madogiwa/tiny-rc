
##
## init
##
FROM alpine AS init
RUN wget -O /dumb-init `wget -O - -q https://api.github.com/repos/Yelp/dumb-init/releases/latest | grep browser_download_url | grep -E '_amd64"$' | cut -d '"' -f 4` && \
    chmod +x /dumb-init

COPY tiny-rc /tiny-rc


##
## main
##

FROM alpine

COPY --from=init /dumb-init /dumb-init
COPY --from=init /tiny-rc /tiny-rc
ENTRYPOINT ["/dumb-init", "--", "/tiny-rc"]

COPY cases /cases
