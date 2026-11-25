# CrowdSec v1.8.2 — ReadyStack release `v1.8.2-CE-ubuntu24.04-r6`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6` (linux/amd64). Index digest `sha256:7a5a38bf25add7b13fb73133692a3741ded4b31edd28b5e4a4971798b038b3a3` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:1be80cc031999af5a8c5425f0d9e526fff90f48075ffb176294787ec5c761709` [`TARGET_DIGEST.txt`].
- **Upstream:** CrowdSec v1.8.2 built from source at `v1.8.2` of https://github.com/crowdsecurity/crowdsec — upstream notes: https://github.com/crowdsecurity/crowdsec/releases/tag/v1.8.2 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `crowdsec`.
- **Build:** `source-rebuild-go`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v1.8.2-CE-ubuntu24.04-r5`.

## What changed in this release

- Upstream version unchanged (v1.8.2); ReadyStack rebuild.
- Minimum dependency versions ReadyStack enforces on top of upstream (raised only where upstream's own version was lower); shipped versions from the SBOM [`docs/sbom/SBOM.json`]:
  - `golang.org/x/crypto` at least `v0.58.0`: not raised, upstream already pins `v0.58.0` (shipped: `v0.58.0`)
  - `golang.org/x/net` raised from upstream's `v0.61.0` to at least `v0.62.0` (shipped: `v0.62.0`)
  - `google.golang.org/grpc` at least `v1.83.2`: not raised, upstream already pins `v1.84.0` (shipped: `v1.84.0`)
  - `github.com/getkin/kin-openapi` at least `v0.149.0`: not raised, upstream already pins `v0.151.0` (shipped: `v0.151.0`)
  - `golang.org/x/mod` at least `v0.40.0`: not raised, upstream already pins `v0.42.0` (shipped: `v0.42.0`)
  - `github.com/klauspost/compress` raised from upstream's `v1.20.1` to at least `v1.20.2` (shipped: `v1.20.2`)
- CrowdSec v1.8.2 is unchanged from the release this supersedes (v1.8.2-CE-ubuntu24.04-r5); this release rebuilds it. Changes: libssh-4 moves from 0.10.6-2ubuntu0.5 to 0.10.6-2ubuntu0.6 (USN-9187-1). Settings, ports and data volumes are those of v1.8.2-CE-ubuntu24.04-r5: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-24)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `crowdsec` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** The Local API on port 8080 and metrics on port 6060 are plain HTTP without TLS; bouncer API keys and machine passwords cross the network in clear text. Keep both ports on a private network or put a TLS proxy in front of 8080.
- **Before exposing this service:** /metrics on port 6060 answers without credentials and names your machines and bouncers; do not publish it on a public interface.
- **Before exposing this service:** Agents that register over the network stay pending until you validate them (cscli machines validate); never validate a machine you do not recognise.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:1be80cc031999af5a8c5425f0d9e526fff90f48075ffb176294787ec5c761709`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (2 authored) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /health` (200), `GET /metrics` (200); the suite checks nothing else.

## Known issues

- **high** (upstream): Unauthenticated access by default [`RSD-crowdsec-1fbb189f06`] (carried from `v1.8.1-CE-ubuntu24.04-r2`, recorded there as `RSD-crowdsec-4b36b64f26`)
- **medium** (upstream): Unauthenticated /metrics on port 6060 by default [`RSD-crowdsec-e1c42b72d9`]

## Defects fixed

- 1 problem found before release and fixed before it shipped (1 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r6
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

