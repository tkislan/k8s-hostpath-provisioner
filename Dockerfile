# ARG goarch
# ARG goarmv
# ARG img

# FROM golang:1.14.0-alpine3.11 as builder

# WORKDIR /go/src/src

# COPY src .

# RUN CGO_ENABLED=0 GOOS=linux GOARCH=${goarch} GOARM=${goarmv} go build -a -ldflags '-extldflags "-static"' -o hostpath-provisioner .

# FROM ${img}

# WORKDIR /

# COPY --from=builder /go/src/src/hostpath-provisioner /hostpath-provisioner

# CMD /hostpath-provisioner

ARG goarch
ARG goarmv
ARG img

FROM golang:1.14.0-buster as builder

WORKDIR /go/src/src

COPY src .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=${goarch} GOARM=${goarmv} go build -a -ldflags '-extldflags "-static"' -o hostpath-provisioner .

FROM ${img}

WORKDIR /

COPY --from=builder /go/src/src/hostpath-provisioner /hostpath-provisioner

CMD /hostpath-provisioner
