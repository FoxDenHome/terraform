#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=foxCaves driftctl scan -f 'tfstate+s3://foxden-terraform/github-foxcaves.tfstate' -t 'github+tf'  --tf-provider-version '6.2.1'
