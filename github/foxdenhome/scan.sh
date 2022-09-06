#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=FoxDenHome driftctl scan -f 'tfstate+s3://foxden-terraform/github-foxdenhome.tfstate' -t 'github+tf'
