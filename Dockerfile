FROM golang:1.21 as builder
WORKDIR /go/src/github.com/camptocamp/prometheus-puppetdb-exporter
COPY . .
RUN make prometheus-puppetdb-exporter

FROM alpine:3
RUN apk --update --no-cache add \
    ca-certificates \
    && rm -rf /root/.cache
COPY --from=builder /go/src/github.com/camptocamp/prometheus-puppetdb-exporter/prometheus-puppetdb-exporter /
ENTRYPOINT ["/prometheus-puppetdb-exporter"]
CMD [""]
