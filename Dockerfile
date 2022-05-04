FROM golang:1.17 as build

WORKDIR /go/src/github.com/rancher/hello-world
RUN go mod init github.com/rancher/hello-world
COPY ./ /go/src/github.com/rancher/hello-world

RUN CGO_ENABLED=0 go build

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /go/src/github.com/rancher/hello-world/hello-world /opt/hello-world/
COPY img/* /opt/hello-world/
WORKDIR /opt/hello-world
ENTRYPOINT ["/opt/hello-world/hello-world"]
