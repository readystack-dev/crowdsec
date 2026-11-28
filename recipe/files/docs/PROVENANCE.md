# Provenance — CrowdSec (`v1.8.2-CE-ubuntu24.04-r7`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/crowdsecurity/crowdsec
- Revision built: `v1.8.2` (commit `3d369d64eb3e9ba770ed39aedc83ffd3170aef4c`)
- Source tree: `4ca9779ee0d54141de4f965230df7ff5791cc3f937a66c6ecc4e202894ca870f` over 1795 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-go`; base image `ubuntu:24.04`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795672783` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r7` — index digest `sha256:4d241271092109f3c3d1cb6023b23f0632a9e66121dddbb6fbf88cec569e73e7` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:507e3baa7d02303f47b4d5e8af70451ce47bcd454bb1775f9fed167cf2de30cb` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/crowdsec:v1.8.2-CE-ubuntu24.04-r7`

## Pinned inputs, and why

- 36 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 2, dependency versions readystack sets 17, pins in the kit's dockerfiles 9, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.trail.json`, published beside this archive and signed with the release key (`ReadyStack-crowdsec-v1.8.2-CE-ubuntu24.04-r7.trail.json.sigstore`), and readable at https://readystack.dev/products/crowdsec/trail/v1.8.2-CE-ubuntu24.04-r7.

