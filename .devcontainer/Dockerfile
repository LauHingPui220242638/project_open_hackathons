# FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu
FROM ubuntu:latest

ENV PATH /usr/local/go/bin:$PATH
ENV GO_VERSION=1.21.1
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH


RUN apt-get update &&  apt-get install -y xz-utils
RUN apt-get install -y wget git gcc


RUN wget -P /tmp "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" 
RUN tar -C /usr/local -xzf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"
RUN rm "/tmp/go${GO_VERSION}.linux-amd64.tar.gz" 
    
