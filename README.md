# CrowdSec: ReadyStack build kit

The offline build kit for the Docker image `readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v1.8.2-CE-ubuntu24.04-r6](https://github.com/readystack-dev/crowdsec/releases/tag/v1.8.2-CE-ubuntu24.04-r6)
- Image: [`docker.io/readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6`](https://hub.docker.com/r/readystack/crowdsec/tags), manifest digest `sha256:1be80cc031999af5a8c5425f0d9e526fff90f48075ffb176294787ec5c761709`
- Product page: https://readystack.dev/products/crowdsec
- Source and build recipe: https://readystack.dev/products/crowdsec/recipe
- Build trail: https://readystack.dev/products/crowdsec/trail/v1.8.2-CE-ubuntu24.04-r6
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=crowdsec

## The image

A single container running the CrowdSec Local API (LAPI) only (`crowdsec -c /etc/crowdsec/config.yaml -no-cs`), with the cscli tool beside it. The LAPI stores decisions and alerts and answers the security bouncers that ask for ban decisions and the log-processing agents that send alerts. Its database is an embedded SQLite file, /var/lib/crowdsec/data/crowdsec.db, so there is no separate database, sidecar or web UI.

## Who uses CrowdSec and why

System administrators, DevOps and SRE teams who need to spot and block attacks on internet-facing servers.

CrowdSec's Security Engine reads logs and HTTP requests, detects behaviour such as brute force and scans, and has a firewall or reverse proxy block the offending IP addresses.

A typical use: A web server's logs show constant password guessing against its login page. CrowdSec parses those logs, recognises the brute-force pattern, and a remediation component on the firewall blocks the source address, without anyone writing ban rules by hand. Attacks it reports feed a shared community blocklist.

From the upstream project's own description: https://github.com/crowdsecurity/crowdsec, https://docs.crowdsec.net/.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 96 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`crowdsec`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-24; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/crowdsec.

CrowdSec is distributed under its upstream licence (MIT); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v1.8.2-CE-ubuntu24.04-r6 release](https://github.com/readystack-dev/crowdsec/releases/tag/v1.8.2-CE-ubuntu24.04-r6): `ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r6.tar.gz` (482.3 MB), SHA-256 `b6f38732da554b1abdff0a299d0720d498af5af16ccb150abd4ebcc051d143a2`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r6.rebuild.json.sigstore ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r6.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r6.tar.gz
cd v1.8.2-CE-ubuntu24.04-r6
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r6.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/crowdsec/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
