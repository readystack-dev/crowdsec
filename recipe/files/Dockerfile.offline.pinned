# GENERATED L-009 hermetic build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned bases from BASE_IMAGE_DIGESTS.lock; vendored Go tree + debs from Dockerfile.vendor.
FROM golang:1.27.4-bookworm@sha256:4fa7c968ba93f1635670522dbb01a2c78150443e1385746924566079f36570ea AS build_crowdsec
WORKDIR /src
COPY vendored/crowdsec-src/ .
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOWORK=off GOFLAGS="-mod=vendor -buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1795543176
RUN go build -trimpath -tags "netgo osusergo expr_debug nomsgpack sqlite_modernc" -ldflags='-s -w -X github.com/crowdsecurity/go-cs-lib/version.Version=v1.8.2 -X github.com/crowdsecurity/go-cs-lib/version.Tag=3d369d6 -X github.com/crowdsecurity/crowdsec/pkg/cwversion.Codename=alphaga -X github.com/crowdsecurity/crowdsec/pkg/csconfig.defaultConfigDir=/etc/crowdsec -X github.com/crowdsecurity/crowdsec/pkg/csconfig.defaultDataDir=/var/lib/crowdsec/data' -o /crowdsec ./cmd/crowdsec && /crowdsec -version
FROM golang:1.27.4-bookworm@sha256:4fa7c968ba93f1635670522dbb01a2c78150443e1385746924566079f36570ea AS build_cscli
WORKDIR /src
COPY vendored/crowdsec-src/ .
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOWORK=off GOFLAGS="-mod=vendor -buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1795543176
RUN go build -trimpath -tags "netgo osusergo expr_debug nomsgpack sqlite_modernc" -ldflags='-s -w -X github.com/crowdsecurity/go-cs-lib/version.Version=v1.8.2 -X github.com/crowdsecurity/go-cs-lib/version.Tag=3d369d6 -X github.com/crowdsecurity/crowdsec/pkg/cwversion.Codename=alphaga -X github.com/crowdsecurity/crowdsec/pkg/csconfig.defaultConfigDir=/etc/crowdsec -X github.com/crowdsecurity/crowdsec/pkg/csconfig.defaultDataDir=/var/lib/crowdsec/data' -o /cscli ./cmd/crowdsec-cli && /cscli version
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
ARG SOURCE_DATE_EPOCH=1795543176
RUN groupadd -r crowdsec && useradd -r -g crowdsec -d /var/lib/crowdsec -m crowdsec && \
    mkdir -p /etc/crowdsec /etc/crowdsec/hub /etc/crowdsec/acquis.d /var/lib/crowdsec /var/lib/crowdsec/data && chown -R crowdsec:crowdsec /etc/crowdsec /etc/crowdsec/hub /etc/crowdsec/acquis.d /var/lib/crowdsec /var/lib/crowdsec/data && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY --from=build_crowdsec /crowdsec /usr/bin/crowdsec
COPY --from=build_cscli /cscli /usr/bin/cscli
COPY config.yaml /etc/crowdsec/config.yaml
COPY profiles.yaml /etc/crowdsec/profiles.yaml
COPY simulation.yaml /etc/crowdsec/simulation.yaml
COPY acquis.yaml /etc/crowdsec/acquis.yaml
COPY readystack-entrypoint.sh /usr/local/bin/readystack-entrypoint.sh
RUN chmod 755 /usr/bin/crowdsec; chmod 755 /usr/bin/cscli; chown crowdsec:crowdsec /etc/crowdsec/config.yaml; chown crowdsec:crowdsec /etc/crowdsec/profiles.yaml; chown crowdsec:crowdsec /etc/crowdsec/simulation.yaml; chown crowdsec:crowdsec /etc/crowdsec/acquis.yaml; chown crowdsec:crowdsec /usr/local/bin/readystack-entrypoint.sh; chmod 0755 /usr/local/bin/readystack-entrypoint.sh
LABEL org.opencontainers.image.title="CrowdSec"
LABEL org.opencontainers.image.version="v1.8.2-CE-ubuntu24.04-r6"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/crowdsecurity/crowdsec"
LABEL org.opencontainers.image.vendor="ReadyStack.dev"
LABEL readystack.product="crowdsec"
LABEL readystack.edition="CE"
LABEL readystack.build_method="source-rebuild-go"
LABEL org.opencontainers.image.revision="3d369d64eb3e9ba770ed39aedc83ffd3170aef4c"
HEALTHCHECK --interval=15s --timeout=10s --start-period=10s \
  CMD curl -fsS http://127.0.0.1:8080/health || exit 1
USER crowdsec
EXPOSE 8080 6060
ENTRYPOINT ["/usr/local/bin/readystack-entrypoint.sh"]
