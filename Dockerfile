FROM golang:1.17 as build

WORKDIR /src
RUN go mod init github.com/rancher/hello-world
COPY . .

RUN CGO_ENABLED=0 go build

FROM scratch
COPY --from=build /src/hello-world /opt/hello-world/
COPY img/* /opt/hello-world/
WORKDIR /opt/hello-world
ENTRYPOINT ["/opt/hello-world/hello-world"]
