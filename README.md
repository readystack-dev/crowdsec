# CrowdSec: ReadyStack build kit

The offline build kit for the Docker image `readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v1.8.2-CE-ubuntu24.04-r6](https://github.com/readystack-dev/crowdsec/releases/tag/v1.8.2-CE-ubuntu24.04-r6)
- Image: [`docker.io/readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6`](https://hub.docker.com/r/readystack/crowdsec/tags), manifest digest `sha256:1be80cc031999af5a8c5425f0d9e526fff90f48075ffb176294787ec5c761709`
- Product page: https://readystack.dev/products/crowdsec
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=crowdsec

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
