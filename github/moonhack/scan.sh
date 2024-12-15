#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=MoonHack driftctl scan -f 'tfstate+s3://foxden-terraform/github-moonhack.tfstate' -t 'github+tf'  --tf-provider-version '6.4.0'
