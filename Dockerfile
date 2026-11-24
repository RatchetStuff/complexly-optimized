FROM docker.io/library/golang:alpine AS builder
RUN go install github.com/packwiz/packwiz@latest

FROM docker.io/library/alpine:latest
RUN apk add --no-cache bash git
COPY --from=builder /go/bin/packwiz /usr/local/bin/packwiz

WORKDIR /root/src
