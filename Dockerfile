FROM golang:1.12.0 as build

RUN go get github.com/yudai/gotty
RUN whereis gotty

FROM ubuntu:18.04
COPY --from=build /go/bin/gotty /usr/local/bin 

ARG default_username=cloudshell
ARG default_password=fargate@AWS

ENV USERNAME=${default_username}
ENV PASSWORD=${default_password}

EXPOSE 8080

ENTRYPOINT gotty -w -c $USERNAME:$PASSWORD /bin/bash
