FROM library/alpine:3.19.1
ARG ASPELL_VERSION
RUN apk add aspell=${ASPELL_VERSION}
ENTRYPOINT /usr/bin/aspell
