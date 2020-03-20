#!/bin/bash
set -x
set -e 

for i in 0 1 2 3 4; do
 folder=go1.1${i}
 mkdir -p $folder
 cat <<EOF > $folder/Dockerfile
FROM golang:1.1${i}

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin 
RUN go get -u github.com/tcnksm/ghr
EOF
 cd $folder && \
 image=arykalin/venafi-golang:1.1${i} && \
 docker build ./ -t $image && \
 docker push $image && \
 cd ..
done
