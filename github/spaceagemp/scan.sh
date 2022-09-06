#!/bin/sh
GITHUB_OWNER= GITHUB_ORGANIZATION=SpaceAgeMP driftctl scan -f 'tfstate+s3://foxden-terraform/github-spaceagemp.tfstate' -t 'github+tf'
