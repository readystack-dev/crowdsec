[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fcrowdsec-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/crowdsec) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/crowdsec)](https://hub.docker.com/r/readystack/crowdsec) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/crowdsec) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# CrowdSec: ReadyStack build kit

The offline build kit for the Docker image `readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r7`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v1.8.2-CE-ubuntu24.04-r7](https://github.com/readystack-dev/crowdsec/releases/tag/v1.8.2-CE-ubuntu24.04-r7)
- Image: [`docker.io/readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r7`](https://hub.docker.com/r/readystack/crowdsec/tags), manifest digest `sha256:507e3baa7d02303f47b4d5e8af70451ce47bcd454bb1775f9fed167cf2de30cb`
- Product page: https://readystack.dev/products/crowdsec
- Source and build recipe: https://readystack.dev/products/crowdsec/recipe
- Build trail: https://readystack.dev/products/crowdsec/trail/v1.8.2-CE-ubuntu24.04-r7
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=crowdsec

## The image

A single container running the CrowdSec Local API (LAPI) only (`crowdsec -c /etc/crowdsec/config.yaml -no-cs`), with the cscli tool beside it. The LAPI stores decisions and alerts and answers the security bouncers that ask for ban decisions and the log-processing agents that send alerts. Its database is an embedded SQLite file, /var/lib/crowdsec/data/crowdsec.db, so there is no separate database, sidecar or web UI.

## Who uses CrowdSec and why

System administrators, DevOps and SRE teams who need to spot and block attacks on internet-facing servers.

CrowdSec's Security Engine reads logs and HTTP requests, detects behaviour such as brute force and scans, and has a firewall or reverse proxy block the offending IP addresses.

A typical use: A web server's logs show constant password guessing against its login page. CrowdSec parses those logs, recognises the brute-force pattern, and a remediation component on the firewall blocks the source address, without anyone writing ban rules by hand. Attacks it reports feed a shared community blocklist.

From the upstream project's own description: https://github.com/crowdsecurity/crowdsec, https://docs.crowdsec.net/.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-28 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 96 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`crowdsec`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-27; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/crowdsec.

CrowdSec is distributed under its upstream licence (MIT); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v1.8.2-CE-ubuntu24.04-r7 release](https://github.com/readystack-dev/crowdsec/releases/tag/v1.8.2-CE-ubuntu24.04-r7): `ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.tar.gz` (482.3 MB), SHA-256 `9c87558d9d74123660eb056ac9353b6dd697dde2d61f2a4bdc77873a62d152e1`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.rebuild.json.sigstore ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.tar.gz
cd v1.8.2-CE-ubuntu24.04-r7
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/crowdsec/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
