#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=PawNode driftctl scan -f 'tfstate+s3://foxden-terraform/github-pawnode.tfstate' -t 'github+tf'
