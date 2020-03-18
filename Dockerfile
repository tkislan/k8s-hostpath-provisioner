FROM golang:1.13-buster as builder
LABEL os=linux
LABEL arch=amd64

ENV GOOS=linux
ENV GOARCH=amd64
ENV GOARM=7

WORKDIR /go/src/src

COPY src .

RUN go build -o hostpath-provisioner .

FROM multiarch/ubuntu-core:x86_64-bionic

WORKDIR /

COPY --from=builder /go/src/src/hostpath-provisioner /hostpath-provisioner

CMD /hostpath-provisioner
