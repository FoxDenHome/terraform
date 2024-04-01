#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=FoxBukkit driftctl scan -f 'tfstate+s3://foxden-terraform/github-foxbukkit.tfstate' -t 'github+tf'  --tf-provider-version '6.2.1'
