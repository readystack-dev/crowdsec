#!/bin/sh
# ReadyStack CrowdSec Local API entrypoint. cscli's decisions, alerts and lapi commands reach this LAPI with the
# machine credentials in /etc/crowdsec/local_api_credentials.yaml, and the image ships none. So each new container
# registers a validated machine named "localhost" with a random password (--force replaces the one an earlier
# container left in a persisted database) and writes that file, readable by the crowdsec user only.
# Arguments after the image name are passed to crowdsec.
set -e
CRED=/etc/crowdsec/local_api_credentials.yaml
mkdir -p /var/lib/crowdsec/data
# cscli refuses most commands without a hub index; this offline image has no hub, so start from an empty one
# (`cscli hub update` replaces it when the container has network access).
[ -s /etc/crowdsec/hub/.index.json ] || echo '{}' > /etc/crowdsec/hub/.index.json
if [ ! -s "$CRED" ]; then
  ( umask 077; cscli -c /etc/crowdsec/config.yaml machines add localhost --auto --force \
      --url http://127.0.0.1:8080 -f "$CRED" >/dev/null )
  echo "crowdsec: registered local machine 'localhost' for cscli (credentials in $CRED)"
fi
exec crowdsec -c /etc/crowdsec/config.yaml -no-cs "$@"
