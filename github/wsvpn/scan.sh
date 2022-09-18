#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=WSVPN driftctl scan -f 'tfstate+s3://foxden-terraform/github-wsvpn.tfstate' -t 'github+tf'
