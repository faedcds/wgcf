FROM golang:1.17.3-alpine AS builder

WORKDIR /src
COPY . .

RUN go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "wgcf"

FROM alpine:3.14.3

WORKDIR /

COPY --from=builder "/src/wgcf" "/"

ENTRYPOINT ["/wgcf"]
