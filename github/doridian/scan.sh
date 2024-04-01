#!/bin/sh
GITHUB_OWNER=Doridian GITHUB_ORGANIZATION= driftctl scan -f 'tfstate+s3://foxden-terraform/github-doridian.tfstate' -t 'github+tf'  --tf-provider-version '6.2.1'
